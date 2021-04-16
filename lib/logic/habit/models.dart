import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaxxxta/logic/core/models.dart';

part 'models.freezed.dart';

part 'models.g.dart';

@freezed
abstract class Habit implements _$Habit, WithId {
  const Habit._();

  const factory Habit({
    String? id,
    required String title,
    required String userId,
  }) = _Habit;

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);
}

@freezed
abstract class HabitPerforming implements _$HabitPerforming, WithId {
  const HabitPerforming._();

  const factory HabitPerforming(
      {String? id,
      required DateTime created,
      required String habitId}) = _HabitPerforming;

  factory HabitPerforming.fromJson(Map<String, dynamic> json) =>
      _$HabitPerformingFromJson(json);

  factory HabitPerforming.blank(String habitId) {
    return HabitPerforming(created: DateTime.now(), habitId: habitId);
  }
}
