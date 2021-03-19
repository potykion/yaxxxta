// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserData _$_$_UserDataFromJson(Map json) {
  return _$_UserData(
    id: json['id'] as String?,
    userId: json['userId'] as String?,
    deviceIds: (json['deviceIds'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    habitIds: (json['habitIds'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    settings: Settings.fromJson(json['settings'] as Map),
    performingPoints: json['performingPoints'] as int? ?? 0,
    rewardIds: (json['rewardIds'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$_$_UserDataToJson(_$_UserData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'deviceIds': instance.deviceIds,
      'habitIds': instance.habitIds,
      'settings': instance.settings.toJson(),
      'performingPoints': instance.performingPoints,
      'rewardIds': instance.rewardIds,
    };
