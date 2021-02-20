import 'dart:convert';

import '../../core/infra/push.dart';
import 'db.dart';
import 'models.dart';

/// Планирует уведомление о выполнении привычки
class ScheduleSingleHabitNotification {
  /// Отправщик уведомлений
  final NotificationSender notificationSender;

  /// Планирует уведомление о выполнении привычки
  ScheduleSingleHabitNotification({
    this.notificationSender,
  });

  /// Планирует уведомление о выполнении привычки
  Future<void> call({Habit habit, bool resetPending = false}) async {
    if (resetPending) {
      var allPendingNotifications = await notificationSender.getAllPending();
      var habitPendingNotifications = allPendingNotifications.where(
        (n) =>
            n.payload != null &&
            n.payload.isNotEmpty &&
            jsonDecode(n.payload)["habitId"] == habit.id,
      );
      await Future.wait(
        habitPendingNotifications.map((n) => notificationSender.cancel(n.id)),
      );
    }

    notificationSender.schedule(
      title: habit.title,
      body: "Пора выполнить привычку",
      sendAfterSeconds: habit
          .nextPerformDateTime()
          .first
          .difference(DateTime.now())
          .inSeconds,
      payload: jsonEncode({"habitId": habit.id}),
      repeatDaily:
          habit.periodType == HabitPeriodType.day && habit.periodValue == 1,
      repeatWeekly: habit.periodType == HabitPeriodType.week &&
          habit.periodValue == 1 &&
          habit.performWeekdays.length == 1,
    );
  }
}

/// Планирует уведомления о выполнении привычки для всех привычек,
/// у которых нет запланированных уведомлений
class ScheduleNotificationsForHabitsWithoutNotifications {
  /// Отправщик уведомлений
  final NotificationSender notificationSender;

  /// Репо привычек
  final BaseHabitRepo habitRepo;

  /// Планирует уведомления о выполнении привычки для всех привычек,
  /// у которых нет запланированных уведомлений
  ScheduleNotificationsForHabitsWithoutNotifications({
    this.notificationSender,
    this.habitRepo,
  });

  /// Планирует уведомления о выполнении привычки для всех привычек,
  /// у которых нет запланированных уведомлений
  Future<void> call() async {
    //  Берем все привычки со временем выполнения и флагом отправки уведомления
    var habits = (await habitRepo.list())
        .where((h) => h.isNotificationsEnabled && h.performTime != null)
        .toList();

    //  Берем все пендинг уведомления
    var allPendingNotifications = await notificationSender.getAllPending();

    //  Фильтруем привычки, у которых нет уведомлений
    var notificationHabitIds = allPendingNotifications
        .where((n) => n.payload != null && n.payload.isNotEmpty)
        .map((n) => jsonDecode(n.payload)["habitId"] as String)
        .toSet();
    var habitsWithoutNotifications =
        habits.where((h) => !notificationHabitIds.contains(h.id));

    //  Для каждой привычки скедулим некст уведомление
    await Future.wait(
      habitsWithoutNotifications.map(
        (habit) => notificationSender.schedule(
          title: habit.title,
          body: "Пора выполнить привычку",
          sendAfterSeconds: habit
              .nextPerformDateTime()
              .first
              .difference(DateTime.now())
              .inSeconds,
          payload: jsonEncode({"habitId": habit.id}),
        ),
      ),
    );
  }
}
