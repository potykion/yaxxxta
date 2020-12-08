import 'package:riverpod/riverpod.dart';
import 'package:yaxxxta/view_models.dart';

// todo init HabitListController
class HabitListController extends StateNotifier<List<HabitVM>> {
  HabitListController([List<HabitVM> habitVMList]) : super(habitVMList ?? []);

  Future<void> loadHabits() async {
    // todo грузим привычки
    // todo грузим перфоминги
    // todo собираем вью-модельки
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
}
