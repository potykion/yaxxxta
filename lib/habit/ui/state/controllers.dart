import 'package:riverpod/riverpod.dart';
import 'package:yaxxxta/habit/domain/db.dart';


import '../../domain/models.dart';
import 'view_models.dart';

/// Контроллер списка привычек
class HabitListController extends StateNotifier<List<HabitVM>> {
  final BaseHabitRepo _repo;

  /// @nodoc
  HabitListController(this._repo) : super([]);

  /// Грузит привычки из бд
  void loadHabits() {
    state = _repo.list().map((h) => HabitVM.fromHabit(h)).toList();
  }

  /// Инкрементирует прогресс привычки
  void incrementHabitProgress(int id, int repeatIndex) {
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
  }

  /// Создает или обновляет привычку
  Future<void> createOrUpdateHabit(Habit habit) async {
    if (habit.isUpdate) {
      await _repo.update(habit);
    } else {
      habit = habit.copyWith(id: await _repo.insert(habit));
    }
    state = [...state, HabitVM.fromHabit(habit)];
  }
}
