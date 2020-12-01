// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Habit _$HabitFromJson(Map json) {
  return Habit(
    id: json['id'] as int,
    title: json['title'] as String,
    type: _$enumDecodeNullable(_$HabitTypeEnumMap, json['type']),
    dailyRepeatsEnabled: json['dailyRepeatsEnabled'] as bool,
    goalValue: (json['goalValue'] as num)?.toDouble(),
    dailyRepeats: (json['dailyRepeats'] as num)?.toDouble(),
    habitPeriod: json['habitPeriod'] == null
        ? null
        : HabitPeriod.fromJson(json['habitPeriod'] as Map),
  );
}

Map<String, dynamic> _$HabitToJson(Habit instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': _$HabitTypeEnumMap[instance.type],
      'dailyRepeatsEnabled': instance.dailyRepeatsEnabled,
      'goalValue': instance.goalValue,
      'dailyRepeats': instance.dailyRepeats,
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

HabitPeriod _$HabitPeriodFromJson(Map json) {
  return HabitPeriod(
    type: _$enumDecodeNullable(_$HabitPeriodTypeEnumMap, json['type']),
    periodValue: json['periodValue'] as int,
    weekdays: (json['weekdays'] as List)
        ?.map((e) => _$enumDecodeNullable(_$WeekdayEnumMap, e))
        ?.toList(),
    monthDay: json['monthDay'] as int,
    isCustom: json['isCustom'] as bool,
  );
}

Map<String, dynamic> _$HabitPeriodToJson(HabitPeriod instance) =>
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
