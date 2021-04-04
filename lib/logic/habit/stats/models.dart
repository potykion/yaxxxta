import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';

part 'models.freezed.dart';

part 'models.g.dart';

/// Стата по привычке
@freezed
abstract class HabitStats with _$HabitStats {
  const HabitStats._();

  /// Стата по привычке
  const factory HabitStats({
    @Default(0) int maxStrike,
    @Default(0) int currentStrike,
    DateTime? lastPerforming,
  }) = _HabitStats;

  /// Создает из джсона
  factory HabitStats.fromJson(Map<String, dynamic> json) =>
      _$HabitStatsFromJson(json);

  /// Определяет давно ли не выполнялась привычка
  bool isPerformedLongAgo(DateRange todayDateRange) => lastPerforming == null
      ? false
      : todayDateRange.date.difference(lastPerforming!) >= Duration(days: 2);

  /// Считает страйк за текущий день
  int computeTodayCurrentStrike(DateRange todayDateRange) =>
      isPerformedLongAgo(todayDateRange) ? 0 : currentStrike;
}
