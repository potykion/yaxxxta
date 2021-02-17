import 'dart:convert';

import 'package:yaxxxta/core/infra/push.dart';
import 'package:yaxxxta/habit/domain/models.dart';

class SchedulePerformHabitNotifications {
  final NotificationSender notificationSender;

  SchedulePerformHabitNotifications({
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

    var nextPerformDateTime = habit.nextPerformDateTime().first;
    notificationSender.schedule(
      title: habit.title,
      body: "Пора выполнить привычку",
      sendAfterSeconds: nextPerformDateTime
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
