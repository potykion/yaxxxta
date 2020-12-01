import 'dart:math';
import 'models.dart';
import 'utils.dart';

/// Ячейка в списке дат, показываюшая прогресс за дату
class DateStatusVM {
  final DateTime date;

  /// 0, 1 для простоты
  final double donePercentage;

  DateStatusVM(this.date, this.donePercentage);
}

class HabitVM {
  /// Название
  final String title;

  /// Повторы (15 мин / раз 2 раза в день)
  final List<HabitRepeat> repeats;

  HabitVM({this.title, this.repeats});

  factory HabitVM.fromHabit(Habit habit) => HabitVM(
        title: habit.title,
        repeats: List.generate(
          habit.dailyRepeats.ceil(),
          (index) => HabitRepeat(
            type: habit.type,
            goalValue: habit.goalValue
          ),
        ),
      );
}

/// Очередное выполнение привычки
class HabitRepeat {
  /// Текущее значение (4 раза из 10)
  final double currentValue;

  /// Норматив (10 раз)
  final double goalValue;

  /// Время выполнения
  final DateTime performTime;

  /// Тип
  final HabitType type;

  HabitRepeat({
    this.performTime,
    this.type,
    this.currentValue = 0,
    this.goalValue,
  });

  /// Строка прогресса: 4 / 10, 1:00 / 2:00
  get progressStr =>
      HabitPerformValue(currentValue: currentValue, goalValue: goalValue)
          .format(type);

  /// Процент прогресса: 0.5
  get progressPercentage => min(currentValue, goalValue) / goalValue;

  get performTimeStr => formatTime(performTime);

  get isSingle => type == HabitType.repeats && this.goalValue.toInt() == 1;
}

class HabitHistoryEntry {
  final DateTime datetime;
  final double value;

  HabitHistoryEntry({this.datetime, this.value});

  format(HabitType type) =>
      HabitPerformValue(currentValue: this.value).format(type);
}

class HabitPerformValue {
  final double currentValue;
  final double goalValue;

  HabitPerformValue({this.currentValue, this.goalValue});

  format(HabitType type) {
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
