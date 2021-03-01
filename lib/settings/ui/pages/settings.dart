import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../core/ui/widgets/app_bars.dart';
import '../../../core/ui/widgets/bottom_nav.dart';
import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/padding.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../core/ui/widgets/time.dart';
import '../../../deps.dart';
import '../../../theme.dart';
import '../../domain/models.dart';

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

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        children: [BiggestText(text: "Настроечки", withPadding: true)],
      ),
      body: StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) => ListView(
          children: [
            PaddedContainerCard(
              padVerticalOnly: true,
              children: [
                if (snapshot.hasData)
                  Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data.photoURL),
                        ),
                        title: BiggerText(text: snapshot.data.displayName),
                        subtitle: SmallerText(text: "Синхронизация отключена"),
                        trailing: IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: () => context.read(authProvider).signOut(),
                        ),
                      ),
                      ElevatedButton(
                        child: BiggerText(text: "Включить синхронизацию"),
                        onPressed: () {},
                      )
                    ],
                  )
                else
                  ListTile(
                    title: BiggerText(text: "Войти"),
                    onTap: () => context.read(authProvider).signInByGoogle(),
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
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: BiggerText(
                      text: "Показывать частично выполненные привычки"),
                  value: settings.showPartiallyCompleted,
                  onChanged: (showPartiallyCompleted) => setSettings(
                    settings.copyWith(
                      showPartiallyCompleted: showPartiallyCompleted,
                    ),
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
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
