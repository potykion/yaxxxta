import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:yaxxxta/logic/core/models.dart';
import 'package:yaxxxta/logic/notifications/models.dart';

part 'models.freezed.dart';

part 'models.g.dart';

/// День недели
enum Weekday {
  /// Понедельник
  Monday,

  /// Вторник
  Tuesday,

  /// Среда
  Wednesday,

  /// Четверг
  Thursday,

  /// Пятница
  Friday,

  /// Суббота
  Saturday,

  /// Воскресенье
  Sunday
}

/// Расширения над Weekday
extension WeekdayUtils on Weekday {
  /// Конвертит в строку-сокращение, типа пн для понедельника
  String toAbbrString() {
    if (this == Weekday.Monday) return "пн";
    if (this == Weekday.Tuesday) return "вт";
    if (this == Weekday.Wednesday) return "ср";
    if (this == Weekday.Thursday) return "чт";
    if (this == Weekday.Friday) return "пт";
    if (this == Weekday.Saturday) return "сб";
    if (this == Weekday.Sunday) return "вс";
    throw "Weekday.toAbbrString() failed for $this";
  }
}

/// Периодичность привычки
enum HabitFrequencyType {
  /// Ежедневная
  daily,

  /// Еженедельная
  weekly,
}

/// Расширения над HabitFrequencyType
extension HabitFreqTypeExt on HabitFrequencyType {
  /// Конвертит в строку
  String toVerboseStr() {
    if (this == HabitFrequencyType.daily) return "Ежедневная";
    if (this == HabitFrequencyType.weekly) return "Еженедельная";
    throw "HabitFrequencyType.toVerboseStr failed for ${this}";
  }
}

/// Привычка
@freezed
abstract class Habit implements _$Habit, WithId {
  const Habit._();

  /// Привычка
  const factory Habit({
    String? id,
    required String title,
    required String userId,
    required int order,
    @Default(false) bool archived,
    HabitNotificationSettings? notification,
    @Default(HabitFrequencyType.daily) HabitFrequencyType frequencyType,

    /// В какой день выполняется привычка?
    /// Актуально только для еженедельных привычек
    Weekday? performWeekday,
  }) = _Habit;

  /// Создает из джсона
  factory Habit.fromJson(Map<String, dynamic> json) => _$HabitFromJson(json);

  /// Создает пустышку
  factory Habit.blank({required String userId}) {
    return Habit(
      title: "",
      userId: userId,
      order: DateTime.now().millisecondsSinceEpoch,
    );
  }
}

/// Настройки уведомлений привычки
@freezed
abstract class HabitNotificationSettings
    implements _$HabitNotificationSettings {
  const HabitNotificationSettings._();

  /// Настройки уведомлений привычки
  factory HabitNotificationSettings({
    required DateTime time,
  }) = _HabitNotificationSettings;

  /// Создает из джсонки
  factory HabitNotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$HabitNotificationSettingsFromJson(json);

  /// Форматирует как время
  String toTimeStr() => DateFormat.Hm().format(time);
}

/// Выполнение привычки
@freezed
abstract class HabitPerforming implements _$HabitPerforming, WithId {
  const HabitPerforming._();

  /// Выполнение привычки
  const factory HabitPerforming({
    String? id,
    required DateTime created,
    required String habitId,
    required String userId,
  }) = _HabitPerforming;

  /// Создает из джсона
  factory HabitPerforming.fromJson(Map<String, dynamic> json) =>
      _$HabitPerformingFromJson(json);

  /// Создает пустышку
  factory HabitPerforming.blank(String habitId, String userId,
      [DateTime? performDatetime]) {
    return HabitPerforming(
      created: performDatetime ?? DateTime.now(),
      habitId: habitId,
      userId: userId,
    );
  }
}
