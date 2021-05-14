import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaxxxta/logic/app_user_info/controllers.dart';
import 'package:yaxxxta/widgets/user_avatar.dart';

class SettingsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var swipeToNextUnperformed = useProvider(swipeToNextUnperformedProvider);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            leading: UserAvatar(),
            title: Text(FirebaseAuth.instance.currentUser!.displayName!),
            subtitle: Text("Бесплатный аккаунт"),
          ),
          SwitchListTile(
            value: swipeToNextUnperformed,
            title: Text("Свайпать до невыполненной привычки"),
            onChanged: (newSwipeToNextUnperformed) => context
                .read(appUserInfoControllerProvider.notifier)
                .insertOrUpdate(
                  swipeToNextUnperformed: newSwipeToNextUnperformed,
                ),
            activeColor: Theme.of(context).primaryColor,
          ),
          if (!kIsWeb)
            ListTile(
              title: Text("💻 Веб-Версия"),
              onTap: () => launch("https://yaxxxta.web.app/"),
            ),
        ],
      ),
    );
  }
}
