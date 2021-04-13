import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/habit/db.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/notifications/db.dart';
import 'package:yaxxxta/logic/habit/notifications/services.dart';
import 'package:yaxxxta/logic/user/controllers.dart';

class PerformHabitNow {
  final CreateHabitPerforming createHabitPerforming;
  final TryChargePoints tryChargePoints;
  final UpdateHabitStats updateHabitStats;
  final GetTodayDateRange getTodayDateRange;
  final TryRescheduleHabitNotification rescheduleHabitNotification;

  PerformHabitNow({
    required this.getTodayDateRange,
    required this.createHabitPerforming,
    required this.tryChargePoints,
    required this.updateHabitStats,
    required this.rescheduleHabitNotification,
  });

  Future<HabitPerforming> call({
    required Habit habit,
    required double performValue,
  }) async {
    var now = DateTime.now();
    var todayDateRange = getTodayDateRange(now);
    await tryChargePoints(
      habitId: habit.id!,
      todayDateRange: todayDateRange,
    );
    await updateHabitStats(habit, todayDateRange);
    await rescheduleHabitNotification(habit, todayDateRange);
    return await createHabitPerforming(
      habitId: habit.id!,
      performDateTime: now,
      performValue: performValue,
    );
  }
}

class CreateHabitPerforming {
  final HabitPerformingRepo repo;

  CreateHabitPerforming(this.repo);

  Future<HabitPerforming> call({
    required String habitId,
    required DateTime performDateTime,
    required double performValue,
  }) async {
    var hp = HabitPerforming(
      habitId: habitId,
      performDateTime: performDateTime,
      performValue: performValue,
    );
    hp = hp.copyWith(id: await repo.insert(hp));
    return hp;
  }
}

class TryChargePoints {
  final Future<void> Function([int points]) increaseUserPerformingPoints;
  final HabitPerformingRepo habitPerformingRepo;

  TryChargePoints({
    required this.increaseUserPerformingPoints,
    required this.habitPerformingRepo,
  });

  Future<void> call({
    required String habitId,
    required DateRange todayDateRange,
  }) async {
    var habitTransactionExistsInDateRange =
        await habitPerformingRepo.checkHabitPerformingExistInDateRange(
      habitId,
      todayDateRange.from,
      todayDateRange.to,
    );
    if (habitTransactionExistsInDateRange) {
      return;
    }

    await increaseUserPerformingPoints();
  }
}

class UpdateHabitStats {
  final HabitRepo habitRepo;

  UpdateHabitStats({required this.habitRepo});

  Future<void> call(Habit habit, DateRange todayDateRange) async {
    var currentStrike = habit.stats.computeTodayCurrentStrike(todayDateRange);

    var lastPerformingIsToday = habit.stats.lastPerforming != null &&
        habit.stats.lastPerforming! == todayDateRange.from;
    currentStrike += lastPerformingIsToday ? 0 : 1;

    var maxStrike = max(habit.stats.maxStrike, currentStrike);

    var lastPerforming = DateTime.now().date();

    habit = habit.copyWith(
      stats: habit.stats.copyWith(
        currentStrike: currentStrike,
        maxStrike: maxStrike,
        lastPerforming: lastPerforming,
      ),
    );
    await habitRepo.update(habit);
  }
}

class GetTodayDateRange {
  /// Настройки начала и конца дня
  final Tuple2<DateTime, DateTime> settingsDayTimes;

  GetTodayDateRange(this.settingsDayTimes);

  DateRange call([DateTime? now]) => DateRange.fromDateTimeAndTimes(
        now ?? DateTime.now(),
        settingsDayTimes.item1,
        settingsDayTimes.item2,
      );
}

Provider<PerformHabitNow> performHabitNowProvider = Provider((ref) {
  var hpRepo = ref.watch(habitPerformingRepoProvider);
  var habitRepo = ref.watch(habitRepoProvider);
  var settingsDayTimes = ref.watch(settingsDayTimesProvider);
  var habitNotificationRepo = ref.watch(habitNotificationRepoProvider);
  var createHabitPerforming = CreateHabitPerforming(hpRepo);

  return PerformHabitNow(
    getTodayDateRange: GetTodayDateRange(settingsDayTimes),
    createHabitPerforming: createHabitPerforming,
    tryChargePoints: TryChargePoints(
      habitPerformingRepo: hpRepo,
      increaseUserPerformingPoints:
          ref.watch(increaseUserPerformingPointsProvider),
    ),
    updateHabitStats: UpdateHabitStats(habitRepo: habitRepo),
    rescheduleHabitNotification: TryRescheduleHabitNotification(
      habitNotificationRepo: habitNotificationRepo,
      deletePendingNotifications:
          DeletePendingNotifications(habitNotificationRepo),
    ),
  );
});
