import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Айди уведомления
typedef NotificationId = int;

/// Уведомление о привычке
class HabitNotification {
  /// Айди уведомления
  final NotificationId id;

  /// Айди привычки
  final String? habitId;

  /// Уведомление о привычке
  HabitNotification({
    required this.id,
    required this.habitId,
  });

  /// Создает из запланированного уведомления
  factory HabitNotification.fromPending(
          PendingNotificationRequest notification) =>
      HabitNotification(
        id: notification.id,
        habitId:
            notification.payload != null && notification.payload!.isNotEmpty
                ? jsonDecode(notification.payload!)["habit"] as String
                : null,
      );

  /// Генерирует пейлоад для "сырого" уведомления
  static String generatePayload(String habitId) =>
      jsonEncode({"habit": habitId});
}
