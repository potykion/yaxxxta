import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/core/db.dart';
import 'package:yaxxxta/logic/habit/db.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/reward/db.dart';
import 'package:yaxxxta/logic/reward/models.dart';
import 'package:yaxxxta/logic/user/db.dart';
import 'package:yaxxxta/logic/user/models.dart';

/// Источник откуда и куда переносятся данные
enum Source {
  /// firebase
  firebase,

  /// hive
  hive,
}

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
  Future<void> call({
    String? userId,
    Source from = Source.firebase,
    Source to = Source.hive,
  }) async {
    assert(from != to);
    // если [source] == [Source.firebase], то [userId] должен быть передан
    assert(
      from == Source.firebase && userId != null || from != Source.firebase,
    );

    var fromUserDataRepo = (from == Source.firebase
        ? fbUserDataRepo
        : hiveUserDataRepo) as UserDataRepo;
    var fromHabitRepo =
        (from == Source.firebase ? fbHabitRepo : hiveHabitRepo) as HabitRepo;
    var fromHabitPerformingRepo = (from == Source.firebase
        ? fbHabitPerformingRepo
        : hiveHabitPerformingRepo) as HabitPerformingRepo;
    var fromRewardRepo =
        (from == Source.firebase ? fbRewardRepo : hiveRewardRepo) as RewardRepo;

    var toUserDataRepo = (to == Source.firebase
        ? fbUserDataRepo
        : hiveUserDataRepo) as WithInsertOrUpdateManyByExternalId<UserData>;
    var toHabitRepo = (to == Source.firebase ? fbHabitRepo : hiveHabitRepo)
        as WithInsertOrUpdateManyByExternalId<Habit>;
    var toHabitPerformingRepo = (to == Source.firebase
            ? fbHabitPerformingRepo
            : hiveHabitPerformingRepo)
        as WithInsertOrUpdateManyByExternalId<HabitPerforming>;
    var toRewardRepo = (to == Source.firebase ? fbRewardRepo : hiveRewardRepo)
        as WithInsertOrUpdateManyByExternalId<Reward>;

    // Грузим фаербейз инфу
    var fromUserData = (from == Source.firebase
        ? await fromUserDataRepo.getByUserId(userId!)
        : await fromUserDataRepo.first())!;
    fromUserData = fromUserData.copyWith(externalId: fromUserData.id);

    var fromHabits = (await fromHabitRepo.listByIds(fromUserData.habitIds))
        .map((e) => e.copyWith(externalId: e.id))
        .toList();

    var fromHabitPerformings = (await fromHabitPerformingRepo
            .listByHabits(fromHabits.map((h) => h.id!).toList()))
        .map((e) => e.copyWith(externalId: e.id))
        .toList();

    var fromRewards = (await fromRewardRepo.listByIds(fromUserData.rewardIds))
        .map((e) => e.copyWith(externalId: e.id))
        .toList();

    // Вставляем награды в хайв
    var toRewardIds =
        await toRewardRepo.insertOrUpdateManyByExternalId(fromRewards);

    // Вставляем привычки в хайв
    var toHabitIds =
        await toHabitRepo.insertOrUpdateManyByExternalId(fromHabits);

    /// Проставляем выполнениям привычек хайв айди привычки +
    /// вставляем выполнения привычек в хайв
    var fromToHabitIdMap = Map<String, String>.fromIterables(
      fromHabits.map((h) => h.id!),
      toHabitIds,
    );
    var toHabitPerformingsToInsert = fromHabitPerformings
        .map((hp) => hp.copyWith(habitId: fromToHabitIdMap[hp.habitId]!))
        .toList();
    await toHabitPerformingRepo
        .insertOrUpdateManyByExternalId(toHabitPerformingsToInsert);

    // Ставим айди привычек и наград в данные юзера и вставляем данные о юзере
    var toUserDataToInsert = fromUserData.copyWith(
      rewardIds: toRewardIds,
      habitIds: toHabitIds,
    );
    await toUserDataRepo.insertOrUpdateManyByExternalId([toUserDataToInsert]);
  }
}

/// Провайдер FirebaseToHiveSync
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
