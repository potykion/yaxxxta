import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/models.dart';

main() {
  test("Увеличение продолжительности на 1 час, 1 мин, 1 сек", () {
    var vm = Habit();

    vm.goalValue += 1;
    vm.goalValue += 1 * 60;
    vm.goalValue += 1 * 3600;

    expect(vm.goalValueHours, 1);
    expect(vm.goalValueMinutes, 1);
    expect(vm.goalValueSeconds, 1);
  });

  test("Увеличение продолжительности на 1 час и 2 %", () {
    var vm = Habit();

    vm.goalValue += 1 * 3600;
    vm.increaseGoalValueByPercent();
    vm.increaseGoalValueByPercent();

    expect(vm.goalValue.toStringAsFixed(2), "3672.36");
    expect(vm.goalValueHours, 1);
    expect(vm.goalValueMinutes, 1);
    expect(vm.goalValueSeconds, 12.36);
  });

  test("Установка секунд после установки минут", () {
    var vm = Habit();

    vm.goalValue += 1 * 60;
    vm.goalValue += 36;
    vm.setGoalValueSeconds(3);

    expect(vm.goalValueMinutes, 1);
    expect(vm.goalValueSeconds, 3);
  });
}
