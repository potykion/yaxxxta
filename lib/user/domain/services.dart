import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, GoogleAuthProvider, User;
import 'package:google_sign_in/google_sign_in.dart';
import 'db.dart';
import 'models.dart';

/// Класс для работы с аутентификацией
class Auth {
  /// Аутентификация через гугл
  /// https://firebase.flutter.dev/docs/auth/social#google
  Future<User> signInByGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    var googleAuth = await googleUser!.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    var fbCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return fbCredential.user!;
  }

  /// Анонимная аутентификация
  /// https://firebase.flutter.dev/docs/auth/usage#anonymous-sign-in
  Future<User> signInAnon() async {
    var fbCredential = await FirebaseAuth.instance.signInAnonymously();
    return fbCredential.user!;
  }

  /// Пробует получить текущего юзера
  User? tryGetUser() => FirebaseAuth.instance.currentUser;

  /// Выход из акка
  /// https://firebase.flutter.dev/docs/auth/usage#signing-out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

class LoadUserData {
  final UserDataRepo repo;

  LoadUserData(this.repo);

  Future<UserData> call({
    required User user,
    required String deviceId,
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
