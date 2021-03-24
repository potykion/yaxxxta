import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaxxxta/logic/user/controllers.dart';
import 'package:yaxxxta/logic/user/models.dart';

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
          // todo актуально когда будет синхронизация и iap
          //  https://github.com/potykion/yaxxxta/issues/32
          //  https://github.com/potykion/yaxxxta/issues/1
          // var user = useProvider(userProvider).state;
          // ...
          // ContainerCard(
          //   children: [
          //     if (!(user?.isAnonymous ?? true))
          //       Column(
          //         children: [
          //           ListTile(
          //             leading: CircleAvatar(
          //               backgroundImage: NetworkImage(user!.photoURL!),
          //             ),
          //             title: BiggerText(text: user.displayName!),
          //             subtitle: SmallerText(text: "Синхронизация отключена"),
          //             trailing: IconButton(
          //               icon: Icon(Icons.logout),
          //               onPressed: () async {
          //                 await context.read(authProvider).signOut();
          //                 context.read(userProvider).state = null;
          //               },
          //             ),
          //           ),
          //           SmallPadding(
          //             child: SizedBox(
          //               width: double.infinity,
          //               child: ElevatedButton(
          //                 child: BiggerText(text: "Включить синхронизацию"),
          //                 onPressed: () {},
          //               ),
          //             ),
          //           )
          //         ],
          //       )
          //     else
          //       ListTile(
          //         title: BiggerText(text: "Войти"),
          //         onTap: () async {
          //           context.read(userProvider).state =
          //               await context.read(authProvider).signInByGoogle();
          //         },
          //         trailing: Icon(Icons.login),
          //       )
          //   ],
          // ),
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
          ContainerCard(children: [
            ListTile(
              title: BiggerText(text: "💰 Поддержать разработчика"),
              dense: true,
              onTap: () => launch("https://www.tinkoff.ru/sl/5FH61pHbRKS"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ])
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
