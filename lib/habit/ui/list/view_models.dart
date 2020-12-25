import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/dt.dart';
import '../../domain/models.dart';

part 'view_models.freezed.dart';

/// Ячейка в списке дат, показываюшая прогресс за дату
class DateStatusVM {
  /// Дата
  final DateTime date;

  /// 0, 1 для простоты
  final double donePercentage;

  /// Создает ячейку
  DateStatusVM(this.date, this.donePercentage);
}

/// Вью-моделька привычки
@freezed
abstract class HabitListVM with _$HabitListVM {
  const HabitListVM._();

  /// Создает вм привычки
  @Assert("repeats.length >= 1", "Повторов должно быть >= 1")
  factory HabitListVM({
    int id,

    /// Название
    String title,

    /// Повторы (15 мин / раз 2 раза в день)
    List<HabitRepeatVM> repeats,
  }) = _HabitListVM;

  /// Создает вм из привычки
  factory HabitListVM.build(
    Habit habit, [
    List<HabitPerforming> habitPerformings = const [],
  ]) {
    var repeatHabitPerformings = groupBy<HabitPerforming, int>(
      habitPerformings,
      (p) => p.repeatIndex,
    );

    return HabitListVM(
      id: habit.id,
      title: habit.title,
      repeats: List.generate(
        habit.dailyRepeats.ceil(),
        (index) => HabitRepeatVM(
          type: habit.type,
          goalValue: habit.goalValue,
          currentValue: (repeatHabitPerformings[index] ?? [])
              .map((p) => p.performValue)
              .fold(0, (v1, v2) => v1 + v2),
        ),
      ),
    );
  }

  /// Выполнена ли все повторы привычки
  bool get isComplete => repeats.every((r) => r.isComplete);

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

  /// Строка прогресса: 4 / 10, 1:00 / 2:00
  String get progressStr =>
      HabitPerformValue(currentValue: currentValue, goalValue: goalValue)
          .format(type);

  /// Процент прогресса: 0.5
  double get progressPercentage => min(currentValue / goalValue, 1);

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

/// Прогресс привычки
class HabitPerformValue {
  /// Текущее значение
  final double currentValue;

  /// Желаемое значение
  final double goalValue;

  /// Создает прогресс
  HabitPerformValue({this.currentValue, this.goalValue});

  /// Форматирует прогресс
  String format(HabitType type) {
    if (type == HabitType.time) {
      if (goalValue != null) {
        var currentValueDur = Duration(seconds: currentValue.toInt());
        var goalValueDue = Duration(seconds: goalValue.toInt());
        return "${formatDuration(currentValueDur)} / ${formatDuration(goalValueDue)}";
      } else {
        var currentValueDur = Duration(seconds: currentValue.toInt());
        return formatDuration(currentValueDur);
      }
    }
    if (type == HabitType.repeats) {
      if (goalValue != null) {
        return "${currentValue.toInt()} / ${goalValue.toInt()}";
      } else {
        return currentValue.toInt().toString();
      }
    }
    throw "Хз как быть с type=$type";
  }
}
