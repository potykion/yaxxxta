import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/logic/habit/models.dart';

void main() {
  late Habit vm;

  setUp(() {
    vm = Habit.blank();
  });

  test("Увеличение продолжительности на 1 час, 1 мин, 1 сек", () {
    vm = vm.copyWith(goalValue: vm.goalValue + 1 + 1 * 60 + 1 * 3600);

    expect(vm.goalValueHours, 1);
    expect(vm.goalValueMinutes, 1);
    expect(vm.goalValueSeconds, 2);
  });

  test("Увеличение продолжительности на 1 час и 2 %", () {
    vm = vm
        .copyWith(goalValue: vm.goalValue + 1 * 3600)
        .increaseGoalValueByPercent()
        .increaseGoalValueByPercent();

    expect(vm.goalValue.toStringAsFixed(2), "3673.38");
    expect(vm.goalValueHours, 1);
    expect(vm.goalValueMinutes, 1);
    expect(vm.goalValueSeconds.toStringAsFixed(2), "13.38");
  });

  test("Установка секунд после установки минут", () {
    vm = vm
        .copyWith(goalValue: vm.goalValue + 1 * 60 + 36)
        .setGoalValueSeconds(3);

    expect(vm.goalValueMinutes, 1);
    expect(vm.goalValueSeconds, 3);
  });
}
