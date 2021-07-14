import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:yaxxxta/logic/app_user_info/controllers.dart';

/// Хук, который чекает куплена ли подписка
/// Если куплена, то обновляем инфу о юзере
void useSubscription(BuildContext context) {
  var appUserInfo = useProvider(appUserInfoControllerProvider);

  useEffect(() {
    if (kIsWeb) return () {};

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
}
