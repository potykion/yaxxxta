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
                    size: AdSize.smartBanner,
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
      appBar: AppBar(
        // toolbarHeight: kToolbarHeight + 16,
        title: Text(
          "Календарь",
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.add), color: Colors.white),
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 8),
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
              mini: true,
            ),
          )
        ],
      ),
      body: vms.isEmpty
          ? Center(child: Text("Привычки не найдены"))
          : Swiper(
              viewportFraction: 0.9,
              scale: 0.9,
              controller: controller,
              itemBuilder: (context, index) {
                var vm = vms[index];

                return Consumer(
                  builder: (context, watch, child) {
                    var ad = watch(_adProvider(index));
                    return HabitInfoCard(
                      vm: vm,
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // textBaseline: TextBaseline.alphabetic,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                vm.habit.title,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.edit),
                                color: Theme.of(context).canvasColor,
                              ),
                            ],
                          ),
                          // Divider(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Text(
                                "Прогресс",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(height: 8),
                              HabitPerformingCalendar(vm: vm),
                              SizedBox(height: 8),
                              PerformHabitButton(habit: vm.habit),
                            ],
                          ),
                          SizedBox(height: 8),
                          // Divider(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              Text(
                                "Статистика",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(height: 8),
                              HabitStats(vm: vm),
                            ],
                          ),
                          SizedBox(height: 8),
                          SizedBox(height: 8),
                          Container(
                            height: 55,
                            child: ad != null ? AdWidget(ad: ad) : null,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              itemCount: vms.length,
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.today), label: "Календарь"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Список"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Настройки",
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
