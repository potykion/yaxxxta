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
  get progressStr =>
      HabitPerformValue(currentValue: currentValue, goalValue: goalValue)
          .format(type);

  /// Процент прогресса: 0.5
  get progressPercentage => min(currentValue, goalValue) / goalValue;

  get performTimeStr => formatTime(performTime);

  get isSingle => type == HabitType.repeats && this.goalValue.toInt() == 1;
}

/// Тип привычки
enum HabitType {
  /// На время
  time,

  /// На повторы
  repeats,
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

enum HabitPeriodType { day, week, month }

extension FormatHabitPeriodType on HabitPeriodType {
  String format() {
    if (this == HabitPeriodType.day) return "День";
    if (this == HabitPeriodType.week) return "Неделя";
    if (this == HabitPeriodType.month) return "Месяц";
    throw "FormatHabitPeriodType.format on ${this}";
  }
}

class HabitWriteVM {
  /// Название
  String title;

  /// Тип
  HabitType type;

  /// Если true, то привычка создана и редактируется; иначе создается новая привычка
  bool isUpdate;

  /// Повторы в течение дня включены
  bool dailyRepeatsEnabled;

  /// Продолжительность / число повторений за раз
  double goalValue;

  /// Число повторений за день
  double dailyRepeats;

  /// Периодичность
  HabitPeriod habitPeriod;

  HabitWriteVM({this.title, this.type, this.isUpdate});
}

/// Периодичность
/// Ежедневная периодичность:
///   - 1 раз в день
///   - 1 раз в 2 дня
/// Еженедельная периодичность:
///   - 1 раз в 1 неделю
///   - 2 раза в неделю (пн, вт)
///   - 1 раз в 2 недели
/// Ежемесячная периодичность:
///   - каждое 10 число месяца
class HabitPeriod {
  HabitPeriodType type;

  /// 1 раз в {periodValue} дней / недель / месяцев
  int periodValue;

  /// [type=HabitPeriodType.week] Дни выполнения (пн, вт)
  /// Аналог "Число повторений за день" для недель
  List<Weekday> weekdays;

  /// [type=HabitPeriodType.month] День выполнения
  int monthDay;

  /// Если false, то {periodValue} = 1; иначе можно задавать {periodValue} > 1
  bool isCustom;
}

/// День недели
enum Weekday {
  /// Понедельник
  monday,

  /// Вторник
  tuesday,

  /// Среда
  wednesday,

  /// Четверг
  thursday,

  /// Пятница
  friday,

  /// Суббота
  saturday,

  /// Воскресенье
  sunday,
}
