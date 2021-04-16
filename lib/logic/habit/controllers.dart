import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

  Future<void> perform(Habit habit) async {
    var performing = HabitPerforming.blank(habit.id!);
    performing = performing.copyWith(
      id: await habitPerformingRepo.insert(performing),
    );

    var vm = state.where((vm) => vm.habit.id == habit.id).first;
    state = [
      ...state.where((vm) => vm.habit.id != habit.id),
      vm.copyWith(performings: [...vm.performings, performing]),
    ];
  }
}

var habitControllerProvider =
    StateNotifierProvider<HabitController, List<HabitVM>>(
  (ref) => HabitController(
    FirebaseHabitRepo(
      FirebaseFirestore.instance.collection("FirebaseHabitRepo"),
    ),
    FirebaseHabitPerformingRepo(
      FirebaseFirestore.instance.collection("FirebaseHabitPerformingRepo"),
    ),
  ),
);
