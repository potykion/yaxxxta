import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationSender {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationSender(this.flutterLocalNotificationsPlugin);

  AndroidNotificationDetails get habitChannel => AndroidNotificationDetails(
        'habit',
        'habit',
        'Уведомления про привычки',
      );

  Future<void> send({
    String title,
    String body = "",
    AndroidNotificationDetails channel,
  }) async {
    channel = channel ?? habitChannel;

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: habitChannel,
      ),
    );
  }
}
