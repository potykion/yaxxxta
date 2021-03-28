// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Habit _$_$_HabitFromJson(Map json) {
  return _$_Habit(
    id: json['id'] as String?,
    created: DateTime.parse(json['created'] as String),
    title: json['title'] as String? ?? '',
    type: _$enumDecodeNullable(_$HabitTypeEnumMap, json['type']) ??
        HabitType.repeats,
    goalValue: (json['goalValue'] as num?)?.toDouble() ?? 1,
    performTime: json['performTime'] == null
        ? null
        : DateTime.parse(json['performTime'] as String),
    periodType:
        _$enumDecodeNullable(_$HabitPeriodTypeEnumMap, json['periodType']) ??
            HabitPeriodType.day,
    periodValue: json['periodValue'] as int? ?? 1,
    performWeekdays: (json['performWeekdays'] as List<dynamic>?)
            ?.map((e) => _$enumDecode(_$WeekdayEnumMap, e))
            .toList() ??
        [],
    performMonthDay: json['performMonthDay'] as int? ?? 1,
    isCustomPeriod: json['isCustomPeriod'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_HabitToJson(_$_Habit instance) => <String, dynamic>{
      'id': instance.id,
      'created': instance.created.toIso8601String(),
      'title': instance.title,
      'type': _$HabitTypeEnumMap[instance.type],
      'goalValue': instance.goalValue,
      'performTime': instance.performTime?.toIso8601String(),
      'periodType': _$HabitPeriodTypeEnumMap[instance.periodType],
      'periodValue': instance.periodValue,
      'performWeekdays':
          instance.performWeekdays.map((e) => _$WeekdayEnumMap[e]).toList(),
      'performMonthDay': instance.performMonthDay,
      'isCustomPeriod': instance.isCustomPeriod,
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
    id: json['id'] as String?,
    habitId: json['habitId'] as String,
    performValue: (json['performValue'] as num).toDouble(),
    performDateTime: DateTime.parse(json['performDateTime'] as String),
  );
}

Map<String, dynamic> _$_$_HabitPerformingToJson(_$_HabitPerforming instance) =>
    <String, dynamic>{
      'id': instance.id,
      'habitId': instance.habitId,
      'performValue': instance.performValue,
      'performDateTime': instance.performDateTime.toIso8601String(),
    };
