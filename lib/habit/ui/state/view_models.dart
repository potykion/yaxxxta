import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/utils.dart';
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
abstract class HabitVM with _$HabitVM {
  /// Создает вм привычки
  @Assert("repeats.length >= 1", "Повторов должно быть >= 1")
  factory HabitVM({
    int id,

    /// Название
    String title,

    /// Повторы (15 мин / раз 2 раза в день)
    List<HabitRepeatVM> repeats,
  }) = _HabitVM;

  /// Создает вм из привычки
  factory HabitVM.fromHabit(Habit habit) => HabitVM(
        id: habit.id,
        title: habit.title,
        repeats: List.generate(
          habit.dailyRepeats.ceil(),
          (index) =>
              HabitRepeatVM(type: habit.type, goalValue: habit.goalValue),
        ),
      );
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
  double get progressPercentage =>
      goalValue == 0 ? 0 : (min(currentValue, goalValue) / goalValue);

  /// Время выпалнения привычки в виде строки
  String get performTimeStr => formatTime(performTime);

  /// Нужно ли выполнить привычку один раз
  bool get isSingle => type == HabitType.repeats && goalValue.toInt() == 1;

  bool get isComplete => currentValue == goalValue;
}

/// Запись о выполнении привычки в прошлом
class HabitHistoryEntry {
  /// Дата
  final DateTime datetime;

  /// Изменеие значения привычки
  final double value;

  /// Создает запись
  HabitHistoryEntry({this.datetime, this.value});

  /// Форматирует значение записи
  String format(HabitType type) =>
      HabitPerformValue(currentValue: value).format(type);
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
