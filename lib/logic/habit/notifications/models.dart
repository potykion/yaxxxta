import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Уведомление о привычке
class HabitNotification {
  /// Айди
  /// Должен быть в ренже [-2^31, 2^31 - 1]
  final int id;

  /// Тайтл
  final String title;

  /// Боди
  final String? body;

  /// Айди привычки
  final String habitId;

  /// Дейттайм отправки уведомления
  final DateTime? sendDateTime;

  /// Уведомление о привычке
  HabitNotification({
    int? id,
    required this.title,
    this.body,
    required this.habitId,
    this.sendDateTime,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toSigned(31);

  /// Через сколько секунд отправить уведомление
  int get sendAfterSeconds =>
      sendDateTime?.difference(DateTime.now()).inSeconds ?? 0;

  /// Пейлоад уведомления с айди привычки
  String get habitIdPayload => jsonEncode({"habitId": habitId});

  /// Создает из PendingNotificationRequest
  factory HabitNotification.fromPendingNotification(
    PendingNotificationRequest pendingNotification,
  ) =>
      HabitNotification(
        id: pendingNotification.id,
        title: pendingNotification.title!,
        body: pendingNotification.body,
        habitId: jsonDecode(pendingNotification.payload!)["habitId"] as String,
      );
}
