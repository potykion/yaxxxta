import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/timezone.dart' as tz;

/// Отправщик уведомлений
class NotificationSender {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  static final int defaultNotificationId = 0;
  static final int scheduleNotificationId = 1;

  /// Отправщик уведомлений
  NotificationSender(this._flutterLocalNotificationsPlugin);

  /// Андроид канал для уведомлений о завершении работы таймера
  AndroidNotificationDetails get timeProgressNotification =>
      AndroidNotificationDetails(
        'time-progress',
        'Time progress',
        'Уведомление о том, что таймер отработал',
        // Вроде это нужно для heads-up уведомления, но чет хз
        priority: Priority.high,
        importance: Importance.max,
        // Вибрация - норм альтернатива heads-up уведомлениям
        enableVibration: true,
      );

  /// Отправка уведомления
  Future<void> send({
    String title,
    String body,
    AndroidNotificationDetails channel,
  }) async {
    channel = channel ?? timeProgressNotification;

    await _flutterLocalNotificationsPlugin.show(
      defaultNotificationId,
      title,
      body,
      NotificationDetails(android: timeProgressNotification),
    );
  }

  Future<void> schedule({
    String title,
    String body,
    int sendAfterSeconds,
    AndroidNotificationDetails channel,
  }) async {
    channel = channel ?? timeProgressNotification;

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      scheduleNotificationId,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: sendAfterSeconds)),
      NotificationDetails(android: timeProgressNotification),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancel(int id) => _flutterLocalNotificationsPlugin.cancel(id);
}
