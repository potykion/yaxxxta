// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Transaction _$_$_TransactionFromJson(Map json) {
  return _$_Transaction(
    id: json['id'] as String?,
    createed: DateTime.parse(json['createed'] as String),
    performingPoints: json['performingPoints'] as int,
    userId: json['userId'] as String,
  );
}

Map<String, dynamic> _$_$_TransactionToJson(_$_Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createed': instance.createed.toIso8601String(),
      'performingPoints': instance.performingPoints,
      'userId': instance.userId,
    };
