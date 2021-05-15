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

var _adProvider = Provider.family(
  (ref, __) => ref.watch(_adsInitializedProvider).maybeWhen(
        data: (status) => status != null
            ? ref.watch(_isPhysicalDeviceProvider).maybeWhen(
                  data: (isPhysicalDevice) => BannerAd(
                    adUnitId: isPhysicalDevice
                        ? "ca-app-pub-6011780463667583/9890116434"
                        // ? BannerAd.testAdUnitId
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
    print(DateTime.now());

    var vms = useProvider(habitVMsProvider);
    var swipeToNextUnperformed = useProvider(swipeToNextUnperformedProvider);

    var currentIndex = useState(0);

    var controller = useMemoized(() => SwiperController());

    useEffect(() {
      var nextIndex =
          swipeToNextUnperformed ? getNextUnperformedHabitIndex(vms) : 0;
      if (nextIndex != 0 && nextIndex != -1) {
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          controller.next();
        });
      }
    }, []);

    return Scaffold(
      appBar: buildCalendarAppBar(context, extraActions: [
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () async {
            var index =
                await AutoRouter.of(context).push(ListHabitRoute()) as int?;
            if (index != null) {
              currentIndex.value = index;
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
                    currentIndex: currentIndex.value,
                  ),
                ),
                Swiper(
                  controller: controller,
                  itemBuilder: (BuildContext context, int index) {
                    print(index);
                    var vm = vms[index];

                    return Column(
                      children: [
                        Expanded(
                          child: HabitPerformingCard(
                            vm: vm,
                            onPerform: () {
                              if (swipeToNextUnperformed) {
                                var nextIndex = getNextUnperformedHabitIndex(
                                  vms,
                                  initialIndex: index,
                                );
                                if (nextIndex != -1) {
                                  currentIndex.value = nextIndex;
                                }
                              }
                            },
                            onArchive: () => currentIndex.value = 0,
                          ),
                        ),
                        Consumer(
                          builder: (context, watch, child) {
                            var ad = watch(_adProvider(index));

                            return Container(
                              height: 50,
                              child: ad != null ? AdWidget(ad: ad) : null,
                            );
                          },
                        ),
                      ],
                    );
                  },
                  itemCount: vms.length,
                  onIndexChanged: (index) {
                    if (index == currentIndex.value) return;

                    if (swipeToNextUnperformed) {
                      var oldIndex = currentIndex.value;
                      var swipe = index > oldIndex && index - oldIndex == 1 ||
                              index == 0 && oldIndex == vms.length - 1
                          ? Swipe.rightToLeft
                          : Swipe.leftToRight;

                      var nextIndex = swipe == Swipe.rightToLeft
                          ? getNextUnperformedHabitIndex(
                              vms,
                              initialIndex: index,
                              includeInitial: true,
                            )
                          : getPreviousUnperformedHabitIndex(
                              vms,
                              initialIndex: index,
                              includeInitial: true,
                            );
                      if (nextIndex != -1 && nextIndex != index) {
                        currentIndex.value = index;
                        if (swipe == Swipe.rightToLeft) {
                          controller.next();
                        } else {
                          controller.previous();
                        }
                      } else {
                        currentIndex.value = index;
                      }
                    } else {
                      currentIndex.value = index;
                    }
                  },
                ),
              ],
            ),
    );
  }
}
