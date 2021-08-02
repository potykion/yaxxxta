// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
    frequencyType: _$enumDecodeNullable(
            _$HabitFrequencyTypeEnumMap, json['frequencyType']) ??
        HabitFrequencyType.daily,
    performWeekday:
        _$enumDecodeNullable(_$WeekdayEnumMap, json['performWeekday']),
  );
}

Map<String, dynamic> _$_$_HabitToJson(_$_Habit instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'userId': instance.userId,
      'order': instance.order,
      'archived': instance.archived,
      'notification': instance.notification?.toJson(),
      'frequencyType': _$HabitFrequencyTypeEnumMap[instance.frequencyType],
      'performWeekday': _$WeekdayEnumMap[instance.performWeekday],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$HabitFrequencyTypeEnumMap = {
  HabitFrequencyType.daily: 'daily',
  HabitFrequencyType.weekly: 'weekly',
};

const _$WeekdayEnumMap = {
  Weekday.Monday: 'Monday',
  Weekday.Tuesday: 'Tuesday',
  Weekday.Wednesday: 'Wednesday',
  Weekday.Thursday: 'Thursday',
  Weekday.Friday: 'Friday',
  Weekday.Saturday: 'Saturday',
  Weekday.Sunday: 'Sunday',
};

_$_HabitNotificationSettings _$_$_HabitNotificationSettingsFromJson(Map json) {
  return _$_HabitNotificationSettings(
    time: DateTime.parse(json['time'] as String),
  );
}

Map<String, dynamic> _$_$_HabitNotificationSettingsToJson(
        _$_HabitNotificationSettings instance) =>
    <String, dynamic>{
      'time': instance.time.toIso8601String(),
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
