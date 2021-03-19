import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yaxxxta/logic/core/infra/push.dart';
import 'package:yaxxxta/logic/habit/domain/models.dart';
import 'package:yaxxxta/logic/habit/domain/services.dart';
import 'services_test.mocks.dart';

@GenerateMocks(
  [NotificationSender],
)
void main() {
  group("ScheduleNotificationsForHabitsWithoutNotifications", () {
    test("обычный кейс", () async {
      var now = DateTime(2020, 1, 1, 11);
      var habit = Habit.blank(
        created: now,
        performTime: DateTime(2020, 1, 1, 12),
        isNotificationsEnabled: true,
      );

      var sender = MockNotificationSender();
      when(sender.getAllPending()).thenAnswer((_) async => []);
      when(sender.schedule(
        title: anyNamed("title"),
        body: anyNamed("body"),
        sendAfterSeconds: anyNamed("sendAfterSeconds"),
        payload: anyNamed("payload"),
      )).thenAnswer((_) async => 0);

      var schedule = ScheduleNotificationsForHabitsWithoutNotifications(
        notificationSender: sender,
      );
      await schedule([habit], now: now);

      verify(
        sender.schedule(
          title: habit.title,
          body: "Пора выполнить привычку",
          sendAfterSeconds: habit.performTime!.difference(now).inSeconds,
          payload: jsonEncode({"habitId": habit.id}),
        ),
      );
    });

    test("кейс, когда есть заскедуленные привычки", () async {
      var now = DateTime(2020, 1, 1, 11);
      var habit = Habit.blank(
        created: now,
        performTime: DateTime(2020, 1, 1, 12),
        isNotificationsEnabled: true,
      ).copyWith(
        id: "1",
      );

      var sender = MockNotificationSender();
      when(sender.getAllPending()).thenAnswer((_) async => [
            PendingNotificationRequest(
              1,
              "sam",
              'sam',
              jsonEncode({"habitId": "2"}),
            ),
          ]);
      when(sender.schedule(
        title: anyNamed("title"),
        body: anyNamed("body"),
        sendAfterSeconds: anyNamed("sendAfterSeconds"),
        payload: anyNamed("payload"),
      )).thenAnswer((_) async => 0);

      var schedule = ScheduleNotificationsForHabitsWithoutNotifications(
        notificationSender: sender,
      );
      await schedule([habit], now: now);

      verify(
        sender.schedule(
          title: habit.title,
          body: "Пора выполнить привычку",
          sendAfterSeconds: habit.performTime!.difference(now).inSeconds,
          payload: jsonEncode({"habitId": habit.id}),
        ),
      );
    });
  });
}
