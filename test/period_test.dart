// import 'package:flutter_test/flutter_test.dart';
// import 'package:yaxxxta/habit/domain/models.dart';
//
// void main() {
//   test("Кастомная периодичность по месяцам", () {
//     var monthHabit = Habit(
//       created: DateTime(2020, 1, 1),
//       periodType: HabitPeriodType.month,
//       periodValue: 2,
//       performMonthDay: 1,
//     );
//
//     expect(monthHabit.matchDate(DateTime(2020, 1, 1)), true);
//     expect(monthHabit.matchDate(DateTime(2020, 1, 2)), false);
//     expect(monthHabit.matchDate(DateTime(2020, 2, 1)), false);
//     expect(monthHabit.matchDate(DateTime(2020, 3, 1)), true);
//   });
//
//   test("Кастомная периодичность по неделям", () {
//     var monthHabit = Habit(
//       created: DateTime(2020, 1, 1),
//       periodType: HabitPeriodType.week,
//       periodValue: 2,
//       performWeekdays: [Weekday.wednesday],
//     );
//
//     expect(monthHabit.matchDate(DateTime(2020, 1, 1)), true);
//     expect(monthHabit.matchDate(DateTime(2020, 1, 8)), false);
//     expect(monthHabit.matchDate(DateTime(2020, 1, 15)), true);
//     expect(monthHabit.matchDate(DateTime(2020, 1, 29)), true);
//   });
//
//   test("Кастомная периодичность по дням", () {
//     var monthHabit = Habit(
//       created: DateTime(2020, 1, 1),
//       periodType: HabitPeriodType.day,
//       periodValue: 2,
//     );
//
//     expect(monthHabit.matchDate(DateTime(2020, 1, 1)), true);
//     expect(monthHabit.matchDate(DateTime(2020, 1, 2)), false);
//     expect(monthHabit.matchDate(DateTime(2020, 1, 3)), true);
//     expect(monthHabit.matchDate(DateTime(2020, 1, 5)), true);
//   });
//
//   test("Кастомная периодичность по дням с кол-вом дней > 7", () {
//     var monthHabit = Habit(
//       created: DateTime(2020, 1, 1),
//       periodType: HabitPeriodType.day,
//       periodValue: 12,
//     );
//
//     expect(monthHabit.matchDate(DateTime(2020, 1, 1)), true);
//     expect(monthHabit.matchDate(DateTime(2020, 1, 13)), true);
//     expect(monthHabit.matchDate(DateTime(2020, 1, 25)), true);
//     expect(monthHabit.matchDate(DateTime(2020, 2, 6)), true);
//   });
// }
