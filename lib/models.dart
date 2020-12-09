import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

part 'models.freezed.dart';

/// Привычка
@freezed
abstract class Habit with _$Habit {
  const Habit._();

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
    @Default(0) double goalValue,

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
    @Default(const <Weekday>[]) List<Weekday> weekdays,

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
    if (this == Weekday.monday) return "Пн";
    if (this == Weekday.tuesday) return "Вт";
    if (this == Weekday.wednesday) return "Ср";
    if (this == Weekday.thursday) return "Чт";
    if (this == Weekday.friday) return "Пт";
    if (this == Weekday.saturday) return "Сб";
    if (this == Weekday.sunday) return "Вс";
    throw "Failed to format: $this";
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

class HabitPerforming {
  final int habitId;
  final DateTime dateTime;
  final int repeatIndex;
  final double performValue;

  HabitPerforming({
    this.habitId,
    this.dateTime,
    this.repeatIndex,
    this.performValue,
  });
}
