import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yaxxxta/logic/core/models.dart';

part 'models.freezed.dart';

part 'models.g.dart';

/// Настроечки
@freezed
class AppSettings with _$AppSettings {
  /// Настроечки
  const factory AppSettings({
    /// Показывать выполненные привычки
    @Default(true) bool showCompleted,

    /// Показывать частично выполненные привычки
    @Default(true) bool showPartiallyCompleted,

    /// Начало дня
    required DateTime dayStartTime,

    /// Конец дня
    required DateTime dayEndTime,
  }) = _AppSettings;

  /// @nodoc
  factory AppSettings.fromJson(Map json) =>
      _$AppSettingsFromJson(Map<String, dynamic>.from(json));

  /// Создает настройки по умолчанию
  factory AppSettings.createDefault() => AppSettings(
        dayStartTime: DateTime(2020, 1, 1, 0, 0),
        dayEndTime: DateTime(2020, 1, 1, 23, 59),
      );
}

/// Данные о юзере
@freezed
abstract class UserData implements _$UserData, WithExternalId {
  const UserData._();

  /// Данные о юзере
  factory UserData({
    /// Айди
    String? id,

    /// Айди юзера
    String? userId,

    /// Айди привычек
    @Default(<String>[]) List<String> habitIds,

    /// Настройки
    required AppSettings settings,

    /// Баллы, которые можно потратить на вознаграждение
    @Default(0) int performingPoints,

    /// Айди наград
    @Default(<String>[]) List<String> rewardIds,

    /// Айди сторонней системы, напр. айди из Firebase
    @deprecated String? externalId,
  }) = _UserData;

  /// Создает из юзера
  factory UserData.fromJson(Map json) =>
      _$UserDataFromJson(Map<String, dynamic>.from(json));

  /// Создает пустышку
  factory UserData.blank({
    String? userId,
    List<String>? habitIds,
    List<String>? rewardIds,
  }) {
    return UserData(
      userId: userId,
      habitIds: habitIds ?? [],
      rewardIds: rewardIds ?? [],
      settings: AppSettings.createDefault(),
    );
  }
}
