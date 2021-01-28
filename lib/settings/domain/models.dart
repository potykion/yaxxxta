import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';

part 'models.g.dart';

/// Настроечки
@freezed
abstract class Settings with _$Settings {
  /// @nodoc
  const factory Settings({
    /// Показывать выполненные привычки
    @Default(true) bool showCompleted,

    /// Показывать частично выполненные привычки
    @Default(true) bool showPartiallyCompleted,

    /// Начало дня
    DateTime dayStartTime,

    /// Конец дня
    DateTime dayEndTime,
  }) = _Settings;

  /// @nodoc
  factory Settings.fromJson(Map json) =>
      _$SettingsFromJson(Map<String, dynamic>.from(json));

  /// Создает настройки по умолчанию
  factory Settings.createDefault() => Settings(
        dayStartTime: DateTime(2020, 1, 1, 0, 0),
        dayEndTime: DateTime(2020, 1, 1, 23, 59),
      );
}
