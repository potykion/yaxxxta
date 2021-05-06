import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaxxxta/widgets/web_padding.dart';
import 'package:yaxxxta/widgets/user_avatar.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebPadding(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            ListTile(
              leading: UserAvatar(),
              title: Text(FirebaseAuth.instance.currentUser!.displayName!),
              subtitle: Text("Бесплатный аккаунт"),
            ),
            if (!kIsWeb)
              ListTile(
                title: Text("💻 Веб-Версия"),
                onTap: () => launch("https://yaxxxta.web.app/"),
              ),
          ],
        ),
      ),
    );
  }
}
