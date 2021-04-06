import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/deps.dart';
import 'models.dart';
import 'package:timezone/timezone.dart' as tz;

abstract class HabitNotificationRepo {
  Future<void> schedule(HabitNotification notification);

  Future<List<HabitNotification>> getPending();

  Future<void> cancel(int notificationId);
}

class LocalHabitNotificationRepo implements HabitNotificationRepo {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  LocalHabitNotificationRepo(this._flutterLocalNotificationsPlugin);

  AndroidNotificationDetails _defaultAndroidChannel =
      AndroidNotificationDetails(
    'default',
    'default',
    'Канал уведомлений по умолчанию',
    // Вроде это нужно для heads-up уведомления, но чет хз
    priority: Priority.high,
    importance: Importance.max,
    // Вибрация - норм альтернатива heads-up уведомлениям
    enableVibration: true,
  );

  @override
  Future<void> schedule(HabitNotification notification) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      tz.TZDateTime.now(tz.local)
          .add(Duration(seconds: notification.sendAfterSeconds)),
      NotificationDetails(android: _defaultAndroidChannel),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: notification.habitIdPayload,
    );
  }

  @override
  Future<List<HabitNotification>> getPending() async =>
      (await _flutterLocalNotificationsPlugin.pendingNotificationRequests())
          .map((p) => HabitNotification.fromPendingNotification(p))
          .toList();

  @override
  Future<void> cancel(int notificationId) =>
      _flutterLocalNotificationsPlugin.cancel(notificationId);
}

var habitNotificationRepoProvider = Provider(
  (ref) => LocalHabitNotificationRepo(
    ref.watch(flutterLocalNotificationsPluginProvider),
  ),
);
