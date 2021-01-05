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
    dailyRepeatSettings: json['dailyRepeatSettings'] == null
        ? null
        : HabitDailyRepeatSettings.fromJson(json['dailyRepeatSettings'] as Map),
    habitPeriod: json['habitPeriod'] == null
        ? null
        : HabitPeriodSettings.fromJson(json['habitPeriod'] as Map),
  );
}

Map<String, dynamic> _$_$_HabitToJson(_$_Habit instance) => <String, dynamic>{
      'id': instance.id,
      'created': instance.created?.toIso8601String(),
      'title': instance.title,
      'type': _$HabitTypeEnumMap[instance.type],
      'goalValue': instance.goalValue,
      'dailyRepeatSettings': instance.dailyRepeatSettings?.toJson(),
      'habitPeriod': instance.habitPeriod?.toJson(),
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

_$_HabitPeriodSettings _$_$_HabitPeriodSettingsFromJson(Map json) {
  return _$_HabitPeriodSettings(
    type: _$enumDecodeNullable(_$HabitPeriodTypeEnumMap, json['type']) ??
        HabitPeriodType.day,
    periodValue: json['periodValue'] as int ?? 1,
    weekdays: (json['weekdays'] as List)
            ?.map((e) => _$enumDecodeNullable(_$WeekdayEnumMap, e))
            ?.toList() ??
        [],
    monthDay: json['monthDay'] as int ?? 1,
    isCustom: json['isCustom'] as bool ?? false,
  );
}

Map<String, dynamic> _$_$_HabitPeriodSettingsToJson(
        _$_HabitPeriodSettings instance) =>
    <String, dynamic>{
      'type': _$HabitPeriodTypeEnumMap[instance.type],
      'periodValue': instance.periodValue,
      'weekdays': instance.weekdays?.map((e) => _$WeekdayEnumMap[e])?.toList(),
      'monthDay': instance.monthDay,
      'isCustom': instance.isCustom,
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

_$_HabitDailyRepeatSettings _$_$_HabitDailyRepeatSettingsFromJson(Map json) {
  return _$_HabitDailyRepeatSettings(
    repeatsEnabled: json['repeatsEnabled'] as bool ?? false,
    repeatsCount: (json['repeatsCount'] as num)?.toDouble() ?? 1,
    performTimes: (json['performTimes'] as Map)?.map(
          (k, e) => MapEntry(int.parse(k as String),
              e == null ? null : DateTime.parse(e as String)),
        ) ??
        {},
  );
}

Map<String, dynamic> _$_$_HabitDailyRepeatSettingsToJson(
        _$_HabitDailyRepeatSettings instance) =>
    <String, dynamic>{
      'repeatsEnabled': instance.repeatsEnabled,
      'repeatsCount': instance.repeatsCount,
      'performTimes': instance.performTimes
          ?.map((k, e) => MapEntry(k.toString(), e?.toIso8601String())),
    };

_$_HabitPerforming _$_$_HabitPerformingFromJson(Map json) {
  return _$_HabitPerforming(
    habitId: json['habitId'] as String,
    repeatIndex: json['repeatIndex'] as int,
    performValue: (json['performValue'] as num)?.toDouble(),
    performDateTime: json['performDateTime'] == null
        ? null
        : DateTime.parse(json['performDateTime'] as String),
  );
}

Map<String, dynamic> _$_$_HabitPerformingToJson(_$_HabitPerforming instance) =>
    <String, dynamic>{
      'habitId': instance.habitId,
      'repeatIndex': instance.repeatIndex,
      'performValue': instance.performValue,
      'performDateTime': instance.performDateTime?.toIso8601String(),
    };
