import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/ui/widgets/app_bars.dart';
import '../core/ui/widgets/bottom_nav.dart';
import '../core/ui/widgets/card.dart';
import '../core/ui/widgets/padding.dart';
import '../core/ui/widgets/text.dart';
import '../core/ui/widgets/time.dart';
import '../deps.dart';
import '../theme.dart';
import '../settings/domain/models.dart';

/// Страница с настройками
class SettingsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var settings = useProvider(userDataControllerProvider.state)!.settings;

    var version = useProvider(versionProvider);

    setSettings(Settings newSettings) {
      context.read(userDataControllerProvider).updateSettings(newSettings);
    }

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        children: [BiggestText(text: "Настроечки", withPadding: true)],
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) => ListView(
          children: [
            ContainerCard(
              children: [
                if (snapshot.hasData && !snapshot.data!.isAnonymous)
                  Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(snapshot.data!.photoURL!),
                        ),
                        title: BiggerText(text: snapshot.data!.displayName!),
                        subtitle: SmallerText(text: "Синхронизация отключена"),
                        trailing: IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: () => context.read(authProvider).signOut(),
                        ),
                      ),
                      SmallPadding(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: BiggerText(text: "Включить синхронизацию"),
                            onPressed: () {},
                          ),
                        ),
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
            ContainerCard(
              children: [
                ListTile(
                  title: BiggerText(text: "Начало и конец дня"),
                  dense: true,
                ),
                SmallPadding(
                  child: Row(
                    children: [
                      Flexible(
                        child: TimePickerInput(
                          initial: settings.dayStartTime,
                          change: (time) => setSettings(
                            settings.copyWith(dayStartTime: time),
                          ),
                        ),
                      ),
                      SmallPadding.between(),
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
            ContainerCard(
              children: [
                ListTile(
                  title: BiggerText(text: 'Экран "Календарь"'),
                  dense: true,
                ),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: BiggerText(text: "Показывать выполненные привычки"),
                  value: settings.showCompleted,
                  onChanged: (showCompleted) => setSettings(
                    settings.copyWith(showCompleted: showCompleted!),
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
                      showPartiallyCompleted: showPartiallyCompleted!,
                    ),
                  ),
                  checkColor: CustomColors.almostBlack,
                ),
                SmallPadding.onlyBottom(),
              ],
            ),
            ContainerCard(
              children: [
                ListTile(
                  title: BiggerText(text: "Версия приложения: $version"),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
