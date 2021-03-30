import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart'
    show MockFirestoreInstance;
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yaxxxta/logic/habit/db.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/reward/db.dart';
import 'package:yaxxxta/logic/reward/models.dart';
import 'package:yaxxxta/logic/sync/services.dart'
    show FirebaseToHiveSync, Source;
import 'package:yaxxxta/logic/user/db.dart';
import 'package:yaxxxta/logic/user/models.dart';

// ignore_for_file: lines_longer_than_80_chars
// @formatter:off

class MockFirebaseUserDataRepo extends Mock implements FirebaseUserDataRepo {}

class MockFirebaseHabitRepo extends Mock implements FirebaseHabitRepo {}

class MockFirebaseHabitPerformingRepo extends Mock implements FirebaseHabitPerformingRepo {}

class MockFirebaseRewardRepo extends Mock implements FirebaseRewardRepo {}

class MockHiveUserDataRepo extends Mock implements HiveUserDataRepo {}

class MockHiveHabitRepo extends Mock implements HiveHabitRepo {}

class MockHiveHabitPerformingRepo extends Mock implements HiveHabitPerformingRepo {}

class MockHiveRewardRepo extends Mock implements HiveRewardRepo {}

void main() {
  late FirebaseUserDataRepo fbUserDataRepo;
  late FirebaseHabitRepo fbHabitRepo;
  late FirebaseHabitPerformingRepo fbHabitPerformingRepo;
  late FirebaseRewardRepo fbRewardRepo;

  late HiveUserDataRepo hiveUserDataRepo;
  late HiveHabitRepo hiveHabitRepo;
  late HiveHabitPerformingRepo hiveHabitPerformingRepo;
  late HiveRewardRepo hiveRewardRepo;

  late FirebaseToHiveSync firebaseToHiveSync;

  group("firebase > hive sync", () {
    setUpAll(() {
      Hive.init("test");
    });

    tearDownAll(Hive.deleteFromDisk);

    setUp(() async {
      fbUserDataRepo = MockFirebaseUserDataRepo();
      fbHabitRepo = MockFirebaseHabitRepo();
      fbHabitPerformingRepo = MockFirebaseHabitPerformingRepo();
      fbRewardRepo = MockFirebaseRewardRepo();

      var hiveUserDataRepoBox = await Hive.openBox<Map>("HiveUserDataRepo_test");
      var hiveHabitRepoBox = await Hive.openBox<Map>("HiveHabitRepo_test");
      var hiveHabitPerformingRepoBox = await Hive.openBox<Map>("HiveHabitPerformingRepo_test");
      var hiveRewardRepoBox = await Hive.openBox<Map>("HiveRewardRepo_test");

      await hiveUserDataRepoBox.clear();
      await hiveHabitRepoBox.clear();
      await hiveHabitPerformingRepoBox.clear();
      await hiveRewardRepoBox.clear();

      hiveUserDataRepo = HiveUserDataRepo(hiveUserDataRepoBox);
      hiveHabitRepo = HiveHabitRepo(hiveHabitRepoBox);
      hiveHabitPerformingRepo = HiveHabitPerformingRepo(hiveHabitPerformingRepoBox);
      hiveRewardRepo = HiveRewardRepo(hiveRewardRepoBox);

      hiveUserDataRepo.insert(UserData.blank());

      firebaseToHiveSync = FirebaseToHiveSync(
        fbUserDataRepo: fbUserDataRepo,
        fbHabitRepo: fbHabitRepo,
        fbHabitPerformingRepo: fbHabitPerformingRepo,
        fbRewardRepo: fbRewardRepo,
        hiveUserDataRepo: hiveUserDataRepo,
        hiveHabitRepo: hiveHabitRepo,
        hiveHabitPerformingRepo: hiveHabitPerformingRepo,
        hiveRewardRepo: hiveRewardRepo,
      );
    });

    test("FirebaseToHiveSync", () async {
      var fbUserData = UserData.blank().copyWith(id: "1");
      var fbHabit = Habit.blank().copyWith(id: "2");
      var fbHabitPerforming =
          HabitPerforming.blank(habitId: "2").copyWith(id: "3");
      var fbReward = Reward(cost: 1, title: "ass", id: "4");

      when(() => fbUserDataRepo.getByUserId(any())).thenAnswer((_) async => fbUserData);
      when(() => fbHabitRepo.listByIds(any())).thenAnswer((_) async => [fbHabit]);
      when(() => fbHabitPerformingRepo.listByHabits(any())).thenAnswer((_) async => [fbHabitPerforming]);
      when(() => fbRewardRepo.listByIds(any())).thenAnswer((_) async => [fbReward]);

      await firebaseToHiveSync(userId: "1");

      expect(hiveUserDataRepo.box.length, 1);
      expect(hiveHabitRepo.box.length, 1);
      expect(hiveHabitPerformingRepo.box.length, 1);
      expect(hiveRewardRepo.box.length, 1);
    });

    test("вызов FirebaseToHiveSync дважды не вставляет данные в hive дважды",
        () async {
      var fbUserData = UserData.blank().copyWith(id: "1");
      var fbHabit = Habit.blank().copyWith(id: "2");
      var fbHabitPerforming =
          HabitPerforming.blank(habitId: "2").copyWith(id: "3");
      var fbReward = Reward(cost: 1, title: "ass", id: "4");

      when(() => fbUserDataRepo.getByUserId(any())).thenAnswer((_) async => fbUserData);
      when(() => fbHabitRepo.listByIds(any())).thenAnswer((_) async => [fbHabit]);
      when(() => fbHabitPerformingRepo.listByHabits(any())).thenAnswer((_) async => [fbHabitPerforming]);
      when(() => fbRewardRepo.listByIds(any())).thenAnswer((_) async => [fbReward]);

      await firebaseToHiveSync(userId: "1");
      await firebaseToHiveSync(userId: "1");

      expect(hiveUserDataRepo.box.length, 1);
      expect(hiveHabitRepo.box.length, 1);
      expect(hiveHabitPerformingRepo.box.length, 1);
      expect(hiveRewardRepo.box.length, 1);
    });
  });

  group("hive > firebase sync", () {
    setUp(() async {
      var instance = MockFirestoreInstance();

      // Удаляем все
      await Future.wait((await instance.collection('FirebaseUserDataRepo').get()).docs.map((d) => d.reference.delete()));
      await Future.wait((await instance.collection('FirebaseHabitRepo').get()).docs.map((d) => d.reference.delete()));
      await Future.wait((await instance.collection('FirebaseHabitPerformingRepo').get()).docs.map((d) => d.reference.delete()));
      await Future.wait((await instance.collection('FirebaseRewardRepo').get()).docs.map((d) => d.reference.delete()));

      fbUserDataRepo = FirebaseUserDataRepo(instance.collection('FirebaseUserDataRepo'), instance.batch);
      fbHabitRepo = FirebaseHabitRepo(instance.collection('FirebaseHabitRepo'), instance.batch);
      fbHabitPerformingRepo = FirebaseHabitPerformingRepo(instance.collection('FirebaseHabitPerformingRepo'), instance.batch);
      fbRewardRepo = FirebaseRewardRepo(instance.collection('FirebaseRewardRepo'), instance.batch);

      hiveUserDataRepo = MockHiveUserDataRepo();
      hiveHabitRepo = MockHiveHabitRepo();
      hiveHabitPerformingRepo = MockHiveHabitPerformingRepo();
      hiveRewardRepo = MockHiveRewardRepo();

      firebaseToHiveSync = FirebaseToHiveSync(
        fbUserDataRepo: fbUserDataRepo,
        fbHabitRepo: fbHabitRepo,
        fbHabitPerformingRepo: fbHabitPerformingRepo,
        fbRewardRepo: fbRewardRepo,
        hiveUserDataRepo: hiveUserDataRepo,
        hiveHabitRepo: hiveHabitRepo,
        hiveHabitPerformingRepo: hiveHabitPerformingRepo,
        hiveRewardRepo: hiveRewardRepo,
      );
    });

    test("Обычный кейс", () async {
      await fbUserDataRepo.insert(UserData.blank(userId: "1"));

      var fromUserData = UserData.blank().copyWith(id: "1");
      var fromHabit = Habit.blank().copyWith(id: "2");
      var fromHabitPerforming = HabitPerforming.blank(habitId: "2").copyWith(id: "3");
      var fromReward = Reward(cost: 1, title: "ass", id: "4");

      when(() => hiveUserDataRepo.first()).thenAnswer((_) async => fromUserData);
      when(() => hiveHabitRepo.listByIds(any())).thenAnswer((_) async => [fromHabit]);
      when(() => hiveHabitPerformingRepo.listByHabits(any())).thenAnswer((_) async => [fromHabitPerforming]);
      when(() => hiveRewardRepo.listByIds(any())).thenAnswer((_) async => [fromReward]);

      await firebaseToHiveSync(
        userId: "1",
        from: Source.hive,
        to: Source.firebase,
      );

      expect((await fbUserDataRepo.collectionReference.get()).docs.length, 1);
      expect((await fbHabitRepo.collectionReference.get()).docs.length, 1);
      expect((await fbHabitPerformingRepo.collectionReference.get()).docs.length, 1);
      expect((await fbRewardRepo.collectionReference.get()).docs.length, 1);
    });

    test("Кейс, когда чет есть уже", () async {
      var habitId = await fbHabitRepo.insert(Habit.blank());
      var fbUserId = "1";
      await fbUserDataRepo.insert(UserData.blank(userId: fbUserId, habitIds: [habitId]));

      var fromUserData = UserData.blank().copyWith(id: "1");
      var fromHabit = Habit.blank().copyWith(id: "2");
      var fromHabitPerforming = HabitPerforming.blank(habitId: "2").copyWith(id: "3");
      var fromReward = Reward(cost: 1, title: "ass", id: "4");

      when(() => hiveUserDataRepo.first()).thenAnswer((_) async => fromUserData);
      when(() => hiveHabitRepo.listByIds(any())).thenAnswer((_) async => [fromHabit]);
      when(() => hiveHabitPerformingRepo.listByHabits(any())).thenAnswer((_) async => [fromHabitPerforming]);
      when(() => hiveRewardRepo.listByIds(any())).thenAnswer((_) async => [fromReward]);

      await firebaseToHiveSync(
        userId: fbUserId,
        from: Source.hive,
        to: Source.firebase,
      );

      expect((await fbUserDataRepo.getByUserId(fbUserId))!.habitIds.length, 2);
      expect((await fbHabitRepo.collectionReference.get()).docs.length, 2);
    });
  });
}
