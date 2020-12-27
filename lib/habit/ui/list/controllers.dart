import 'package:meta/meta.dart';

import 'package:collection/collection.dart';
import 'package:riverpod/riverpod.dart';
import 'package:yaxxxta/habit/domain/use_cases.dart';
import 'package:yaxxxta/habit/ui/core/view_models.dart';
import '../../../core/utils/dt.dart';
import '../../../settings/domain/models.dart';
import '../../domain/db.dart';

import '../../domain/models.dart';

/// Контроллер списка привычек
class HabitListController extends StateNotifier<List<HabitListPageVM>> {
  /// Репо привычек
  final BaseHabitRepo habitRepo;

  /// Репо выполнений привычек
  final BaseHabitPerformingRepo habitPerformingRepo;

  final CreatePerforming createPerforming;

  /// Настроечки
  final Settings settings;

  /// @nodoc
  HabitListController({
    this.habitRepo,
    this.habitPerformingRepo,
    this.settings,
    this.createPerforming,
  }) : super([]);

  /// Грузит привычки из бд
  void loadHabits({DateTime date}) {
    date = date ?? DateTime.now();
    var dateStart = buildDateTime(date, settings.dayStartTime);
    var dateEnd = buildDateTime(date, settings.dayEndTime);

    var performings = habitPerformingRepo.list(dateStart, dateEnd);
    var habitPerformings = groupBy<HabitPerforming, int>(
      performings,
      (p) => p.habitId,
    );

    state = habitRepo
        .list()
        .where((h) => h.matchDate(date))
        .map((h) => HabitListPageVM.build(h, habitPerformings[h.id] ?? []))
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

  /// Создает или обновляет привычку
  Future<void> createOrUpdateHabit(Habit habit) async {
    if (habit.isUpdate) {
      await habitRepo.update(habit);
      state = [
        for (var vm in state)
          if (vm.id == habit.id) HabitListPageVM.build(habit) else vm
      ];
    } else {
      habit = habit.copyWith(id: await habitRepo.insert(habit));
      state = [...state, HabitListPageVM.build(habit)];
    }
  }
}
