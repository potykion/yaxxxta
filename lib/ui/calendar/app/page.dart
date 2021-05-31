import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/app_user_info/controllers.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/ui/calendar/app/habit_info_card.dart';
import 'package:yaxxxta/ui/calendar/app/habit_stats.dart';
import 'package:yaxxxta/ui/calendar/app/perform_habit_btn.dart';
import 'package:yaxxxta/widgets/habit_performing_calendar.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

FutureProvider<bool> _isPhysicalDeviceProvider = FutureProvider(
  (_) async => (await DeviceInfoPlugin().androidInfo).isPhysicalDevice ?? false,
);

FutureProvider<InitializationStatus?> _adsInitializedProvider = FutureProvider(
  (ref) async {
    if (kIsWeb) return null;
    if (ref.watch(appUserInfoControllerProvider).haveSubscription) return null;
    return MobileAds.instance.initialize();
  },
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

    var controller = useMemoized(
      () => SwiperController(),
    );

    return Scaffold(
      body: vms.isEmpty
          ? Center(child: Text("Привычки не найдены"))
          : Swiper(
              controller: controller,
              itemBuilder: (context, index) {
                var vm = vms[index];

                return Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: kToolbarHeight,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: SizedBox(
                                height: 100,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        vm.habit.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.edit),
                                      color: Color(0xffffffff),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  HabitInfoCard(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Прогресс",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                        SizedBox(height: 8),
                                        HabitPerformingCalendar(vm: vm),
                                        SizedBox(height: 8),
                                        PerformHabitButton(habit: vm.habit),
                                      ],
                                    ),
                                  ),
                                  HabitInfoCard(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Статистика",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                        SizedBox(height: 8),
                                        HabitStats(vm: vm),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Consumer(
                    //   builder: (context, watch, child) {
                    //     var ad = watch(_adProvider(index));
                    //     return ad != null
                    //         ? Container(height: 50, child: AdWidget(ad: ad))
                    //         : Container();
                    //   },
                    // ),
                  ],
                );
              },
              itemCount: vms.length,
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: "Календарь"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Список"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Настройки"),
        ],
      ),
    );
  }
}
