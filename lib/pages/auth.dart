import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yaxxxta/widgets/web_padding.dart';
import 'package:yaxxxta/routes.gr.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebPadding(
      child: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Надо бы войти"),
            SizedBox(height: 10),
            SignInButton(
              Buttons.Google,
              onPressed: () async {
                await signInByGoogle();
                AutoRouter.of(context).replace(LoadingRoute());
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
