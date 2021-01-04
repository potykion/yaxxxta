import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationSender {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationSender(this.flutterLocalNotificationsPlugin);

  AndroidNotificationDetails get timeProgressNotification =>
      AndroidNotificationDetails(
        'time-progress',
        'Time progress',
        'Уведомление о том, что таймер отработал',
        // Вроде это нужно для heads-up уведомления, но чет хз
        fullScreenIntent: true,
        priority: Priority.high,
        // Вибрация - норм альтернатива heads-up уведомлениям
        enableVibration: true,
      );

  Future<void> send({
    String title,
    String body,
    AndroidNotificationDetails channel,
  }) async {
    channel = channel ?? timeProgressNotification;

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: timeProgressNotification,
      ),
    );
  }
}
