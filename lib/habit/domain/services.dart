import 'dart:convert';

import 'package:yaxxxta/core/infra/push.dart';
import 'package:yaxxxta/habit/domain/db.dart';
import 'package:yaxxxta/habit/domain/models.dart';

class ScheduleSingleHabitNotification {
  final NotificationSender notificationSender;

  ScheduleSingleHabitNotification({
    this.notificationSender,
  });

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

class ScheduleNotificationsForHabitsWithoutNotifications {
  final NotificationSender notificationSender;

  final BaseHabitRepo habitRepo;

  ScheduleNotificationsForHabitsWithoutNotifications({
    this.notificationSender,
    this.habitRepo,
  });

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
