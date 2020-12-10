import 'package:riverpod/riverpod.dart';
import 'package:yaxxxta/models.dart';
import 'package:yaxxxta/view_models.dart';

import 'db.dart';

class HabitListController extends StateNotifier<List<HabitVM>> {
  final HabitRepo repo;

  HabitListController(this.repo) : super([]);

  void loadHabits() {
    print("loadHabits");
    state = repo.list().map((h) => HabitVM.fromHabit(h)).toList();
  }

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

  Future<void> createOrUpdateHabit(Habit habit) async {
    if (habit.isUpdate) {
      await repo.update(habit);
    } else {
      habit = habit.copyWith(id: await repo.insert(habit));
    }
    state = [...state, HabitVM.fromHabit(habit)];
  }
}
