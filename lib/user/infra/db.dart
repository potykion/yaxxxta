import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/db.dart';
import '../domain/models.dart';

class FirestoreUserDataRepo implements UserDataRepo {
  final CollectionReference _collectionReference;

  FirestoreUserDataRepo(this._collectionReference);

  @override
  Future<void> create(UserData userData) async =>
      await _collectionReference.add(userData.toJson());

  @override
  Future<UserData?> getByDeviceId(String deviceId) async {
    try {
      return (await _collectionReference
              .where("deviceIds", arrayContains: deviceId)
              .get())
          .docs
          .map((doc) => UserData.fromJson(doc.data()!))
          .where((ud) => ud.userId == null)
          .first;
      // ignore: avoid_catching_errors
    } on StateError {
      return null;
    }
  }

  @override
  Future<UserData?> getByUserId(String userId) async {
    try {
      return (await _collectionReference
              .where("userId", isEqualTo: userId)
              .get())
          .docs
          .map((doc) => UserData.fromJson(doc.data()!))
          .first;
      // ignore: avoid_catching_errors
    } on StateError {
      return null;
    }
  }
}
