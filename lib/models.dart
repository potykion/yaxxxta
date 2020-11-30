import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class Habit {
  /// Айдишник
  int id;

  /// Название
  String title;

  /// Тип
  HabitType type;

  /// Повторы в течение дня включены
  bool dailyRepeatsEnabled;

  /// Продолжительность / число повторений за раз
  double goalValue;

  /// Число повторений за день
  double dailyRepeats;

  /// Периодичность
  HabitPeriod habitPeriod;

  Habit({
    this.id,
    this.title = "",
    this.type = HabitType.time,
    this.dailyRepeatsEnabled = false,
    this.goalValue = 0,
    this.dailyRepeats = 1,
    habitPeriod,
  }) : habitPeriod = habitPeriod ?? HabitPeriod();

  /// Если true, то привычка создана и редактируется; иначе создается новая привычка
  bool get isUpdate => id != null;

  double get goalValueHours => (goalValue / 3600).floorToDouble();

  double get goalValueMinutes =>
      ((goalValue - goalValueHours * 3600) / 60).floorToDouble();

  double get goalValueSeconds =>
      goalValue - goalValueHours * 3600 - goalValueMinutes * 60;

  setGoalValueHours(double hours) =>
      goalValue = hours * 3600 + goalValueMinutes * 60 + goalValueSeconds;

  setGoalValueMinutes(double minutes) =>
      goalValue = goalValueHours * 3600 + minutes * 60 + goalValueSeconds;

  setGoalValueSeconds(double seconds) =>
      goalValue = goalValueHours * 3600 + goalValueMinutes * 60 + seconds;

  increaseGoalValueByPercent() {
    goalValue = num.parse((goalValue * 1.01).toStringAsFixed(2));
  }

  increaseDailyRepeatsByPercent() {
    dailyRepeats = double.parse((dailyRepeats * 1.01).toStringAsFixed(2));
  }

  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  Map<String, dynamic> toJson() => _$HabitToJson(this);
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
@JsonSerializable()
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

  HabitPeriod({
    this.type = HabitPeriodType.day,
    this.periodValue = 1,
    weekdays,
    this.monthDay = 1,
    this.isCustom = false,
  }) : weekdays = weekdays ?? [];

  factory HabitPeriod.fromJson(Map<String, dynamic> json) =>
      _$HabitPeriodFromJson(json);

  Map<String, dynamic> toJson() => _$HabitPeriodToJson(this);
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

extension FormatWeekday on Weekday {
  format() {
    if (this == Weekday.monday) return "Пн";
    if (this == Weekday.tuesday) return "Вт";
    if (this == Weekday.wednesday) return "Ср";
    if (this == Weekday.thursday) return "Чт";
    if (this == Weekday.friday) return "Пт";
    if (this == Weekday.saturday) return "Сб";
    if (this == Weekday.sunday) return "Вс";
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

/// Тип привычки
enum HabitType {
  /// На время
  time,

  /// На повторы
  repeats,
}
