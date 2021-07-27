import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:timezone/timezone.dart' as tz;

/// Плагин для отправки локальных пушей
FlutterLocalNotificationsPlugin localNotificationPlugin =
    FlutterLocalNotificationsPlugin();

/// Айди должен быть в ренже [-2^31, 2^31 - 1]
/// flutter_local_notifications/lib/src/helpers > validateId
int generateNotificationId() {
  return DateTime.now().millisecondsSinceEpoch.toSigned(31);
}

/// Класс работает с уведомлениями о выполнении привычек
class HabitPerformNotificationService {
  final FlutterLocalNotificationsPlugin _localNotificationPlugin;

  HabitPerformNotificationService(this._localNotificationPlugin);

  final _channel = AndroidNotificationDetails(
    'DailyHabitPerformNotifications',
    'Уведомления о привычках',
    'Уведомления, которые юзер устанавливает для привычки',
    importance: Importance.max,
    priority: Priority.high,
  );

  Future<NotificationId> create(
    Habit habit,
    DateTime atDateTime, {
    NotificationId? id,
    bool repeatWeekly = false,
  }) async {
    id = id ?? generateNotificationId();
    await _localNotificationPlugin.zonedSchedule(
      id,
      habit.title,
      "Пора выполнить привычку",
      tz.TZDateTime.now(tz.local).add(atDateTime.difference(DateTime.now())),
      NotificationDetails(android: _channel),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: repeatWeekly
          ? DateTimeComponents.dayOfWeekAndTime
          : DateTimeComponents.time,
    );
    return id;
  }

  Future<void> remove(NotificationId id) async =>
      await _localNotificationPlugin.cancel(id);

  Future<List<NotificationId>> pending() async =>
      (await _localNotificationPlugin.pendingNotificationRequests())
          .map((n) => n.id)
          .toList();
}

Provider<HabitPerformNotificationService>
    habitPerformNotificationServiceProvider =
    Provider((_) => HabitPerformNotificationService(localNotificationPlugin));
