import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/user/controllers.dart';
import 'package:yaxxxta/logic/user/services.dart';
import 'package:yaxxxta/logic/user/models.dart';

import '../theme.dart';
import '../widgets/core/app_bars.dart';
import '../widgets/core/bottom_nav.dart';
import '../widgets/core/card.dart';
import '../widgets/core/padding.dart';
import '../widgets/core/text.dart';
import '../widgets/core/time.dart';

/// Страница с настройками
class SettingsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var settings = useProvider(userDataControllerProvider.state)!.settings;
    var user = useProvider(userProvider).state;

    setSettings(AppSettings newSettings) {
      context.read(userDataControllerProvider).updateSettings(newSettings);
    }

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        children: [
          SmallPadding.noBottom(child: BiggestText(text: "Настроечки"))
        ],
      ),
      body: ListView(
        children: [
          ContainerCard(
            children: [
              if (!(user?.isAnonymous ?? true))
                Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user!.photoURL!),
                      ),
                      title: BiggerText(text: user.displayName!),
                      subtitle: SmallerText(text: "Синхронизация отключена"),
                      trailing: IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () async {
                          await context.read(authProvider).signOut();
                          context.read(userProvider).state = null;
                        },
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
                  onTap: () async {
                    context.read(userProvider).state =
                        await context.read(authProvider).signInByGoogle();
                  },
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
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
