// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Habit _$_$_HabitFromJson(Map json) {
  return _$_Habit(
    id: json['id'] as String?,
    title: json['title'] as String,
    userId: json['userId'] as String,
    order: json['order'] as int,
  );
}

Map<String, dynamic> _$_$_HabitToJson(_$_Habit instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'userId': instance.userId,
      'order': instance.order,
    };

_$_HabitPerforming _$_$_HabitPerformingFromJson(Map json) {
  return _$_HabitPerforming(
    id: json['id'] as String?,
    created: DateTime.parse(json['created'] as String),
    habitId: json['habitId'] as String,
  );
}

Map<String, dynamic> _$_$_HabitPerformingToJson(_$_HabitPerforming instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created': instance.created.toIso8601String(),
      'habitId': instance.habitId,
    };
