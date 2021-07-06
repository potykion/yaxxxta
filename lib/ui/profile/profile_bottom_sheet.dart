import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:yaxxxta/logic/app_user_info/controllers.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:yaxxxta/ui/core/bottom_sheet.dart';
import 'package:yaxxxta/ui/core/button.dart';
import 'package:yaxxxta/ui/core/text.dart';
import 'package:yaxxxta/ui/core/user_avatar.dart';

import '../../routes.gr.dart';
import 'package:yaxxxta/logic/core/utils/list.dart';

class ProfileBottomSheet extends HookWidget {
  const ProfileBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appUserInfo = useProvider(appUserInfoControllerProvider);
    var subscriptionProduct = useProvider(subscriptionProductProvider).state;
    var archivedHabits = useProvider(archivedHabitVMsProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Headline5("Профиль"),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: UserAvatar(),
          title: Text(FirebaseAuth.instance.currentUser!.displayName!),
          subtitle: Text(
            appUserInfo.haveSubscription
                ? "Подписка активна до ${appUserInfo.subscriptionExpirationStr}"
                : "Бесплатный аккаунт",
          ),
        ),
        Column(
          children: <Widget>[
            if (!kIsWeb) ...[
              if (!appUserInfo.haveSubscription && subscriptionProduct != null)
                CoreButton(
                  text: 'Отключить рекламу',
                  onPressed: () async =>
                      InAppPurchase.instance.buyNonConsumable(
                    purchaseParam:
                        PurchaseParam(productDetails: subscriptionProduct),
                  ),
                  icon: Icons.do_not_disturb,
                ),
            ],
            if (archivedHabits.isNotEmpty)
              CoreButton(
                text: "Архив",
                icon: Icons.archive,
                onPressed: () =>
                    AutoRouter.of(context).replace(HabitArchiveRoute()),
              )
          ].joinObject(SizedBox(height: 8)).toList(),
        ),
      ],
    );
  }
}

Future<void> showProfileBottomSheet(BuildContext context) =>
    showCoreBottomSheet<void>(context, ProfileBottomSheet());
