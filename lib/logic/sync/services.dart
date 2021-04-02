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
    required String userId,
    Source from = Source.firebase,
    Source to = Source.hive,
  }) async {
    assert(from != to);

    // Выставляем репо
    // region
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
        : hiveUserDataRepo) as UserDataRepo;
    var toHabitRepo = (to == Source.firebase ? fbHabitRepo : hiveHabitRepo)
        as WithInsertOrUpdateManyByExternalId<Habit>;
    var toHabitPerformingRepo = (to == Source.firebase
            ? fbHabitPerformingRepo
            : hiveHabitPerformingRepo)
        as WithInsertOrUpdateManyByExternalId<HabitPerforming>;
    var toRewardRepo = (to == Source.firebase ? fbRewardRepo : hiveRewardRepo)
        as WithInsertOrUpdateManyByExternalId<Reward>;
    // endregion

    // Грузим инфу из [from] источника
    // region
    late UserData fromUserData;
    if (from == Source.firebase) {
      fromUserData = (await fromUserDataRepo.getByUserId(userId))!;
    } else {
      fromUserData = (await fromUserDataRepo.first())!;
    }
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
    // endregion

    // Вставляем награды, привычки и выполнения в [to] источник
    // region
    var toRewardIds =
        await toRewardRepo.insertOrUpdateManyByExternalId(fromRewards);
    var toHabitIds =
        await toHabitRepo.insertOrUpdateManyByExternalId(fromHabits);

    // Для выполнений привычек проставляем айди привычек
    var fromToHabitIdMap = Map<String, String>.fromIterables(
      fromHabits.map((h) => h.id!),
      toHabitIds,
    );
    var toHabitPerformingsToInsert = fromHabitPerformings
        .map((hp) => hp.copyWith(habitId: fromToHabitIdMap[hp.habitId]!))
        .toList();
    await toHabitPerformingRepo
        .insertOrUpdateManyByExternalId(toHabitPerformingsToInsert);
    // endregion

    late UserData toUserDataToUpdate;
    // Если [to] == [Source.hive], то берем первую запись данных о юзере
    // и проставляем туда привычки, награды, баллы, настройки
    if (to == Source.hive) {
      toUserDataToUpdate = (await toUserDataRepo.first())!;
      toUserDataToUpdate = toUserDataToUpdate.copyWith(
        rewardIds: toRewardIds,
        habitIds: toHabitIds,
        settings: fromUserData.settings,
        performingPoints: fromUserData.performingPoints,
      );
    }
    // Если [to] == [Source.firebase], то берем данные о юзере по [userId]
    // и объединяем привычки, награды; баллы складываем; настройки оставляем
    else {
      toUserDataToUpdate = (await toUserDataRepo.getByUserId(userId))!;
      toUserDataToUpdate = toUserDataToUpdate.copyWith(
        rewardIds: {...toUserDataToUpdate.rewardIds, ...toRewardIds}.toList(),
        habitIds: {...toUserDataToUpdate.habitIds, ...toHabitIds}.toList(),
      );
    }
    await toUserDataRepo.update(toUserDataToUpdate);
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
