import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Отправщик уведомлений
class NotificationSender {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

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
      0,
      title,
      body,
      NotificationDetails(
        android: timeProgressNotification,
      ),
    );
  }
}
