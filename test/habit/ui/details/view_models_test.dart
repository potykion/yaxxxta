import 'package:flutter_test/flutter_test.dart';
import 'package:yaxxxta/habit/domain/models.dart';
import 'package:yaxxxta/habit/ui/details/view_models.dart';

void main() {
  test("HabitDetailsVM.history", () {
    var vm = HabitHistory.fromPerformings( [
      HabitPerforming(
        habitId: "1",
        repeatIndex: 1,
        performValue: 1,
        performDateTime: DateTime(2020, 1, 1, 11, 11, 11),
      ),
      HabitPerforming(
        habitId: "1",
        repeatIndex: 1,
        performValue: 1,
        performDateTime: DateTime(2020, 1, 1, 11, 11, 12),
      ),
      HabitPerforming(
        habitId: "1",
        repeatIndex: 1,
        performValue: 1,
        performDateTime: DateTime(2020, 1, 1, 11, 12, 12),
      ),
      HabitPerforming(
        habitId: "1",
        repeatIndex: 1,
        performValue: 1,
        performDateTime: DateTime(2020, 1, 2, 11, 12, 12),
      ),
    ]);

    expect(vm.history, {
      DateTime(2020, 1, 1): [
        HabitHistoryEntry(time: DateTime(2020, 1, 1, 11, 11), value: 2),
        HabitHistoryEntry(time: DateTime(2020, 1, 1, 11, 12), value: 1),
      ],
      DateTime(2020, 1, 2): [
        HabitHistoryEntry(time: DateTime(2020, 1, 1, 11, 12), value: 1),
      ],
    });
  });
}
