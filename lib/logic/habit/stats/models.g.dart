// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_HabitStats _$_$_HabitStatsFromJson(Map json) {
  return _$_HabitStats(
    maxStrike: json['maxStrike'] as int? ?? 0,
    currentStrike: json['currentStrike'] as int? ?? 0,
    lastPerforming: json['lastPerforming'] == null
        ? null
        : DateTime.parse(json['lastPerforming'] as String),
  );
}

Map<String, dynamic> _$_$_HabitStatsToJson(_$_HabitStats instance) =>
    <String, dynamic>{
      'maxStrike': instance.maxStrike,
      'currentStrike': instance.currentStrike,
      'lastPerforming': instance.lastPerforming?.toIso8601String(),
    };
