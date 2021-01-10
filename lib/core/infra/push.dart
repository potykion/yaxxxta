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

  Future<int> schedule({
    String title,
    String body,
    int sendAfterSeconds,
    AndroidNotificationDetails channel,
  }) async {
    channel = channel ?? timeProgressNotification;

    /// Айди должен быть в ренже [-2^31, 2^31 - 1]
    /// flutter_local_notifications/lib/src/helpers > validateId
    var id = DateTime.now().millisecondsSinceEpoch.toSigned(31);
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: sendAfterSeconds)),
      NotificationDetails(android: timeProgressNotification),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    return id;
  }

  Future<void> cancel(int id) => _flutterLocalNotificationsPlugin.cancel(id);
}
