import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/app_user_info/controllers.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/ui/calendar/app/calendar_appbar.dart';
import 'package:yaxxxta/ui/calendar/app/habit_swiper.dart';
import 'package:yaxxxta/widgets/habit_performing_card.dart';
import 'package:yaxxxta/widgets/pagination.dart';
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
    List<HabitVM> vms = useProvider(habitVMsProvider);
    var swipeToNextUnperformed = useProvider(swipeToNextUnperformedProvider);

    var controller = useMemoized(
      () => HabitSwiperController(
        habits: vms,
        swipeToNextUnperformed: swipeToNextUnperformed,
      ),
    );

    return Scaffold(
      appBar: CalendarAppBar(onHabitSelect: controller.swipeTo),
      body: vms.isEmpty
          ? Center(child: Text("Привычки не найдены"))
          : HabitSwiper(
              controller: controller,
              builder: (context, index) {
                print(index);
                return Column(
                children: [
                  Expanded(
                    child: HabitPerformingCard(
                      vm: vms[index],
                      onPerform: () =>
                          controller.swipeTo(index, toUnperformed: true),
                      onArchive: () =>
                          controller.swipeTo(0, toUnperformed: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: HabitPagination(vms: vms, currentIndex: index),
                  ),
                  Consumer(
                    builder: (context, watch, child) {
                      var ad = watch(_adProvider(index));
                      return ad != null
                          ? Container(height: 50, child: AdWidget(ad: ad))
                          : Container();
                    },
                  ),
                ],
              );
              },
            ),
    );
  }
}