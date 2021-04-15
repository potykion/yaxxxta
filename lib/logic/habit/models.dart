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
