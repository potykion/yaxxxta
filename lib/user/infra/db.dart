import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaxxxta/user/domain/db.dart';
import 'package:yaxxxta/user/domain/models.dart';

class FirestoreUserDataRepo implements UserDataRepo {
  final CollectionReference _collectionReference;

  FirestoreUserDataRepo(this._collectionReference);

  @override
  Future<void> create(UserData userData) async =>
      await _collectionReference.add(userData.toJson());

  @override
  Future<UserData> getByDeviceId(String deviceId) async {
    try {
      (await _collectionReference
              .where("deviceId", arrayContains: deviceId)
              .where("userId", isNull: true)
              .get())
          .docs
          .map((doc) => UserData.fromJson(doc.data()))
          .first;
    } on Exception {
      return null;
    }
  }

  @override
  Future<UserData> getByUserId(String userId) async {
    try {
      (await _collectionReference.where("userId", isEqualTo: userId).get())
          .docs
          .map((doc) => UserData.fromJson(doc.data()))
          .first;
    } on Exception {
      return null;
    }
  }
}
