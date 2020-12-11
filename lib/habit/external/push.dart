import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Отправитель уведомлений
class NotificationSender {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  /// Создает отправитель
  NotificationSender(this._flutterLocalNotificationsPlugin);

  /// Андроид канал уведомлений
  AndroidNotificationDetails get habitChannel => AndroidNotificationDetails(
        'habit',
        'habit',
        'Уведомления про привычки',
      );

  /// Отправляет уведомление
  Future<void> send({
    String title,
    String body = "",
    AndroidNotificationDetails channel,
  }) async {
    channel = channel ?? habitChannel;

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: habitChannel,
      ),
    );
  }
}
