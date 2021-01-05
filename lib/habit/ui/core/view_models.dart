import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/dt.dart';
import '../../domain/models.dart';

part 'view_models.freezed.dart';

/// Вью-моделька прогресса привычки
@freezed
abstract class HabitProgressVM with _$HabitProgressVM {
  const HabitProgressVM._();

  /// Вью-моделька прогресса привычки
  @Assert("repeats.length >= 1", "Повторов должно быть >= 1")
  factory HabitProgressVM({
    String id,

    /// Название
    String title,

    /// Повторы (15 мин / раз 2 раза в день)
    List<HabitRepeatVM> repeats,
  }) = _HabitProgressVM;

  /// Создает вм из привычки
  factory HabitProgressVM.build(
    Habit habit, [
    List<HabitPerforming> habitPerformings = const [],
  ]) {
    var repeatHabitPerformings = groupBy<HabitPerforming, int>(
      habitPerformings,
      (p) => p.repeatIndex,
    );

    return HabitProgressVM(
      id: habit.id,
      title: habit.title,
      repeats: List.generate(
        habit.dailyRepeatSettings.repeatsCount.ceil(),
        (index) => HabitRepeatVM(
          type: habit.type,
          goalValue: habit.goalValue,
          currentValue: (repeatHabitPerformings[index] ?? [])
              .map((p) => p.performValue)
              .fold(0, (v1, v2) => v1 + v2),
          performTime: habit.dailyRepeatSettings.performTimes[index],
        ),
      ),
    );
  }

  /// Выполнена ли все повторы привычки
  bool get isComplete => repeats.every((r) => r.isComplete);

  HabitRepeatVM get firstRepeat => repeats.first;

  /// Первый индекс невыполненного повтора привычки
  int get firstIncompleteRepeatIndex {
    if (repeats.every((r) => r.isComplete || r.isExceeded)) {
      return repeats.length - 1;
    }

    return repeats
        .asMap()
        .entries
        .where((e) => !e.value.isComplete && !e.value.isExceeded)
        .first
        .key;
  }
}

/// Очередное выполнение привычки
@freezed
abstract class HabitRepeatVM implements _$HabitRepeatVM {
  const HabitRepeatVM._();

  /// Создает вм повтора привычки
  factory HabitRepeatVM({
    /// Текущее значение (4 раза из 10)
    @Default(0) double currentValue,

    /// Норматив (10 раз)
    double goalValue,

    /// Время выполнения
    DateTime performTime,

    /// Тип
    HabitType type,
  }) = _HabitRepeatVM;

  /// Время выпалнения привычки в виде строки
  String get performTimeStr => formatTime(performTime);

  /// Нужно ли выполнить привычку один раз
  bool get isSingle => type == HabitType.repeats && goalValue.toInt() == 1;

  /// Выполнена ли привычка
  bool get isComplete => currentValue.toInt() == goalValue.toInt();

  /// Перевыполнена ли привычка
  /// Напр. вместо 1 минуты, привычка выполнялась 2 минуты
  bool get isExceeded => currentValue > goalValue;
}
