// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Reward _$_$_RewardFromJson(Map json) {
  return _$_Reward(
    id: json['id'] as String?,
    title: json['title'] as String,
    cost: json['cost'] as int,
    collected: json['collected'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_RewardToJson(_$_Reward instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cost': instance.cost,
      'collected': instance.collected,
    };
