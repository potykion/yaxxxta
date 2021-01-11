import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, GoogleAuthProvider;
import 'package:google_sign_in/google_sign_in.dart';

import 'models.dart';

class SignInWithGoogle {
  /// https://firebase.flutter.dev/docs/auth/social/
  Future<User> call() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    var googleAuth = await googleUser.authentication;

    // Create a new credential
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    var cred = await FirebaseAuth.instance.signInWithCredential(credential);

    return User.fromFireBase(cred.user);
  }
}
