import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/auth/models.dart';
import '../../../core/ui/deps.dart';

import '../../../core/ui/widgets/bottom_nav.dart';
import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/padding.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../core/ui/widgets/time.dart';
import '../../../theme.dart';
import '../../domain/models.dart';
import '../core/deps.dart';

/// Страница с настройками
class SettingsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var settingsState = useProvider(settingsProvider);
    var settings = settingsState.state;

    var version = useProvider(versionProvider);

    setSettings(Settings newSettings) {
      context.read(settingsProvider).state = newSettings;
      context.read(settingsRepoProvider).update(newSettings);
    }

    return StreamBuilder<User>(
      stream: FirebaseAuth.instance
          .authStateChanges()
          .map((user) => user != null ? User.fromFireBase(user) : null),
      builder: (context, snapshot) => Scaffold(
        body: ListView(
          children: [
            PaddedContainerCard(
              padVerticalOnly: true,
              children: [
                if (snapshot.hasData)
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data.photoURL),
                    ),
                    title: BiggerText(text: snapshot.data.displayName),
                  )
                else
                  ListTile(
                    title: BiggerText(text: "Войти"),
                    onTap: () async {
                      var user = await context.read(signInWithGoogleProvider)();
                    },
                    trailing: Icon(Icons.login),
                  )
              ],
            ),
            PaddedContainerCard(
              padVerticalOnly: true,
              children: [
                SmallPadding(
                  child: BiggerText(text: "Начало и конец дня"),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Flexible(
                        child: TimePickerInput(
                          initial: settings.dayStartTime,
                          change: (time) => setSettings(
                            settings.copyWith(dayStartTime: time),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: TimePickerInput(
                          initial: settings.dayEndTime,
                          change: (time) => setSettings(
                            settings.copyWith(dayEndTime: time),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            PaddedContainerCard(
              padVerticalOnly: true,
              children: [
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: BiggerText(text: "Показывать выполненные привычки"),
                  value: settings.showCompleted,
                  onChanged: (showCompleted) => setSettings(
                    settings.copyWith(showCompleted: showCompleted),
                  ),
                  checkColor: CustomColors.almostBlack,
                ),
              ],
            ),
            PaddedContainerCard(
              padVerticalOnly: true,
              children: [
                ListTile(
                    title: BiggerText(text: "Версия приложения: $version")),
              ],
            )
          ],
        ),
        bottomNavigationBar: AppBottomNavigationBar(),
      ),
    );
  }
}
