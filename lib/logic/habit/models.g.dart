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
  );
}

Map<String, dynamic> _$_$_HabitToJson(_$_Habit instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'userId': instance.userId,
    };
