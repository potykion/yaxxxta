import 'package:yaxxxta/view_models.dart';

import 'models.dart';

var vms = [
  HabitVM(
    title: "Планочка",
    repeats: [
      HabitRepeat(
        performTime: DateTime(2020, 1, 1, 11),
        type: HabitType.time,
        currentValue: 60,
        goalValue: 60.0 * 2,
      ),
      HabitRepeat(
        performTime: DateTime(2020, 1, 1, 20),
        type: HabitType.time,
        currentValue: 0,
        goalValue: 60.0 * 3,
      ),
    ],
  ),
  HabitVM(
    title: "Пресс",
    repeats: [
      HabitRepeat(
        type: HabitType.repeats,
        currentValue: 50,
        goalValue: 50,
      )
    ]
  ),
  HabitVM(
    title: "Медитация",
    repeats: [
      HabitRepeat(
        type: HabitType.repeats,
        currentValue: 1,
        goalValue: 2,
      )
    ]
  ),
  HabitVM(
      title: "Аренда",
      repeats: [
        HabitRepeat(
          type: HabitType.repeats,
          currentValue: 0,
          goalValue: 1,
        )
      ]
  ),
];
