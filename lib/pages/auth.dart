import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/user/services.dart';
import 'package:yaxxxta/widgets/core/buttons.dart';
import 'package:yaxxxta/widgets/core/padding.dart';
import 'package:yaxxxta/widgets/core/text.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../routes.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmallPadding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BiggerText(text: "Нужно тебя идентифицировать"),
            SmallPadding.onlyBottom(),
            FullWidthButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.perm_identity),
                  SmallPadding.between(),
                  BiggerText(text: "Войти"),
                ],
              ),
              onPressed: () async {
                await context.read(authProvider).signInByGoogle();
                Navigator.pushReplacementNamed(context, Routes.loading);
              },
            )
          ],
        ),
      ),
    );
  }
}
