import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:timezone/timezone.dart' as tz;
import 'models.dart';

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

  /// Класс работает с уведомлениями о выполнении привычек
  HabitPerformNotificationService(this._localNotificationPlugin);

  final _channel = AndroidNotificationDetails(
    'DailyHabitPerformNotifications',
    'Уведомления о привычках',
    'Уведомления, которые юзер устанавливает для привычки',
    importance: Importance.max,
    priority: Priority.high,
  );

  /// Создает напоминалку на определенное время
  /// Напоминалка будет срабатывать ежедневно
  /// Если указано {repeatWeekly},
  /// то напоминалка будет срабатывать только по дням недели
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
        payload: jsonEncode({"habit": habit.id}));
    return id;
  }

  /// Удаляет напоминалку
  Future<void> remove(NotificationId id) async =>
      await _localNotificationPlugin.cancel(id);

  /// Получает запланированные напоминалки с айди привычки
  Future<List<HabitNotification>> getPendingWithHabitId() async =>
      (await getPending()).where((n) => n.habitId != null).toList();

  /// Удаляет напоминалки, у которых не указан айди привычки
  Future<void> removeByHabitId(String habitId) async {
    var notifications = (await getPending()).where((n) => n.habitId == habitId);
    for (var n in notifications) {
      await remove(n.id);
    }
  }

  /// Получает запланированные привычки
  Future<List<HabitNotification>> getPending() async {
    return (await _localNotificationPlugin.pendingNotificationRequests())
        .map((n) => HabitNotification.fromPending(n))
        .toList();
  }

  /// Удаляет уведомления, для которых не выставлены айди привычек
  Future<void> removeNotificationsWithoutHabitId() async {
    var notifications = (await getPending()).where((n) => n.habitId == null);
    for (var n in notifications) {
      await remove(n.id);
    }
  }
}

/// Провайдер сервиса напоминалок о привычке
Provider<HabitPerformNotificationService>
    habitPerformNotificationServiceProvider =
    Provider((_) => HabitPerformNotificationService(localNotificationPlugin));
