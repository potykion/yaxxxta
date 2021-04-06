// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HabitTransaction _$_$HabitTransactionFromJson(Map json) {
  return _$HabitTransaction(
    id: json['id'] as String?,
    externalId: json['externalId'] as String?,
    created: DateTime.parse(json['created'] as String),
    performingPoints: json['performingPoints'] as int? ?? 1,
    userId: json['userId'] as String?,
    habitId: json['habitId'] as String,
  );
}

Map<String, dynamic> _$_$HabitTransactionToJson(_$HabitTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'created': instance.created.toIso8601String(),
      'performingPoints': instance.performingPoints,
      'userId': instance.userId,
      'habitId': instance.habitId,
    };

_$RewardTransaction _$_$RewardTransactionFromJson(Map json) {
  return _$RewardTransaction(
    id: json['id'] as String?,
    externalId: json['externalId'] as String?,
    created: DateTime.parse(json['created'] as String),
    performingPoints: json['performingPoints'] as int,
    userId: json['userId'] as String?,
    rewardId: json['rewardId'] as String,
  );
}

Map<String, dynamic> _$_$RewardTransactionToJson(
        _$RewardTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'externalId': instance.externalId,
      'created': instance.created.toIso8601String(),
      'performingPoints': instance.performingPoints,
      'userId': instance.userId,
      'rewardId': instance.rewardId,
    };
