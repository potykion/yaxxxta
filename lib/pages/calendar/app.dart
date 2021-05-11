import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
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

ProviderFamily<BannerAd?, int> _adProvider = Provider.family(
  (ref, __) => ref.watch(_adsInitializedProvider).maybeWhen(
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

    var currentIndex = useState(0);
    var controller = useState(SwiperController());
    // При открытии аппа скроллим на первую невыполненную привычку
    useEffect(
      () {
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          var nextIndex = getNextUnperformedHabitIndex(
            vms,
            initialIndex: 0,
            includeInitial: true,
          );
          if (nextIndex != -1) {
            currentIndex.value = nextIndex;
            controller.value.move(nextIndex);
          }
        });
      },
      [],
    );

    return Scaffold(
      appBar: buildCalendarAppBar(context, extraActions: [
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () async {
            var index =
                await AutoRouter.of(context).push(ListHabitRoute()) as int?;
            if (index != null) {
              currentIndex.value = index;
              controller.value.move(index);
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
                  controller: controller.value,
                  onIndexChanged: (newIndex) {
                    if (vms[newIndex].isPerformedToday &&
                        vms.any((vm) => !vm.isPerformedToday)) {
                      var isSwipeLeft = (currentIndex.value == vms.length - 1 &&
                              newIndex == 0) ||
                          (currentIndex.value < newIndex);

                      if (isSwipeLeft) {
                        controller.value.next();
                      } else {
                        controller.value.previous();
                      }
                    } else {
                      currentIndex.value = newIndex;
                    }
                  },
                  key: ValueKey(vms.length),
                  itemCount: vms.length,
                  itemBuilder: (context, index) {
                    var vm = vms[index];

                    return Column(
                      children: [
                        Expanded(
                          child: HabitPerformingCard(
                            vm: vm,
                            onPerform: () {
                              var nextIndex = getNextUnperformedHabitIndex(
                                vms,
                                initialIndex: index,
                              );
                              if (nextIndex != -1) {
                                currentIndex.value = nextIndex;
                                controller.value.move(nextIndex);
                              }
                            },
                            onArchive: () {
                              currentIndex.value = 0;
                              controller.value.move(0);
                            },
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
                )
              ],
            ),
    );
  }
}
