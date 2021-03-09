import 'models.dart';

/// Репо для работы с данными о юзере
abstract class UserDataRepo {
  /// Получает данные юзера по айди юзера
  Future<UserData?> getByUserId(String userId);

  /// Получает данные юзера по айди девайса
  Future<UserData?> getByDeviceId(String deviceId);

  /// Создает данные юзера
  Future<String> create(UserData userData);

  /// Обновляет данные юзера
  Future<void> update(UserData userData);
}
