// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Settings _$_$_SettingsFromJson(Map json) {
  return _$_Settings(
    showCompleted: json['showCompleted'] as bool? ?? true,
    showPartiallyCompleted: json['showPartiallyCompleted'] as bool? ?? true,
    dayStartTime: DateTime.parse(json['dayStartTime'] as String),
    dayEndTime: DateTime.parse(json['dayEndTime'] as String),
  );
}

Map<String, dynamic> _$_$_SettingsToJson(_$_Settings instance) =>
    <String, dynamic>{
      'showCompleted': instance.showCompleted,
      'showPartiallyCompleted': instance.showPartiallyCompleted,
      'dayStartTime': instance.dayStartTime.toIso8601String(),
      'dayEndTime': instance.dayEndTime.toIso8601String(),
    };
