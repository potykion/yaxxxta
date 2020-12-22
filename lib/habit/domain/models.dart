import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

part 'models.freezed.dart';

/// Привычка
@freezed
abstract class Habit with _$Habit {
  const Habit._();

  /// Создает привычку
  const factory Habit({
    /// Айдишник
    int id,

    /// Название
    @Default("") String title,

    /// Тип
    @Default(HabitType.time) HabitType type,

    /// Повторы в течение дня включены
    @Default(false) bool dailyRepeatsEnabled,

    /// Продолжительность / число повторений за раз
    @Default(1) double goalValue,

    /// Число повторений за день
    @Default(1) double dailyRepeats,

    /// Периодичность
    @required HabitPeriod habitPeriod,
  }) = _Habit;

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

  /// Увеличивает кол-во повторов в течение дня на 1%
  Habit increaseDailyRepeatsByPercent() => copyWith(
      dailyRepeats: double.parse((dailyRepeats * 1.01).toStringAsFixed(2)));

  /// Создает привычку из джсона
  factory Habit.fromJson(Map json) =>
      _$HabitFromJson(Map<String, dynamic>.from(json));
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
@freezed
abstract class HabitPeriod with _$HabitPeriod {
  /// Создает периодичность привычки

  const factory HabitPeriod({
    /// Тип периодичности
    @Default(HabitPeriodType.day) HabitPeriodType type,

    /// 1 раз в {periodValue} дней / недель / месяцев
    @Default(1) int periodValue,

    /// [type=HabitPeriodType.week] Дни выполнения (пн, вт)
    /// Аналог "Число повторений за день" для недель
    @Default(<Weekday>[]) List<Weekday> weekdays,

    /// [type=HabitPeriodType.month] День выполнения
    @Default(1) int monthDay,

    /// Если false, то {periodValue} = 1; иначе можно задавать {periodValue} > 1
    @Default(false) bool isCustom,
  }) = _HabitPeriod;

  /// Создает периодичность привычки из словаря
  factory HabitPeriod.fromJson(Map json) =>
      _$HabitPeriodFromJson(Map<String, dynamic>.from(json));
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

/// Выполнение прички
@freezed
abstract class HabitPerforming with _$HabitPerforming {
  /// Создает выполнение привычки
  factory HabitPerforming({
    /// Айди привычки
    @required int habitId,

    /// Раз выполнения (напр. 1 из 2)
    @required int repeatIndex,

    /// Значение выполнения (напр. 10 сек)
    @required double performValue,

    /// Время выполнения
    @required DateTime performDateTime,
  }) = _HabitPerforming;

  /// Создает выполнение привычки из словаря
  factory HabitPerforming.fromJson(Map json) =>
      _$HabitPerformingFromJson(Map<String, dynamic>.from(json));
}
