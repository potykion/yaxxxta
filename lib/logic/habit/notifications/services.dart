import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models.dart';
import 'db.dart';
import 'models.dart';

class DeletePendingNotifications {
  final HabitNotificationRepo _repo;

  DeletePendingNotifications(this._repo);

  Future<void> call(String habitId) async {
    var pending = (await _repo.getPending())
        .where((n) => n.habitId == habitId)
        .map((n) => n.id);
    await Future.wait(pending.map(_repo.cancel));
  }
}

class TryRescheduleHabitNotification {
  final HabitNotificationRepo habitNotificationRepo;
  final DeletePendingNotifications deletePendingNotifications;

  TryRescheduleHabitNotification({
    required this.habitNotificationRepo,
    required this.deletePendingNotifications,
  });

  Future<void> call(Habit habit, DateRange todayDateRange) async {
    if (habit.performTime == null) return;

    await deletePendingNotifications(habit.id!);

    var notificationDateTime = habit
        .nextPerformDateTime()
        .where((dt) => !todayDateRange.containsDateTime(dt))
        .first;

    var notification = HabitNotification.createPerformNotification(
      habit,
      notificationDateTime,
    );
    habitNotificationRepo.schedule(notification);
  }
}

/// Планирует уведомления о выполнении привычки для всех привычек,
/// у которых нет запланированных уведомлений
class ScheduleNotificationsForHabitsWithoutNotifications {
  final HabitNotificationRepo habitNotificationRepo;

  /// Планирует уведомления о выполнении привычки для всех привычек,
  /// у которых нет запланированных уведомлений
  ScheduleNotificationsForHabitsWithoutNotifications({
    required this.habitNotificationRepo,
  });

  /// Планирует уведомления о выполнении привычки для всех привычек,
  /// у которых нет запланированных уведомлений
  Future<void> call(List<Habit> habits, {DateTime? now}) async {
    now = now ?? DateTime.now();

    //  Берем все привычки со временем выполнения и флагом отправки уведомления
    habits = habits.where((h) => h.isNotificationsEnabled).toList();

    //  Берем все пендинг уведомления
    var allPendingNotifications = await habitNotificationRepo.getPending();

    //  Фильтруем привычки, у которых нет уведомлений
    var notificationHabitIds =
        allPendingNotifications.map((h) => h.habitId).toSet();
    var habitsWithoutNotifications =
        habits.where((h) => !notificationHabitIds.contains(h.id)).toList();

    //  Для каждой привычки скедулим некст уведомление
    await Future.wait(
      habitsWithoutNotifications.map(
        (habit) => habitNotificationRepo.schedule(
          HabitNotification.createPerformNotification(
            habit,
            habit.nextPerformDateTime(now!).first,
          ),
        ),
      ),
    );
  }
}

/// Провайдер функции планирования уведомл. для привычек
/// без запланированных уведомл.
Provider<ScheduleNotificationsForHabitsWithoutNotifications>
    scheduleNotificationsForHabitsWithoutNotificationsProvider = Provider(
  (ref) => ScheduleNotificationsForHabitsWithoutNotifications(
    habitNotificationRepo: ref.watch(habitNotificationRepoProvider),
  ),
);
