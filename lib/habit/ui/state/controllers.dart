import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod/riverpod.dart';
import '../../domain/db.dart';

import '../../domain/models.dart';
import 'view_models.dart';

/// Контроллер списка привычек
class HabitListController extends StateNotifier<List<HabitVM>> {
  /// Репо привычек
  final BaseHabitRepo habitRepo;

  /// Репо выполнений привычек
  final BaseHabitPerformingRepo habitPerformingRepo;

  /// @nodoc
  HabitListController({this.habitRepo, this.habitPerformingRepo}) : super([]);

  /// Грузит привычки из бд
  void loadHabits() {
    var dateStart = DateTime.now();
    dateStart = dateStart.subtract(Duration(
        hours: dateStart.hour,
        minutes: dateStart.minute,
        seconds: dateStart.second));

    var dateEnd = dateStart.add(Duration(hours: 23, minutes: 59, seconds: 59));

    var performings = habitPerformingRepo.list(dateStart, dateEnd);
    var habitPerformings = groupBy<HabitPerforming, int>(
      performings,
      (p) => p.habitId,
    );

    state = habitRepo
        .list()
        .map((h) => HabitVM.build(h, habitPerformings[h.id] ?? []))
        .toList();
  }

  /// Инкрементирует прогресс привычки
  bool incrementHabitProgress(int id, int repeatIndex) {
    state = [
      for (var vm in state)
        if (vm.id == id)
          vm.copyWith(repeats: [
            for (var repeatWithIndex in vm.repeats.asMap().entries)
              if (repeatWithIndex.key == repeatIndex)
                repeatWithIndex.value.copyWith(
                  currentValue: repeatWithIndex.value.currentValue + 1,
                )
              else
                repeatWithIndex.value,
          ])
        else
          vm,
    ];

    var repeatComplete =
        state.where((vm) => vm.id == id).first.repeats[repeatIndex].isComplete;
    return repeatComplete;
  }

  /// Создает выполнение привычки
  Future<void> createPerforming({
    @required int habitId,
    @required int repeatIndex,
    double performValue,
    DateTime performDateTime,
  }) async {
    var performing = HabitPerforming(
        habitId: habitId,
        repeatIndex: repeatIndex,
        performValue: performValue ?? 1,
        performDateTime: performDateTime ?? DateTime.now());
    await habitPerformingRepo.insert(performing);
  }

  /// Создает или обновляет привычку
  Future<void> createOrUpdateHabit(Habit habit) async {
    if (habit.isUpdate) {
      await habitRepo.update(habit);
    } else {
      habit = habit.copyWith(id: await habitRepo.insert(habit));
    }
    state = [...state, HabitVM.build(habit)];
  }
}
