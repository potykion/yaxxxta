// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUserInfo _$_$_AppUserInfoFromJson(Map json) {
  return _$_AppUserInfo(
    id: json['id'] as String?,
    userId: json['userId'] as String,
    subscriptionExpiration: json['subscriptionExpiration'] == null
        ? null
        : DateTime.parse(json['subscriptionExpiration'] as String),
  );
}

Map<String, dynamic> _$_$_AppUserInfoToJson(_$_AppUserInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'subscriptionExpiration':
          instance.subscriptionExpiration?.toIso8601String(),
    };
