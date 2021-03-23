import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/timezone.dart' as tz;

/// Отправщик уведомлений
abstract class NotificationSender {
  /// Планирует отправку уведомления через {sendAfterSeconds} секунд
  Future<int> schedule({
    required String title,
    String? body,
    required int sendAfterSeconds,
    AndroidNotificationDetails? androidChannel,
    bool repeatDaily = false,
    bool repeatWeekly = false,
    String? payload,
  });

  /// Отменяет уведомление
  Future<void> cancel(int id);

  /// Получает все уведомления на очереди
  Future<List<PendingNotificationRequest>> getAllPending();
}

/// Отправщик уведомлений, использующий FlutterLocalNotificationsPlugin
class LocalNotificationSender implements NotificationSender {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  /// Отправщик уведомлений
  LocalNotificationSender(this._flutterLocalNotificationsPlugin);

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

  /// Планирует отправку уведомления через {sendAfterSeconds} секунд
  Future<int> schedule({
    required String title,
    String? body,
    required int sendAfterSeconds,
    AndroidNotificationDetails? androidChannel,
    bool repeatDaily = false,
    bool repeatWeekly = false,
    String? payload,
  }) async {
    androidChannel = androidChannel ?? timeProgressNotification;

    /// Айди должен быть в ренже [-2^31, 2^31 - 1]
    /// flutter_local_notifications/lib/src/helpers > validateId
    var id = DateTime.now().millisecondsSinceEpoch.toSigned(31);

    var matchDateTimeComponents = repeatDaily
        ? DateTimeComponents.time
        : repeatWeekly
            ? DateTimeComponents.dayOfWeekAndTime
            : null;

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: sendAfterSeconds)),
      NotificationDetails(android: androidChannel),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
      matchDateTimeComponents: matchDateTimeComponents,
    );

    return id;
  }

  /// Отменяет уведомление
  Future<void> cancel(int id) => _flutterLocalNotificationsPlugin.cancel(id);

  /// Получает все уведомления на очереди
  Future<List<PendingNotificationRequest>> getAllPending() async =>
      await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
}

/// Отправщик уведомлений, который ничо не делает
/// Локальные уведомления не поддерживаются в вебе => можно использовать это
class FakeNotificationSender implements NotificationSender {
  @override
  Future<void> cancel(int id) async {}

  @override
  Future<List<PendingNotificationRequest>> getAllPending() async => [];

  @override
  Future<int> schedule({
    required String title,
    String? body,
    required int sendAfterSeconds,
    AndroidNotificationDetails? androidChannel,
    bool repeatDaily = false,
    bool repeatWeekly = false,
    String? payload,
  }) async =>
      0;
}
