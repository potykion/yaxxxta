import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, GoogleAuthProvider, User;
import 'package:google_sign_in/google_sign_in.dart';

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
