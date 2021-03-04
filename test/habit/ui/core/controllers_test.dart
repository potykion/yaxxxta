// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:yaxxxta/habit/domain/db.dart';
// import 'package:yaxxxta/habit/domain/models.dart';
// import 'package:yaxxxta/habit/ui/core/controllers.dart';
// import 'package:yaxxxta/settings/domain/models.dart';
//
// class MockHabitPerformingRepo extends Mock implements BaseHabitPerformingRepo {}
//
// void main() {
//   group("NewHabitPerformingController", () {
//     BaseHabitPerformingRepo repo;
//
//     setUp(() {
//       repo = MockHabitPerformingRepo();
//     });
//
//     test("loadDateHabitPerformings", () async {
//       var hp = HabitPerforming(
//         id: "hp",
//         habitId: "sam",
//         performValue: 1,
//         performDateTime: DateTime(2020, 1, 1, 11),
//       );
//       when(repo.list(any, any)).thenAnswer((_) async => [hp]);
//       var controller = HabitPerformingController(
//         repo: repo,
//         settings: Settings.createDefault(),
//       );
//
//       await controller.loadDateHabitPerformings(DateTime(2020, 1, 1));
//
//       expect(
//         controller.debugState.data.value,
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
//       when(repo.list(any, any)).thenAnswer((_) async => [hp1]);
//       var controller = HabitPerformingController(
//         repo: repo,
//         settings: Settings.createDefault(),
//         state: {
//           DateTime(2020, 1, 1): [hp2]
//         },
//       );
//
//       await controller.loadDateHabitPerformings(DateTime(2020, 1, 1));
//
//       expect(
//         controller.debugState.data.value,
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
//       when(repo.list(any, any)).thenAnswer((_) async => [hp1]);
//       var controller = HabitPerformingController(
//         repo: repo,
//         settings: Settings.createDefault(),
//         state: {
//           DateTime(2020, 1, 1): [hp2]
//         },
//       );
//
//       await controller.loadDateHabitPerformings(DateTime(2020, 1, 1));
//
//       expect(
//         controller.debugState.data.value,
//         {
//           DateTime(2020, 1, 1): [hp2]
//         },
//       );
//     });
//
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
//       when(repo.listByHabit(any)).thenAnswer((_) async => [hp1, hp2]);
//       var controller = HabitPerformingController(
//         repo: repo,
//         settings: Settings.createDefault(),
//       );
//
//       await controller.loadSelectedHabitPerformings(hp1.habitId);
//
//       expect(
//         controller.debugState.data.value,
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
//       when(repo.insert(any)).thenAnswer((_) async => "hp1");
//       var controller = HabitPerformingController(
//         repo: repo,
//         settings: Settings.createDefault(),
//       );
//
//       await controller.insert(hp1);
//
//       expect(
//         controller.debugState.data.value,
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
//       var controller = HabitPerformingController(
//           repo: repo,
//           settings: Settings.createDefault(),
//           state: {
//             DateTime(2020, 1, 1): [hp1],
//           });
//
//       await controller.deleteForDateTime(hp1.performDateTime);
//
//       expect(
//         controller.debugState.data.value,
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
//       when(repo.insert(any)).thenAnswer((_) async => "hp1");
//       var controller = HabitPerformingController(
//         repo: repo,
//         settings: Settings.createDefault(),
//         state: {
//           DateTime(2020, 1, 1): [hp1]
//         },
//       );
//
//       await controller.update(hp1);
//
//       expect(
//         controller.debugState.data.value,
//         {
//           DateTime(2020, 1, 1): [hp1.copyWith(id: "hp1")],
//         },
//       );
//     });
//   });
// }
