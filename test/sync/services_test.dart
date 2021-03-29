import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yaxxxta/logic/habit/db.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/reward/db.dart';
import 'package:yaxxxta/logic/reward/models.dart';
import 'package:yaxxxta/logic/sync/services.dart';
import 'package:yaxxxta/logic/user/db.dart';
import 'package:yaxxxta/logic/user/models.dart';

class MockFirebaseUserDataRepo extends Mock implements FirebaseUserDataRepo {}

class MockFirebaseHabitRepo extends Mock implements FirebaseHabitRepo {}

class MockFirebaseHabitPerformingRepo extends Mock
    implements FirebaseHabitPerformingRepo {}

class MockFirebaseRewardRepo extends Mock implements FirebaseRewardRepo {}

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
    var hiveHabitPerformingRepoBox =
        await Hive.openBox<Map>("HiveHabitPerformingRepo_test");
    var hiveRewardRepoBox = await Hive.openBox<Map>("HiveRewardRepo_test");

    await hiveUserDataRepoBox.clear();
    await hiveHabitRepoBox.clear();
    await hiveHabitPerformingRepoBox.clear();
    await hiveRewardRepoBox.clear();

    hiveUserDataRepo = HiveUserDataRepo(hiveUserDataRepoBox);
    hiveHabitRepo = HiveHabitRepo(hiveHabitRepoBox);
    hiveHabitPerformingRepo =
        HiveHabitPerformingRepo(hiveHabitPerformingRepoBox);
    hiveRewardRepo = HiveRewardRepo(hiveRewardRepoBox);

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
    when(() => fbHabitPerformingRepo.listByHabits(any()))
        .thenAnswer((_) async => [fbHabitPerforming]);
    when(() => fbRewardRepo.listByIds(any()))
        .thenAnswer((_) async => [fbReward]);

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
    when(() => fbHabitPerformingRepo.listByHabits(any()))
        .thenAnswer((_) async => [fbHabitPerforming]);
    when(() => fbRewardRepo.listByIds(any()))
        .thenAnswer((_) async => [fbReward]);

    await firebaseToHiveSync(userId: "1");
    await firebaseToHiveSync(userId: "1");

    expect(hiveUserDataRepo.box.length, 1);
    expect(hiveHabitRepo.box.length, 1);
    expect(hiveHabitPerformingRepo.box.length, 1);
    expect(hiveRewardRepo.box.length, 1);
  });
}
