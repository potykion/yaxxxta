import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yaxxxta/widgets/web_padding.dart';

import '../routes.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebPadding(
      child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Надо бы войти"),
                ElevatedButton.icon(
                  label: Text("Войти"),
                  icon: Image.asset('assets/g.png'),
                  onPressed: () async {
                    await signInByGoogle();
                    Navigator.pushReplacementNamed(context, Routes.loading);
                  },
                ),
              ],
            ),
          )),
    );
  }

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
}
