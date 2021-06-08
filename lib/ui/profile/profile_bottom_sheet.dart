import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yaxxxta/ui/core/bottom_sheet.dart';
import 'package:yaxxxta/ui/core/text.dart';
import 'package:yaxxxta/ui/core/user_avatar.dart';

Future<void> showProfileBottomSheet(BuildContext context) {
  return showCoreBottomSheet<void>(
    context,
    Column(
      children: [
        Headline5("Профиль"),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: UserAvatar(),
          title: Text(FirebaseAuth.instance.currentUser!.displayName!),
          subtitle: Text("Бесплатный аккаунт"),
        )
      ],
    ),
    height: 140
  );
}
