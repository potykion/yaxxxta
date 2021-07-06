import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/db.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/notifications/daily.dart';

class HabitController extends StateNotifier<List<HabitVM>> {
  final FirebaseHabitRepo habitRepo;
  final FirebaseHabitPerformingRepo habitPerformingRepo;

  HabitController(this.habitRepo, this.habitPerformingRepo) : super([]);

  Future<void> load(String userId) async {
    var habits = await habitRepo.listByUserId(userId);
    var performings = groupBy<HabitPerforming, String>(
      await habitPerformingRepo.listSortedByCreatedAndFilterByUserId(userId),
      (hp) => hp.habitId,
    );
    state = habits
        .map(
          (h) => HabitVM(
            habit: h,
            performings: performings[h.id!] ?? [],
          ),
        )
        .toList();
  }

  Future<void> create(Habit habit) async {
    habit = habit.copyWith(id: await habitRepo.insert(habit));
    state = [...state, HabitVM(habit: habit)];
  }

  Future<void> update(Habit habit) async {
    await habitRepo.update(habit);
    var habitToUpdate = state.where((vm) => vm.habit.id == habit.id).first;
    state = [
      ...state.where((vm) => vm.habit.id != habit.id),
      habitToUpdate.copyWith(habit: habit),
    ];
  }

  Future<void> perform(Habit habit, [DateTime? performDatetime]) async {
    performDatetime = performDatetime ?? DateTime.now();
    var performing = HabitPerforming.blank(
      habit.id!,
      habit.userId,
      performDatetime,
    );
    performing = performing.copyWith(
      id: await habitPerformingRepo.insert(performing),
    );

    /// Если дата выполнения сегодняшняя,
    /// то отменяем уведомление + создаем новое
    if (performDatetime.isToday() && habit.notification != null) {
      DailyHabitPerformNotifications.remove(habit.notification!.id);
      var atDateTime = habit.notification!.time.setTomorrow();
      var notificationId = await DailyHabitPerformNotifications.create(
        habit,
        atDateTime,
      );
      await update(
        habit.copyWith(
          notification: HabitNotificationSettings(
            id: notificationId,
            time: atDateTime,
          ),
        ),
      );
    }

    var vm = state.where((vm) => vm.habit.id == habit.id).first;
    state = [
      ...state.where((vm) => vm.habit.id != habit.id),
      vm.copyWith(performings: [...vm.performings, performing]),
    ];
  }

  Future<void> reorder(
    Map<String, int> habitNewOrders,
  ) async {
    await habitRepo.reorder(habitNewOrders);
    var newState = <HabitVM>[];
    for (var vm in state) {
      if (habitNewOrders.containsKey(vm.habit.id)) {
        vm = vm.copyWith(
          habit: vm.habit.copyWith(
            order: habitNewOrders[vm.habit.id]!,
          ),
        );
      }
      newState.add(vm);
    }

    state = newState;
  }

  Future<void> archive(Habit habit) async {
    await update(habit.copyWith(archived: true));
  }

  Future<void> delete(Habit habit) async {
    await habitPerformingRepo.deleteById(habit.id!);
    state = [...state.where((vm) => vm.habit.id != habit.id!)];
  }
}

var habitControllerProvider =
    StateNotifierProvider<HabitController, List<HabitVM>>(
  (ref) => HabitController(
    FirebaseHabitRepo(
      FirebaseFirestore.instance.collection("FirebaseHabitRepo"),
      FirebaseFirestore.instance.batch,
    ),
    FirebaseHabitPerformingRepo(
      FirebaseFirestore.instance.collection("FirebaseHabitPerformingRepo"),
    ),
  ),
);

var habitVMsProvider = Provider(
  (ref) => ref
      .watch(habitControllerProvider)
      .where((vm) => !vm.habit.archived)
      .toList()
        ..sort((vm1, vm2) => vm1.habit.order.compareTo(vm2.habit.order)),
);

var archivedHabitVMsProvider = Provider(
  (ref) => ref
      .watch(habitControllerProvider)
      .where((vm) => vm.habit.archived)
      .toList(),
);

int getNextUnperformedHabitIndex(
  List<HabitVM> habits, {
  int initialIndex = 0,
  bool includeInitial = false,
}) {
  var index = habits.indexWhere(
    (h) => !h.isPerformedToday,
    includeInitial ? initialIndex : (initialIndex + 1) % habits.length,
  );
  return index == -1 ? habits.indexWhere((h) => !h.isPerformedToday) : index;
}

int getPreviousUnperformedHabitIndex(
  List<HabitVM> habits, {
  int initialIndex = 0,
  bool includeInitial = false,
}) {
  if (includeInitial) {
    if (!habits[initialIndex].isPerformedToday) return initialIndex;
  }

  var index = -1;

  index = habits
      .sublist(0, initialIndex)
      .lastIndexWhere((h) => !h.isPerformedToday);

  if (index == -1) {
    index = habits.lastIndexWhere((h) => !h.isPerformedToday);
  }

  return index;
}
