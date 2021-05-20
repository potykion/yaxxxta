// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUserInfo _$_$_AppUserInfoFromJson(Map json) {
  return _$_AppUserInfo(
    id: json['id'] as String?,
    userId: json['userId'] as String,
    haveSubscription: json['haveSubscription'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_AppUserInfoToJson(_$_AppUserInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'haveSubscription': instance.haveSubscription,
    };
