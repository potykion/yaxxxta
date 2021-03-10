import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/domain/models.dart';
import '../../core/utils/dt.dart';

part 'models.g.dart';

part 'models.freezed.dart';

/// Привычка
@freezed
abstract class Habit implements _$Habit {
  const Habit._();

  /// Создает привычку
  const factory Habit({
    /// Айдишник
    String? id,

    /// Дата создания
    required DateTime created,

    /// Название
    @Default("") String title,

    /// Тип
    @Default(HabitType.repeats) HabitType type,

    /// Продолжительность / число повторений
    @Default(1) double goalValue,

    /// Время выполнения привычки
    DateTime? performTime,

    /// Тип периодичности
    @Default(HabitPeriodType.day) HabitPeriodType periodType,

    /// 1 раз в {periodValue} дней / недель / месяцев
    @Default(1) int periodValue,

    /// [type=HabitPeriodType.week] Дни выполнения (пн, вт)
    @Default(<Weekday>[]) List<Weekday> performWeekdays,

    /// [type=HabitPeriodType.month] День выполнения
    @Default(1) int performMonthDay,

    /// Если false, то {periodValue} = 1; иначе можно задавать {periodValue} > 1
    /// Вообще тупа в гуи юзается
    @Default(false) bool isCustomPeriod,

    /// Включены ли уведомления
    @Default(false) bool isNotificationsEnabled,
  }) = _Habit;

  /// Созадет пустую привычку
  factory Habit.blank({
    DateTime? created,
    DateTime? performTime,
    bool? isNotificationsEnabled,
  }) =>
      Habit(
        created: created ?? DateTime.now(),
        performTime: performTime,
        isNotificationsEnabled: isNotificationsEnabled ?? false,
      );

  /// Если true, то привычка создана и редактируется;
  /// иначе создается новая привычка
  bool get isUpdate => id != null;

  /// Выводит часы продолжительности привычки
  double get goalValueHours => (goalValue / 3600).floorToDouble();

  /// Выводит минуты продолжительности привычки
  double get goalValueMinutes =>
      ((goalValue - goalValueHours * 3600) / 60).floorToDouble();

  /// Выводит секунды продолжительности привычки
  double get goalValueSeconds =>
      goalValue - goalValueHours * 3600 - goalValueMinutes * 60;

  /// Выставляет целевое значение из длительности
  Habit applyDuration(DoubleDuration duration) => copyWith(
        goalValue:
            duration.hours * 3600 + duration.minutes * 60 + duration.seconds,
      );

  /// Устанавливает часы продолжительности привычки
  Habit setGoalValueHours(double hours) => copyWith(
      goalValue: hours * 3600 + goalValueMinutes * 60 + goalValueSeconds);

  /// Устанавливает минуты продолжительности привычки
  Habit setGoalValueMinutes(double minutes) => copyWith(
      goalValue: goalValueHours * 3600 + minutes * 60 + goalValueSeconds);

  /// Устанавливает секунды продолжительности привычки
  Habit setGoalValueSeconds(double seconds) => copyWith(
      goalValue: goalValueHours * 3600 + goalValueMinutes * 60 + seconds);

  /// Увеличивает продолжительность привычки на 1%
  Habit increaseGoalValueByPercent() =>
      copyWith(goalValue: double.parse((goalValue * 1.01).toStringAsFixed(2)));

  /// Создает привычку из джсона
  factory Habit.fromJson(Map json) =>
      _$HabitFromJson(Map<String, dynamic>.from(json));

  /// Чекает входит ли дата в периодичность привычки
  /// Например, если периодичность еженедельная по пн,
  /// то вызов метода с 2021-01-04 вернет true
  bool matchDate(DateTime date) {
    switch (periodType) {
      case HabitPeriodType.day:
        return (yearDayNum(date) - yearDayNum(created)) % periodValue == 0;

      case HabitPeriodType.week:
        return (yearWeekNum(date) - yearWeekNum(created)) % periodValue == 0 &&
            performWeekdays.contains(weekdayFromInt(date.weekday));

      case HabitPeriodType.month:
        return (date.month - created.month) % periodValue == 0 &&
            date.day == min(performMonthDay, endOfMonth(date));

      default:
        throw "wtf period.type=$type";
    }
  }

  /// Вычисляет очередное время выполнения привычки
  ///
  /// Напр. если привычка ежедневная и время выполнения 14:00,
  /// а сегодня 2020-01-01 15:00,
  /// то след время выполнения будет 2020-01-02 14:00
  Iterable<DateTime> nextPerformDateTime([DateTime? now]) sync* {
    assert(performTime != null);

    now = now ?? DateTime.now();

    var current = buildDateTime(created, performTime!);

    if (periodType == HabitPeriodType.day) {
      while (true) {
        if (current.isAfter(now) && matchDate(current)) {
          yield current;
        }
        current = current.add(Duration(days: periodValue));
      }
    }
    if (periodType == HabitPeriodType.week) {
      var weekStart = current.add(Duration(days: -current.weekday + 1));
      var weekRepeats = performWeekdays
          .map((w) => weekStart.add(Duration(days: w.index)))
          .toList();
      var weekRepeatIndexes =
          List.generate(weekRepeats.length, (index) => index);

      while (true) {
        for (var index in weekRepeatIndexes) {
          if (weekRepeats[index].isAfter(now) &&
              matchDate(weekRepeats[index])) {
            yield weekRepeats[index];
          }
          weekRepeats[index] =
              weekRepeats[index].add(Duration(days: periodValue * 7));
        }
      }
    }
    if (periodType == HabitPeriodType.month) {
      while (true) {
        current =
            current.copyWith(day: min(performMonthDay, endOfMonth(current)));

        if (current.isAfter(now) && matchDate(current)) {
          yield current;
        }

        current = current.copyWith(month: current.month + periodValue);
      }
    }
  }
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

/// Форматирует день недели
extension FormatWeekday on Weekday {
  /// Форматирует день недели
  String format() {
    switch (this) {
      case Weekday.monday:
        return "Пн";
      case Weekday.tuesday:
        return "Вт";
      case Weekday.wednesday:
        return "Ср";
      case Weekday.thursday:
        return "Чт";
      case Weekday.friday:
        return "Пт";
      case Weekday.saturday:
        return "Сб";
      case Weekday.sunday:
        return "Вс";
      default:
        throw "Failed to format: $this";
    }
  }
}

/// Создает день недели из инта
Weekday weekdayFromInt(int weekdayInt) {
  switch (weekdayInt) {
    case 1:
      return Weekday.monday;
    case 2:
      return Weekday.tuesday;
    case 3:
      return Weekday.wednesday;
    case 4:
      return Weekday.thursday;
    case 5:
      return Weekday.friday;
    case 6:
      return Weekday.saturday;
    case 7:
      return Weekday.sunday;
    default:
      throw "Wtf: weekdayInt = $weekdayInt";
  }
}

/// Тип периодичности
enum HabitPeriodType {
  /// Ежедневно
  day,

  /// Еженедельно
  week,

  /// Ежемесячно
  month,
}

/// Форматирует тип периода привычки
extension FormatHabitPeriodType on HabitPeriodType {
  /// Переводит тип периода привычки в строку
  String verbose() {
    switch (this) {
      case HabitPeriodType.day:
        return "Ежедневная";
      case HabitPeriodType.week:
        return "Еженедельная";
      case HabitPeriodType.month:
        return "Ежемесячная";
      default:
        throw "хз че делать: this=$this";
    }
  }

  /// Форматирует тип периода привычки
  String format() {
    if (this == HabitPeriodType.day) return "День";
    if (this == HabitPeriodType.week) return "Неделя";
    if (this == HabitPeriodType.month) return "Месяц";
    throw "FormatHabitPeriodType.format on ${this}";
  }
}

/// Тип привычки
enum HabitType {
  /// На время
  time,

  /// На повторы
  repeats,
}

/// Переводит тип привычки в строку
extension HabitTypeToStr on HabitType {
  /// Переводит тип привычки в строку
  String verbose() {
    if (this == HabitType.time) {
      return "На время";
    }
    if (this == HabitType.repeats) {
      return "На повторы";
    }
    throw "хз что за тип: this=$this";
  }
}

/// Выполнение прички
@freezed
abstract class HabitPerforming implements _$HabitPerforming {
  const HabitPerforming._();

  /// Создает выполнение привычки
  factory HabitPerforming({
    /// Айди выполнения привычки
    String? id,

    /// Айди привычки
    required String habitId,

    /// Значение выполнения (напр. 10 сек)
    required double performValue,

    /// Время выполнения
    required DateTime performDateTime,
  }) = _HabitPerforming;

  /// Создает пустышку
  factory HabitPerforming.blank({
    required String habitId,
    double? performValue,
    DateTime? performDateTime,
  }) {
    return HabitPerforming(
      habitId: habitId,
      performValue: performValue ?? 1,
      performDateTime: performDateTime ?? DateTime.now(),
    );
  }

  /// Создает выполнение привычки из словаря
  factory HabitPerforming.fromJson(Map json) =>
      _$HabitPerformingFromJson(Map<String, dynamic>.from(json));
}
