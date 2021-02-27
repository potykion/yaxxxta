import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, GoogleAuthProvider, User;
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yaxxxta/user/domain/db.dart';
import 'models.dart';

/// Аутентификация через гугл
class Auth {
  /// https://firebase.flutter.dev/docs/auth/social/
  Future<User> signInByGoogle() async {
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    var googleAuth = await googleUser.authentication;

    // Create a new credential
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    var cred = await FirebaseAuth.instance.signInWithCredential(credential);

    return cred.user;
  }

  /// Выход из акка
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

class LoadUserData {
  final UserDataRepo repo;

  LoadUserData({this.repo});

  Future<UserData> call({
    @required User user,
    @required String deviceId,
  }) async {
    /// Если анон юзер => берем по девайсу
    /// Иначе по юзер айди
    var userData = user.isAnonymous
        ? await repo.getByDeviceId(deviceId)
        : await repo.getByUserId(user.uid);

    /// Если нет UserData => анон юзер в первый раз =>
    /// создаем для девайса UserData
    if (userData == null) {
      userData = UserData.blank(deviceId: deviceId);
      await repo.create(userData);
    }

    return userData;
  }
}
