// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserData _$_$_UserDataFromJson(Map json) {
  return _$_UserData(
    userId: json['userId'] as String,
    deviceIds: (json['deviceIds'] as List)?.map((e) => e as String)?.toList(),
    habitIds: (json['habitIds'] as List)?.map((e) => e as String)?.toList(),
    settings: json['settings'] == null
        ? null
        : Settings.fromJson(json['settings'] as Map),
  );
}

Map<String, dynamic> _$_$_UserDataToJson(_$_UserData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'deviceIds': instance.deviceIds,
      'habitIds': instance.habitIds,
      'settings': instance.settings?.toJson(),
    };
