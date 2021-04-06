// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:tuple/tuple.dart';
// import 'package:yaxxxta/logic/core/utils/dt.dart';
// import 'package:yaxxxta/logic/habit/controllers.dart';
// import 'package:yaxxxta/logic/habit/db.dart';
// import 'package:yaxxxta/logic/habit/models.dart';
// import 'package:yaxxxta/logic/habit/services/services.dart';
// import 'package:yaxxxta/logic/habit/stats/models.dart';
// import 'package:yaxxxta/logic/user/models.dart';
//
// class MockHabitPerformingRepo extends Mock implements HabitPerformingRepo {}
//
// class MockHabitRepo extends Mock implements HabitRepo {}
//
// void main() {
//   group("NewHabitPerformingController", () {
//     late HabitPerformingRepo hpRepo;
//     late HabitRepo habitRepo;
//     late AppSettings settings;
//     late DateTime date;
//     late DateRange dateRange;
//     late Tuple2<DateTime, DateTime> settingsDayTimes;
//     late Habit habit;
//
//     setUpAll(() {
//       registerFallbackValue<DateTime>(DateTime.now());
//       registerFallbackValue<Habit>(Habit.blank());
//     });
//
//     setUp(() {
//       hpRepo = MockHabitPerformingRepo();
//       habitRepo = MockHabitRepo();
//       settings = AppSettings.blank();
//       date = DateTime(2020, 1, 1);
//       settingsDayTimes = Tuple2(settings.dayStartTime, settings.dayEndTime);
//       dateRange = DateRange.fromDateAndTimes(
//         date,
//         settings.dayStartTime,
//         settings.dayEndTime,
//       );
//
//       createHabitPerforming = CreateHabitPerforming(
//         hpRepo: hpRepo,
//         habitRepo: habitRepo,
//         settingsDayTimes: settingsDayTimes,
//         increaseUserPerformingPoints: () async {},
//       );
//       habit = Habit.blank();
//     });
//
//     test("loadDateHabitPerformings", () async {
//       var hp = HabitPerforming(
//         id: "hp",
//         habitId: "sam",
//         performValue: 1,
//         performDateTime: DateTime(2020, 1, 1, 11),
//       );
//       when(() => hpRepo.list(dateRange.from, dateRange.to))
//           .thenAnswer((_) async => [hp]);
//       var controller = HabitPerformingController(
//         repo: hpRepo,
//         settingsDayTimes: settingsDayTimes,
//         createHabitPerforming: createHabitPerforming,
//       );
//
//       await controller.loadDateHabitPerformings(date);
//
//       expect(
//         controller.debugState.data!.value,
//         {
//           DateTime(2020, 1, 1): [hp]
//         },
//       );
//     });
//
//     test("loadDateHabitPerformings if date exists", () async {
//       var hp1 = HabitPerforming(
//         id: "hp1",
//         habitId: "sam",
//         performValue: 1,
//         performDateTime: DateTime(2020, 1, 1, 11),
//       );
//       var hp2 = HabitPerforming(
//         id: "hp2",
//         habitId: "sam",
//         performValue: 2,
//         performDateTime: DateTime(2020, 1, 1, 12),
//       );
//       when(() => hpRepo.list(dateRange.from, dateRange.to))
//           .thenAnswer((_) async => [hp1]);
//       var controller = HabitPerformingController(
//         repo: hpRepo,
//         settingsDayTimes: settingsDayTimes,
//         createHabitPerforming: createHabitPerforming,
//         state: {
//           DateTime(2020, 1, 1): [hp2]
//         },
//       );
//
//       await controller.loadDateHabitPerformings(date);
//
//       expect(
//         controller.debugState.data!.value,
//         {
//           DateTime(2020, 1, 1): [hp2, hp1]
//         },
//       );
//     });
//
//     test("loadDateHabitPerformings if habit with id exists", () async {
//       var hp1 = HabitPerforming(
//         id: "hp",
//         habitId: "sam",
//         performValue: 1,
//         performDateTime: DateTime(2020, 1, 1, 11),
//       );
//       var hp2 = HabitPerforming(
//         id: "hp",
//         habitId: "sam",
//         performValue: 2,
//         performDateTime: DateTime(2020, 1, 1, 12),
//       );
//       when(() => hpRepo.list(dateRange.from, dateRange.to))
//           .thenAnswer((_) async => [hp1]);
//       var controller = HabitPerformingController(
//         repo: hpRepo,
//         settingsDayTimes: settingsDayTimes,
//         createHabitPerforming: createHabitPerforming,
//         state: {
//           DateTime(2020, 1, 1): [hp2]
//         },
//       );
//
//       await controller.loadDateHabitPerformings(date);
//
//       expect(
//         controller.debugState.data!.value,
//         {
//           DateTime(2020, 1, 1): [hp2]
//         },
//       );
//     });
//     //
//     test("loadSelectedHabitPerformings", () async {
//       var hp1 = HabitPerforming(
//         id: "hp1",
//         habitId: "sam",
//         performValue: 1,
//         performDateTime: DateTime(2020, 1, 1, 11),
//       );
//       var hp2 = HabitPerforming(
//         id: "hp2",
//         habitId: "sam",
//         performValue: 2,
//         performDateTime: DateTime(2020, 1, 2, 12),
//       );
//       when(() => hpRepo.listByHabit(hp1.habitId))
//           .thenAnswer((_) async => [hp1, hp2]);
//       var controller = HabitPerformingController(
//         repo: hpRepo,
//         settingsDayTimes: settingsDayTimes,
//         createHabitPerforming: createHabitPerforming,
//       );
//
//       await controller.loadSelectedHabitPerformings(hp1.habitId);
//
//       expect(
//         controller.debugState.data!.value,
//         {
//           DateTime(2020, 1, 1): [hp1],
//           DateTime(2020, 1, 2): [hp2],
//         },
//       );
//     });
//
//     test("insert", () async {
//       var hp1 = HabitPerforming(
//         habitId: "sam",
//         performValue: 1,
//         performDateTime: DateTime(2020, 1, 1, 11),
//       );
//       when(() => habitRepo.update(any())).thenAnswer((_) async {});
//       when(() => hpRepo.insert(hp1)).thenAnswer((_) async => "hp1");
//       when(() =>
//               hpRepo.checkHabitPerformingExistInDateRange(any(), any(), any()))
//           .thenAnswer((_) async => true);
//       var controller = HabitPerformingController(
//         repo: hpRepo,
//         settingsDayTimes: settingsDayTimes,
//         createHabitPerforming: createHabitPerforming,
//       );
//
//       await controller.insert(habit, hp1);
//
//       expect(
//         controller.debugState.data!.value,
//         {
//           DateTime(2020, 1, 1): [hp1.copyWith(id: "hp1")],
//         },
//       );
//     });
//
//     test("deleteForDateTime", () async {
//       var hp1 = HabitPerforming(
//         id: "hp1",
//         habitId: "sam",
//         performValue: 1,
//         performDateTime: DateTime(2020, 1, 1, 11),
//       );
//       when(() =>
//               hpRepo.checkHabitPerformingExistInDateRange(any(), any(), any()))
//           .thenAnswer((_) async => true);
//       when(() => hpRepo.delete(any(), any(), any())).thenAnswer((_) async {});
//       var controller = HabitPerformingController(
//           repo: hpRepo,
//           settingsDayTimes: settingsDayTimes,
//           createHabitPerforming: createHabitPerforming,
//           state: {
//             DateTime(2020, 1, 1): [hp1],
//           });
//
//       await controller.deleteForDateTime(hp1.habitId, hp1.performDateTime);
//
//       expect(
//         controller.debugState.data!.value,
//         {
//           DateTime(2020, 1, 1): <HabitPerforming>[],
//         },
//       );
//     });
//
//     test("update", () async {
//       var hp1 = HabitPerforming(
//         habitId: "sam",
//         performValue: 1,
//         performDateTime: DateTime(2020, 1, 1, 11),
//       );
//       when(() => habitRepo.update(any())).thenAnswer((_) async {});
//       when(() => hpRepo.insert(hp1)).thenAnswer((_) async => "hp1");
//       when(() =>
//               hpRepo.checkHabitPerformingExistInDateRange(any(), any(), any()))
//           .thenAnswer((_) async => true);
//       when(() => hpRepo.delete(any(), any(), any())).thenAnswer((_) async {});
//       var controller = HabitPerformingController(
//         repo: hpRepo,
//         settingsDayTimes: settingsDayTimes,
//         createHabitPerforming: createHabitPerforming,
//         state: {
//           DateTime(2020, 1, 1): [hp1]
//         },
//       );
//
//       await controller.update(habit, hp1);
//
//       expect(
//         controller.debugState.data!.value,
//         {
//           DateTime(2020, 1, 1): [hp1.copyWith(id: "hp1")],
//         },
//       );
//     });
//
//     test("insert updates habit stats", () async {
//       var hp1 = HabitPerforming(
//         habitId: "sam",
//         performValue: 1,
//         performDateTime: DateTime.now(),
//       );
//       when(() => habitRepo.update(any())).thenAnswer((_) async {});
//       when(() => hpRepo.insert(hp1)).thenAnswer((_) async => "hp1");
//       when(() =>
//               hpRepo.checkHabitPerformingExistInDateRange(any(), any(), any()))
//           .thenAnswer((_) async => true);
//       var controller = HabitPerformingController(
//         repo: hpRepo,
//         settingsDayTimes: settingsDayTimes,
//         createHabitPerforming: createHabitPerforming,
//       );
//
//       await controller.insert(habit, hp1);
//
//       final updatedHabit =
//           verify(() => habitRepo.update(captureAny())).captured.last as Habit;
//
//       expect(
//         updatedHabit.stats,
//         HabitStats(
//           maxStrike: 1,
//           currentStrike: 1,
//           lastPerforming: hp1.performDateTime.date(),
//         ),
//       );
//     });
//   });
// }
