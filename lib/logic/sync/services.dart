import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/db.dart';
import 'package:yaxxxta/logic/reward/db.dart';
import 'package:yaxxxta/logic/user/db.dart';

/// Вставляет фаербейз (фб) инфу в хайв
class FirebaseToHiveSync {
  /// FirebaseUserDataRepo
  final FirebaseUserDataRepo fbUserDataRepo;

  /// FirebaseHabitRepo
  final FirebaseHabitRepo fbHabitRepo;

  /// FirebaseHabitPerformingRepo
  final FirebaseHabitPerformingRepo fbHabitPerformingRepo;

  /// FirebaseRewardRepo
  final FirebaseRewardRepo fbRewardRepo;

  /// HiveUserDataRepo
  final HiveUserDataRepo hiveUserDataRepo;

  /// HiveHabitRepo
  final HiveHabitRepo hiveHabitRepo;

  /// HiveHabitPerformingRepo
  final HiveHabitPerformingRepo hiveHabitPerformingRepo;

  /// HiveRewardRepo
  final HiveRewardRepo hiveRewardRepo;

  /// Вставляет фаербейз инфу в хайв
  FirebaseToHiveSync({
    required this.fbUserDataRepo,
    required this.fbHabitRepo,
    required this.fbHabitPerformingRepo,
    required this.fbRewardRepo,
    required this.hiveUserDataRepo,
    required this.hiveHabitRepo,
    required this.hiveHabitPerformingRepo,
    required this.hiveRewardRepo,
  });

  /// Вставляет фаербейз инфу в хайв
  // todo userId должно быть String, а не String?
  Future<void> call([String? userId]) async {
    // Грузим фаербейз инфу
    var fbUserData = (userId != null
        ? await fbUserDataRepo.getByUserId(userId)
        : await fbUserDataRepo.first())!;
    fbUserData = fbUserData.copyWith(externalId: fbUserData.id);

    var fbHabits = (await fbHabitRepo.listByIds(fbUserData.habitIds))
        .map((e) => e.copyWith(externalId: e.id))
        .toList();

    var fbHabitPerformings = (await fbHabitPerformingRepo
            .listByHabits(fbHabits.map((h) => h.id!).toList()))
        .map((e) => e.copyWith(externalId: e.id))
        .toList();

    var fbRewards = (await fbRewardRepo.listByIds(fbUserData.rewardIds))
        .map((e) => e.copyWith(externalId: e.id))
        .toList();

    // Вставляем награды в хайв
    var hiveRewardIds =
        await hiveRewardRepo.insertOrUpdateManyByExternalId(fbRewards);

    // Вставляем привычки в хайв
    var hiveHabitIds =
        await hiveHabitRepo.insertOrUpdateManyByExternalId(fbHabits);

    /// Проставляем выполнениям привычек хайв айди привычки +
    /// вставляем выполнения привычек в хайв
    var fbToHiveHabitIdMap = Map<String, String>.fromIterables(
      fbHabits.map((h) => h.id!),
      hiveHabitIds,
    );
    var hiveHabitPerformingsToInsert = fbHabitPerformings
        .map((hp) => hp.copyWith(habitId: fbToHiveHabitIdMap[hp.habitId]!))
        .toList();
    await hiveHabitPerformingRepo
        .insertOrUpdateManyByExternalId(hiveHabitPerformingsToInsert);

    // Ставим айди привычек и наград в данные юзера и вставляем данные о юзере
    var hiveUserDataToInsert = fbUserData.copyWith(
      rewardIds: hiveRewardIds,
      habitIds: hiveHabitIds,
    );
    await hiveUserDataRepo
        .insertOrUpdateManyByExternalId([hiveUserDataToInsert]);
  }
}

Provider<FirebaseToHiveSync> firebaseToHiveSyncProvider =
    Provider((ref) => FirebaseToHiveSync(
          fbUserDataRepo: ref.watch(fbUserDataRepoProvider),
          fbHabitRepo: ref.watch(fbHabitRepoProvider),
          fbHabitPerformingRepo: ref.watch(fbHabitPerformingRepoProvider),
          fbRewardRepo: ref.watch(fbRewardRepoProvider),
          hiveUserDataRepo: ref.watch(hiveUserDataRepoProvider),
          hiveHabitRepo: ref.watch(hiveHabitRepoProvider),
          hiveHabitPerformingRepo: ref.watch(hiveHabitPerformingRepoProvider),
          hiveRewardRepo: ref.watch(hiveRewardRepoProvider),
        ));
