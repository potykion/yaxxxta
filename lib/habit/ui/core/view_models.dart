import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/dt.dart';
import '../../domain/models.dart';

part 'view_models.freezed.dart';

/// Вью-моделька прогресса привычки
@freezed
abstract class HabitProgressVM with _$HabitProgressVM {
  const HabitProgressVM._();

  /// Вью-моделька прогресса привычки
  factory HabitProgressVM({
    String id,

    /// Название
    String title,

    /// Текущее значение (4 раза из 10)
    @Default(0) double currentValue,

    /// Целевое значение (10 раз)
    double goalValue,

    /// Время выполнения
    DateTime performTime,

    /// Тип
    HabitType type,
  }) = _HabitProgressVM;

  /// Создает вм из привычки
  factory HabitProgressVM.build(
    Habit habit, [
    List<HabitPerforming> habitPerformings,
  ]) =>
      HabitProgressVM(
        id: habit.id,
        title: habit.title,
        type: habit.type,
        goalValue: habit.goalValue,
        currentValue: (habitPerformings ?? [])
            .map((p) => p.performValue)
            .fold(0, (v1, v2) => v1 + v2),
        performTime: (habit.dailyRepeatSettings?.performTimes ?? {})[0],
      );

  /// Выполнена ли привычка
  bool get isComplete => currentValue.toInt() == goalValue.toInt();

  /// Перевыполнена ли привычка
  /// Напр. вместо 1 минуты, привычка выполнялась 2 минуты
  bool get isExceeded => currentValue > goalValue;

  /// Нужно ли выполнить привычку один раз
  bool get isSingle => type == HabitType.repeats && goalValue.toInt() == 1;

  /// Время выпалнения привычки в виде строки
  String get performTimeStr => formatTime(performTime);
}
