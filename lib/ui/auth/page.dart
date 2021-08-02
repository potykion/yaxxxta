import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yaxxxta/routes.gr.dart';
import 'package:yaxxxta/ui/core/button.dart';

/// Страничка авторизации
class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Надо бы войти",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            CoreButton(
              onPressed: () async {
                await signInByGoogle();
                AutoRouter.of(context).replace(LoadingRoute());
              },
              text: 'Войти через Гугл',
              icon: Icons.login,
            ),
            SizedBox(height: 10),
            Text(
              "Войти надо, чтобы связать привычки с тобой, а не показывать тебе чужие",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
      ),
    ),
        ));
  }

  /// Вход через гугл
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
