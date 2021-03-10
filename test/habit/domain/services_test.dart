import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yaxxxta/core/infra/push.dart';
import 'package:yaxxxta/habit/domain/models.dart';
import 'package:yaxxxta/habit/domain/services.dart';
import 'services_test.mocks.dart';

@GenerateMocks(
  [NotificationSender],
)
void main() {
  test("ScheduleNotificationsForHabitsWithoutNotifications", () async {
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
}
