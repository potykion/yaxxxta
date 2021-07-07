import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/app_user_info/controllers.dart';


FutureProvider<InitializationStatus?> _adsInitializedProvider = FutureProvider(
  (ref) async {
    if (kIsWeb) return null;
    if (ref.watch(appUserInfoControllerProvider).haveSubscription) return null;
    return MobileAds.instance.initialize();
  },
);

var adProvider = Provider.family(
  (ref, __) => ref.watch(_adsInitializedProvider).maybeWhen(
        data: (status) => status != null
            ? (BannerAd(
                adUnitId: kReleaseMode
                    ? "ca-app-pub-6011780463667583/9890116434"
                    : BannerAd.testAdUnitId,
                size: AdSize.banner,
                request: AdRequest(),
                listener: AdListener(),
              )..load())
            : null,
        orElse: () => null,
      ),
);
