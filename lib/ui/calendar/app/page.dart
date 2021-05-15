import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/app_user_info/controllers.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/ui/core/swipe_detector.dart';
import 'package:yaxxxta/widgets/habit_performing_card.dart';
import 'package:yaxxxta/widgets/pagination.dart';
import 'package:yaxxxta/routes.gr.dart';
import 'package:yaxxxta/widgets/calendar_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

FutureProvider<bool> _isPhysicalDeviceProvider = FutureProvider(
  (_) async => (await DeviceInfoPlugin().androidInfo).isPhysicalDevice ?? false,
);

FutureProvider<InitializationStatus?> _adsInitializedProvider = FutureProvider(
  (_) async => kIsWeb ? null : MobileAds.instance.initialize(),
);

var _adProvider = Provider(
  (ref) => ref.watch(_adsInitializedProvider).maybeWhen(
        data: (status) => status != null
            ? ref.watch(_isPhysicalDeviceProvider).maybeWhen(
                  data: (isPhysicalDevice) => BannerAd(
                    adUnitId: isPhysicalDevice
                        ? "ca-app-pub-6011780463667583/9890116434"
                        : BannerAd.testAdUnitId,
                    size: AdSize.banner,
                    request: AdRequest(),
                    listener: AdListener(),
                  )..load(),
                  orElse: () => null,
                )
            : null,
        orElse: () => null,
      ),
);

class CalendarAppPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vms = useProvider(habitVMsProvider);
    var swipeToNextUnperformed = useProvider(swipeToNextUnperformedProvider);

    var currentIndexState = useState(
      swipeToNextUnperformed ? getNextUnperformedHabitIndex(vms) : 0,
    );
    var currentIndex = currentIndexState.value;
    setCurrentIndex(int newIndex) => currentIndexState.value = newIndex;

    var vm = vms[currentIndex];

    var ad = useProvider(_adProvider);


    return Scaffold(
      appBar: buildCalendarAppBar(context, extraActions: [
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () async {
            var index =
                await AutoRouter.of(context).push(ListHabitRoute()) as int?;
            if (index != null) {
              setCurrentIndex(index);
            }
          },
        ),
      ]),
      body: vms.isEmpty
          ? Center(child: Text("Привычки не найдены"))
          : Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  child: HabitPagination(
                    vms: vms,
                    currentIndex: currentIndex,
                  ),
                ),
                SwipeDetector(
                  builder: (_) => Column(
                    children: [
                      Expanded(
                        child: HabitPerformingCard(
                          vm: vm,
                          onPerform: () {
                            if (swipeToNextUnperformed) {
                              var nextIndex = getNextUnperformedHabitIndex(
                                vms,
                                initialIndex: currentIndex,
                              );
                              if (nextIndex != -1) {
                                setCurrentIndex(nextIndex);
                              }
                            }
                          },
                          onArchive: () => setCurrentIndex(0),
                        ),
                      ),
                      Container(
                        height: 50,
                        child: ad != null
                            ? AdWidget(ad: ad)
                            : null,
                      ),
                    ],
                  ),
                  onSwipe: (swipe) {
                    if (swipeToNextUnperformed) {
                      var nextIndex = swipe == Swipe.rightToLeft
                          ? getNextUnperformedHabitIndex(
                              vms,
                              initialIndex: currentIndex,
                            )
                          : getPreviousUnperformedHabitIndex(
                              vms,
                              initialIndex: currentIndex,
                            );
                      if (nextIndex != -1) {
                        setCurrentIndex(nextIndex);
                        return;
                      }
                    }
                    setCurrentIndex(
                      (currentIndex + (swipe == Swipe.rightToLeft ? 1 : -1)) %
                          vms.length,
                    );
                  },
                ),
              ],
            ),
    );
  }
}
