import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yaxxxta/logic/app_user_info/controllers.dart';
import 'package:yaxxxta/widgets/user_avatar.dart';

class SettingsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var appUserInfo = useProvider(appUserInfoControllerProvider);
    var subscriptionProduct = useProvider(subscriptionProductProvider).state;
    useEffect(() {
      late StreamSubscription<List<PurchaseDetails>> _subscription;
      _subscription = InAppPurchase.instance.purchaseStream.listen(
        (purchaseDetailsList) async {
          for (var purchase in purchaseDetailsList) {
            if (purchase.status == PurchaseStatus.error) {
            } else if (purchase.status == PurchaseStatus.purchased ||
                purchase.status == PurchaseStatus.restored) {
              if (purchase.pendingCompletePurchase) {
                await InAppPurchase.instance.completePurchase(purchase);
              }

              if (purchase.productID == "sub") {
                var purchaseDate = DateTime.fromMillisecondsSinceEpoch(
                  int.parse(purchase.transactionDate!),
                );
                var subscriptionExpiration = DateTime(
                  purchaseDate.year,
                  purchaseDate.month + 1,
                  purchaseDate.day,
                );
                await context
                    .read(appUserInfoControllerProvider.notifier)
                    .insertOrUpdate(
                      subscriptionExpiration: subscriptionExpiration,
                    );
              }
            }
          }
        },
        onDone: () => _subscription.cancel(),
        onError: (dynamic error) {},
      );

      if (!appUserInfo.haveSubscription) {
        InAppPurchase.instance.restorePurchases();
      }

      return _subscription.cancel;
    }, []);

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            leading: UserAvatar(),
            title: Text(FirebaseAuth.instance.currentUser!.displayName!),
            subtitle: Text(
              appUserInfo.haveSubscription
                  ? "Подписка активна до ${appUserInfo.subscriptionExpirationStr}"
                  : "Бесплатный аккаунт",
            ),
          ),
          if (!kIsWeb) ...[
            if (!appUserInfo.haveSubscription)
              if (subscriptionProduct != null)
                ListTile(
                  title: Text("🚫 Отключить рекламу"),
                  onTap: () async {
                    var purchaseParam =
                        PurchaseParam(productDetails: subscriptionProduct);
                    InAppPurchase.instance
                        .buyNonConsumable(purchaseParam: purchaseParam);
                  },
                ),
            ListTile(
              title: Text("💻 Веб-Версия"),
              onTap: () => launch("https://yaxxxta.web.app/"),
            ),
          ],
        ],
      ),
    );
  }
}
