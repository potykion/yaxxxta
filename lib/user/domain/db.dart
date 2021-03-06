import 'models.dart';

abstract class UserDataRepo {
  Future<UserData?> getByUserId(String userId);

  Future<UserData?> getByDeviceId(String deviceId);

  Future<void> create(UserData userData);
  Future<void> update(UserData userData);
}
