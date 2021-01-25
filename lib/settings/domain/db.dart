import 'models.dart';

/// Базовый репо настроек
abstract class BaseSettingsRepo {
  /// Достает натсройки из бд, если нет, то создает по умолчанию
  Future<Settings> get();

  /// Обновляет настройки
  Future<void> update(Settings settings);
}
