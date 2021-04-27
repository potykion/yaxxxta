import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:yaxxxta/logic/habit/db.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/vms.dart';

class HabitController extends StateNotifier<List<HabitVM>> {
  final FirebaseHabitRepo habitRepo;
  final FirebaseHabitPerformingRepo habitPerformingRepo;

  HabitController(this.habitRepo, this.habitPerformingRepo) : super([]);

  Future<void> load(String userId) async {
    var habits = await habitRepo.listByUserId(userId);
    var performings = groupBy<HabitPerforming, String>(
      await habitPerformingRepo.list(),
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
    var performing = HabitPerforming.blank(habit.id!, performDatetime);
    performing = performing.copyWith(
      id: await habitPerformingRepo.insert(performing),
    );

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
  (ref) {
    return ref
        .watch(habitControllerProvider)
        .where((vm) => !vm.habit.archived)
        .toList()
          ..sort((vm1, vm2) => vm1.habit.order.compareTo(vm2.habit.order));
  },
);
