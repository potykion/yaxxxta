// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HabitNotificationSettings _$_$_HabitNotificationSettingsFromJson(Map json) {
  return _$_HabitNotificationSettings(
    id: json['id'] as int,
    time: DateTime.parse(json['time'] as String),
  );
}

Map<String, dynamic> _$_$_HabitNotificationSettingsToJson(
        _$_HabitNotificationSettings instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time.toIso8601String(),
    };

_$_Habit _$_$_HabitFromJson(Map json) {
  return _$_Habit(
    id: json['id'] as String?,
    title: json['title'] as String,
    userId: json['userId'] as String,
    order: json['order'] as int,
    archived: json['archived'] as bool? ?? false,
    notification: json['notification'] == null
        ? null
        : HabitNotificationSettings.fromJson(
            Map<String, dynamic>.from(json['notification'] as Map)),
  );
}

Map<String, dynamic> _$_$_HabitToJson(_$_Habit instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'userId': instance.userId,
      'order': instance.order,
      'archived': instance.archived,
      'notification': instance.notification?.toJson(),
    };

_$_HabitPerforming _$_$_HabitPerformingFromJson(Map json) {
  return _$_HabitPerforming(
    id: json['id'] as String?,
    created: DateTime.parse(json['created'] as String),
    habitId: json['habitId'] as String,
    userId: json['userId'] as String,
  );
}

Map<String, dynamic> _$_$_HabitPerformingToJson(_$_HabitPerforming instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created': instance.created.toIso8601String(),
      'habitId': instance.habitId,
      'userId': instance.userId,
    };
