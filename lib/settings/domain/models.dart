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

    /// Начало дня
    DateTime dayStartTime,

    /// Конец дня
    DateTime dayEndTime,
  }) = _Settings;

  /// @nodoc
  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);
}
