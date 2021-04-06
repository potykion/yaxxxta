import 'dart:math';

import 'package:tuple/tuple.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/habit/db.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/notifications/services.dart';
import 'package:yaxxxta/logic/transactions/db.dart';
import 'package:yaxxxta/logic/transactions/models.dart';

class PerformHabitNow {
  final CreateHabitPerforming createHabitPerforming;
  final TryChargePoints tryChargePoints;
  final UpdateHabitStats updateHabitStats;
  final GetTodayDateRange getTodayDateRange;
  final RescheduleHabitNotification rescheduleHabitNotification;

  PerformHabitNow({
    required this.getTodayDateRange,
    required this.createHabitPerforming,
    required this.tryChargePoints,
    required this.updateHabitStats,
    required this.rescheduleHabitNotification,
  });

  Future<HabitPerforming> call({
    required Habit habit,
    String? userId,
    required double performValue,
  }) async {
    var now = DateTime.now();
    var todayDateRange = getTodayDateRange(now);
    await tryChargePoints(
      habitId: habit.id!,
      userId: userId,
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
  final PerformingPointTransactionRepo transactionRepo;

  TryChargePoints({
    required this.transactionRepo,
  });

  Future<void> call({
    required String habitId,
    String? userId,
    required DateRange todayDateRange,
  }) async {
    var habitTransactionExistsInDateRange =
        await transactionRepo.checkHabitTransactionExistsInDateRange(
      habitId,
      todayDateRange,
    );
    if (habitTransactionExistsInDateRange) {
      return;
    }

    var trans = PerformingPointTransaction.habitIncome(
      created: DateTime.now(),
      userId: userId,
      habitId: habitId,
    );
    await transactionRepo.insert(trans);
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

  DateRange call([DateTime? now]) => DateRange.fromDateAndTimes(
        now ?? DateTime.now(),
        settingsDayTimes.item1,
        settingsDayTimes.item2,
      );
}
