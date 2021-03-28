// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppSettings _$_$_AppSettingsFromJson(Map json) {
  return _$_AppSettings(
    showCompleted: json['showCompleted'] as bool? ?? true,
    showPartiallyCompleted: json['showPartiallyCompleted'] as bool? ?? true,
    dayStartTime: DateTime.parse(json['dayStartTime'] as String),
    dayEndTime: DateTime.parse(json['dayEndTime'] as String),
  );
}

Map<String, dynamic> _$_$_AppSettingsToJson(_$_AppSettings instance) =>
    <String, dynamic>{
      'showCompleted': instance.showCompleted,
      'showPartiallyCompleted': instance.showPartiallyCompleted,
      'dayStartTime': instance.dayStartTime.toIso8601String(),
      'dayEndTime': instance.dayEndTime.toIso8601String(),
    };

_$_UserData _$_$_UserDataFromJson(Map json) {
  return _$_UserData(
    id: json['id'] as String?,
    userId: json['userId'] as String?,
    habitIds: (json['habitIds'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    settings: AppSettings.fromJson(json['settings'] as Map),
    performingPoints: json['performingPoints'] as int? ?? 0,
    rewardIds: (json['rewardIds'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    externalId: json['externalId'] as String?,
  );
}

Map<String, dynamic> _$_$_UserDataToJson(_$_UserData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'habitIds': instance.habitIds,
      'settings': instance.settings.toJson(),
      'performingPoints': instance.performingPoints,
      'rewardIds': instance.rewardIds,
      'externalId': instance.externalId,
    };
