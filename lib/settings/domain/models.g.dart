// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Settings _$_$_SettingsFromJson(Map json) {
  return _$_Settings(
    showCompleted: json['showCompleted'] as bool ?? true,
    dayStartTime: json['dayStartTime'] == null
        ? null
        : DateTime.parse(json['dayStartTime'] as String),
    dayEndTime: json['dayEndTime'] == null
        ? null
        : DateTime.parse(json['dayEndTime'] as String),
  );
}

Map<String, dynamic> _$_$_SettingsToJson(_$_Settings instance) =>
    <String, dynamic>{
      'showCompleted': instance.showCompleted,
      'dayStartTime': instance.dayStartTime?.toIso8601String(),
      'dayEndTime': instance.dayEndTime?.toIso8601String(),
    };