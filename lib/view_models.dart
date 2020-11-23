import 'dart:math';
import 'package:intl/intl.dart';

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
    this.currentValue,
    this.goalValue,
  });

  /// Строка прогресса: 4 / 10, 1:00 / 2:00
  get progressStr {
    if (type == HabitType.time) {
      var currentValueDur = Duration(seconds: currentValue.toInt());
      var goalValueDue = Duration(seconds: goalValue.toInt());
      return "${formatDuration(currentValueDur)} / ${formatDuration(goalValueDue)}";
    }
    if (type == HabitType.repeats) {
      return "${currentValue.toInt()} / ${goalValue.toInt()}";
    }
    throw "Хз как быть с type=$type";
  }

  /// Процент прогресса: 0.5
  get progressPercentage => min(currentValue, goalValue) / goalValue;

  get performTimeStr => DateFormat.Hm().format(performTime);

  get isSingle => type == HabitType.repeats && this.goalValue.toInt() == 1;
}

/// Тип привычки
enum HabitType {
  /// На время
  time,

  /// На повторы
  repeats,
}
