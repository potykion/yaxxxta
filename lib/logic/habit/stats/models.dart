import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';

part 'models.g.dart';


@freezed
abstract class HabitStats with _$HabitStats {
  const factory HabitStats({
    @Default(0) int maxStrike,
    @Default(0) int currentStrike,
    DateTime? lastPerforming,
  }) = _HabitStats;

  factory HabitStats.fromJson(Map<String, dynamic> json) =>
      _$HabitStatsFromJson(json);
}
