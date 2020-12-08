import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

/// Привычка
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

  /// Создает привычку
  Habit({
    this.id,
    this.title = "",
    this.type = HabitType.time,
    this.dailyRepeatsEnabled = false,
    this.goalValue = 0,
    this.dailyRepeats = 1,
    HabitPeriod habitPeriod,
  }) : habitPeriod = habitPeriod ?? HabitPeriod();

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
  void setGoalValueHours(double hours) =>
      goalValue = hours * 3600 + goalValueMinutes * 60 + goalValueSeconds;

  /// Устанавливает минуты продолжительности привычки
  void setGoalValueMinutes(double minutes) =>
      goalValue = goalValueHours * 3600 + minutes * 60 + goalValueSeconds;

  /// Устанавливает секунды продолжительности привычки
  void setGoalValueSeconds(double seconds) =>
      goalValue = goalValueHours * 3600 + goalValueMinutes * 60 + seconds;

  /// Увеличивает продолжительность привычки на 1%
  void increaseGoalValueByPercent() {
    goalValue = double.parse((goalValue * 1.01).toStringAsFixed(2));
  }

  /// Увеличивает кол-во повторов в течение дня на 1%
  void increaseDailyRepeatsByPercent() {
    dailyRepeats = double.parse((dailyRepeats * 1.01).toStringAsFixed(2));
  }

  /// Создает привычку из джсона
  factory Habit.fromJson(Map json) => _$HabitFromJson(json);

  /// Конвертит привычку в джсон
  Map toJson() => _$HabitToJson(this);
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
  /// Тип периодичности
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

  /// Создает периодичность привычки
  HabitPeriod({
    this.type = HabitPeriodType.day,
    this.periodValue = 1,
    List<Weekday> weekdays,
    this.monthDay = 1,
    this.isCustom = false,
  }) : weekdays = weekdays ?? [];

  /// Создает периодичность привычки из словаря
  factory HabitPeriod.fromJson(Map json) => _$HabitPeriodFromJson(json);

  /// Конвертит периодичность привычки в словарь
  Map toJson() => _$HabitPeriodToJson(this);
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
