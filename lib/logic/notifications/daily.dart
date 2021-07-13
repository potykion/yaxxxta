import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin localNotificationPlugin = FlutterLocalNotificationsPlugin();

class DailyHabitPerformNotifications {
  static final _channel = AndroidNotificationDetails(
    'DailyHabitPerformNotifications',
    'Уведомления о привычках',
    'Уведомления, которые юзер устанавливает для привычки',
    importance: Importance.max,
    priority: Priority.high,
  );

  static NotificationId generateId() {
    /// Айди должен быть в ренже [-2^31, 2^31 - 1]
    /// flutter_local_notifications/lib/src/helpers > validateId
    return DateTime.now().millisecondsSinceEpoch.toSigned(31);
  }

  static Future<NotificationId> create(
    Habit habit,
    DateTime atDateTime, {
    NotificationId? id,
  }) async {
    id = id ?? generateId();
    await localNotificationPlugin.zonedSchedule(
      id,
      habit.title,
      "Пора выполнить привычку",
      tz.TZDateTime.now(tz.local).add(atDateTime.difference(DateTime.now())),
      NotificationDetails(android: _channel),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    return id;
  }

  static Future remove(NotificationId id) async =>
      await localNotificationPlugin.cancel(id);
}
