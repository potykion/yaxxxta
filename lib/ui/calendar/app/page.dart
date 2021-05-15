import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/app_user_info/controllers.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/ui/calendar/page.dart';
import 'package:yaxxxta/ui/core/swipe_detector.dart';
import 'package:yaxxxta/widgets/habit_performing_card.dart';
import 'package:yaxxxta/widgets/pagination.dart';
import 'package:yaxxxta/routes.gr.dart';
import 'package:yaxxxta/widgets/calendar_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yaxxxta/widgets/user_avatar.dart';

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
                        // ? "ca-app-pub-6011780463667583/9890116434"
                        ? BannerAd.testAdUnitId
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
  final int? initialIndex;

  CalendarAppPage({this.initialIndex});

  @override
  Widget build(BuildContext context) {
    var vms = useProvider(habitVMsProvider);
    var swipeToNextUnperformed = useProvider(swipeToNextUnperformedProvider);

    computeIndexToSwipe() {
      var indexToSwipe = initialIndex ?? 0;
      if (indexToSwipe == 0 && swipeToNextUnperformed) {
        indexToSwipe = getNextUnperformedHabitIndex(vms);
      }
      indexToSwipe = indexToSwipe == -1 ? 0 : indexToSwipe;
      print("computeIndexToSwipe: indexToSwipe = $indexToSwipe");
      return indexToSwipe;
    }

    var indexToSwipe = useMemoized(computeIndexToSwipe);
    var controller = useMemoized(
      () {
        var initialPage = 1000 * vms.length + indexToSwipe;
        print("initialPage = $initialPage");
        return PageController(
          initialPage: initialPage,
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () => AutoRouter.of(context).push(SettingsRoute()),
            child: UserAvatar(),
          ),
        ),
        title: IconButton(
          icon: Icon(Icons.list),
          onPressed: () async {
            var index =
                await AutoRouter.of(context).push(ListHabitRoute()) as int?;

            if (index != null) {
              await AutoRouter.of(context)
                  .replace(CalendarRoute(initialIndex: index));
            }
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => AutoRouter.of(context).push(HabitFormRoute()),
          ),
        ].reversed.toList(),
        // titleSpacing: 0,
      ),
      body: vms.isEmpty
          ? Center(child: Text("Привычки не найдены"))
          : PageView.builder(
              controller: controller,
              itemBuilder: (BuildContext context, int index) {
                print("index = $index");
                index %= vms.length;
                print("index = $index");

                var vm = vms[index];

                return Stack(alignment: Alignment.center, children: [
                  Column(
                    children: [
                      Expanded(
                        child: HabitPerformingCard(
                          vm: vm,
                          onPerform: () async {
                            if (swipeToNextUnperformed) {
                              var nextIndex = getNextUnperformedHabitIndex(
                                vms,
                                initialIndex: index,
                              );
                              if (nextIndex != -1) {
                                await AutoRouter.of(context).replace(
                                    CalendarRoute(initialIndex: nextIndex));
                              }
                            }
                          },
                          onArchive: () async => await AutoRouter.of(context)
                              .replace(CalendarRoute(initialIndex: 0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: HabitPagination(
                          vms: vms,
                          currentIndex: index,
                        ),
                      ),
                      Consumer(
                        builder: (context, watch, child) {
                          var ad = watch(_adProvider(index));

                          return Container(
                            height: ad != null ? 50 : 0,
                            child: ad != null ? AdWidget(ad: ad) : null,
                          );
                        },
                      ),
                    ],
                  )
                ]);
              },
              // itemCount: vms.length,
              onPageChanged: (index) async {
                index %= vms.length;
                if (!swipeToNextUnperformed) return;
                var swipe = createSwipe(indexToSwipe, index, vms.length);
                var nextIndex = swipe == Swipe.rightToLeft
                    ? getNextUnperformedHabitIndex(vms,
                        initialIndex: index, includeInitial: true)
                    : getPreviousUnperformedHabitIndex(vms,
                        initialIndex: index, includeInitial: true);
                if (nextIndex == -1) return;
                await AutoRouter.of(context)
                    .replace(CalendarRoute(initialIndex: nextIndex));
              },
            ),
    );
  }
}
