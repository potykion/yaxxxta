// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Habit _$_$_HabitFromJson(Map json) {
  return _$_Habit(
    id: json['id'] as String,
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    title: json['title'] as String ?? '',
    type: _$enumDecodeNullable(_$HabitTypeEnumMap, json['type']) ??
        HabitType.repeats,
    goalValue: (json['goalValue'] as num)?.toDouble() ?? 1,
    performTime: json['performTime'] == null
        ? null
        : DateTime.parse(json['performTime'] as String),
    periodType:
        _$enumDecodeNullable(_$HabitPeriodTypeEnumMap, json['periodType']) ??
            HabitPeriodType.day,
    periodValue: json['periodValue'] as int ?? 1,
    performWeekdays: (json['performWeekdays'] as List)
            ?.map((e) => _$enumDecodeNullable(_$WeekdayEnumMap, e))
            ?.toList() ??
        [],
    performMonthDay: json['performMonthDay'] as int ?? 1,
    isCustomPeriod: json['isCustomPeriod'] as bool ?? false,
    deviceId: json['deviceId'] as String,
    userId: json['userId'] as String,
  );
}

Map<String, dynamic> _$_$_HabitToJson(_$_Habit instance) => <String, dynamic>{
      'id': instance.id,
      'created': instance.created?.toIso8601String(),
      'title': instance.title,
      'type': _$HabitTypeEnumMap[instance.type],
      'goalValue': instance.goalValue,
      'performTime': instance.performTime?.toIso8601String(),
      'periodType': _$HabitPeriodTypeEnumMap[instance.periodType],
      'periodValue': instance.periodValue,
      'performWeekdays':
          instance.performWeekdays?.map((e) => _$WeekdayEnumMap[e])?.toList(),
      'performMonthDay': instance.performMonthDay,
      'isCustomPeriod': instance.isCustomPeriod,
      'deviceId': instance.deviceId,
      'userId': instance.userId,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$HabitTypeEnumMap = {
  HabitType.time: 'time',
  HabitType.repeats: 'repeats',
};

const _$HabitPeriodTypeEnumMap = {
  HabitPeriodType.day: 'day',
  HabitPeriodType.week: 'week',
  HabitPeriodType.month: 'month',
};

const _$WeekdayEnumMap = {
  Weekday.monday: 'monday',
  Weekday.tuesday: 'tuesday',
  Weekday.wednesday: 'wednesday',
  Weekday.thursday: 'thursday',
  Weekday.friday: 'friday',
  Weekday.saturday: 'saturday',
  Weekday.sunday: 'sunday',
};

_$_HabitPerforming _$_$_HabitPerformingFromJson(Map json) {
  return _$_HabitPerforming(
    habitId: json['habitId'] as String,
    performValue: (json['performValue'] as num)?.toDouble(),
    performDateTime: json['performDateTime'] == null
        ? null
        : DateTime.parse(json['performDateTime'] as String),
  );
}

Map<String, dynamic> _$_$_HabitPerformingToJson(_$_HabitPerforming instance) =>
    <String, dynamic>{
      'habitId': instance.habitId,
      'performValue': instance.performValue,
      'performDateTime': instance.performDateTime?.toIso8601String(),
    };
