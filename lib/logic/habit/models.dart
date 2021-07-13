import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:yaxxxta/logic/core/models.dart';

part 'models.freezed.dart';

part 'models.g.dart';

typedef NotificationId = int;

@freezed
abstract class HabitNotificationSettings
    implements _$HabitNotificationSettings {
  const HabitNotificationSettings._();

  factory HabitNotificationSettings({
    required NotificationId id,
    required DateTime time,
  }) = _HabitNotificationSettings;

  /// Создает из джсонки
  factory HabitNotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$HabitNotificationSettingsFromJson(json);

  /// Форматирует как время
  String toTimeStr() => DateFormat.Hm().format(time);
}

/// Привычка
@freezed
abstract class Habit implements _$Habit, WithId {
  const Habit._();

  /// Привычка
  const factory Habit({
    String? id,
    required String title,
    required String userId,
    required int order,
    @Default(false) bool archived,
    HabitNotificationSettings? notification,
  }) = _Habit;

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  factory Habit.blank({required String userId}) {
    return Habit(
      title: "",
      userId: userId,
      order: DateTime.now().millisecondsSinceEpoch,
    );
  }
}

@freezed
abstract class HabitPerforming implements _$HabitPerforming, WithId {
  const HabitPerforming._();

  const factory HabitPerforming({
    String? id,
    required DateTime created,
    required String habitId,
    required String userId,
  }) = _HabitPerforming;

  factory HabitPerforming.fromJson(Map<String, dynamic> json) =>
      _$HabitPerformingFromJson(json);

  factory HabitPerforming.blank(String habitId, String userId,
      [DateTime? performDatetime]) {
    return HabitPerforming(
      created: performDatetime ?? DateTime.now(),
      habitId: habitId,
      userId: userId,
    );
  }
}
