import 'package:cloud_firestore/cloud_firestore.dart';

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

/// Фаерстор репо для данных о юзере
class FirestoreUserDataRepo implements UserDataRepo {
  final CollectionReference _collectionReference;

  /// Фаерстор репо для данных о юзере
  FirestoreUserDataRepo(this._collectionReference);

  @override
  Future<String> create(UserData userData) async {
    var userDataJson = userData.toJson();
    var doc = await _collectionReference.add(userDataJson);
    return doc.id;
  }

  @override
  Future<UserData?> getByDeviceId(String deviceId) async {
    try {
      var doc = (await _collectionReference
              .where("deviceIds", arrayContains: deviceId)
              .where("userId", isNull: true)
              .get())
          .docs
          .first;

      var userData = UserData.fromJson(doc.data()!).copyWith(id: doc.id);

      return userData;
      // ignore: avoid_catching_errors
    } on StateError {
      return null;
    }
  }

  @override
  Future<UserData?> getByUserId(String userId) async {
    try {
      var doc =
          (await _collectionReference.where("userId", isEqualTo: userId).get())
              .docs
              .first;

      var userData = UserData.fromJson(doc.data()!).copyWith(id: doc.id);

      return userData;
      // ignore: avoid_catching_errors
    } on StateError {
      return null;
    }
  }

  @override
  Future<void> update(UserData userData) =>
      _collectionReference.doc(userData.id).update(userData.toJson());
}
