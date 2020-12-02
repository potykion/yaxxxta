import 'dart:math';
import 'models.dart';
import 'utils.dart';

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
class HabitVM {
  /// Название
  final String title;

  /// Повторы (15 мин / раз 2 раза в день)
  final List<HabitRepeat> repeats;

  /// Создает вм
  HabitVM({this.title, this.repeats});

  /// Создает вм из привычки
  factory HabitVM.fromHabit(Habit habit) => HabitVM(
        title: habit.title,
        repeats: List.generate(
          habit.dailyRepeats.ceil(),
          (index) => HabitRepeat(type: habit.type, goalValue: habit.goalValue),
        ),
      );
}

/// Очередное выполнение привычки
class HabitRepeat {
  /// Текущее значение (4 раза из 10)
  double currentValue;

  /// Норматив (10 раз)
  double goalValue;

  /// Время выполнения
  DateTime performTime;

  /// Тип
  HabitType type;

  /// Создает выполнение
  HabitRepeat({
    this.performTime,
    this.type,
    this.currentValue = 0,
    this.goalValue,
  });

  /// Строка прогресса: 4 / 10, 1:00 / 2:00
  String get progressStr =>
      HabitPerformValue(currentValue: currentValue, goalValue: goalValue)
          .format(type);

  /// Процент прогресса: 0.5
  double get progressPercentage => min(currentValue, goalValue) / goalValue;

  /// Время выпалнения привычки в виде строки
  String get performTimeStr => formatTime(performTime);

  /// Нужно ли выполнить привычку один раз
  bool get isSingle => type == HabitType.repeats && goalValue.toInt() == 1;
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
