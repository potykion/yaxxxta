import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vibration/vibration.dart';
import 'package:yaxxxta/logic/app_user_info/controllers.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/ui/calendar/core/habit_list_tile.dart';
import 'package:yaxxxta/ui/core/card.dart';
import 'package:yaxxxta/ui/calendar/app/habit_stats.dart';
import 'package:yaxxxta/ui/core/text.dart';
import 'package:yaxxxta/widgets/habit_performing_calendar.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'bottom_nav.dart';
import '../../core/button.dart';
import 'habit_form.dart';

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
    var showList = useState(false);

    var controller = useMemoized(() => SwiperController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: kToolbarHeight + 24,
        title: Headline4(showList.value ? "Список" : "Календарь"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 8),
            child: IconButton(
              onPressed: () {
                showList.value = !showList.value;
              },
              icon: Icon(showList.value ? Icons.today : Icons.list),
            ),
          ),
        ],
      ),
      body: vms.isEmpty
          ? Center(child: Text("Привычки не найдены"))
          : showList.value
              ? ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  itemBuilder: (context, index) {
                    var vm = vms[index];

                    return HabitListTile(
                      vm: vm,
                      index: index,
                      onTap: () {
                        // todo show habit on index
                        Navigator.of(context).pop(index);
                      },
                      onLongPress: () async {
                        await context
                            .read(habitControllerProvider.notifier)
                            .perform(vm.habit);
                        if (await Vibration.hasVibrator() ?? false) {
                          Vibration.vibrate(duration: 100);
                        }
                      },
                    );
                  },
                  itemCount: vms.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                )
              : Swiper(
                  // В релиз-моде делаем скейл карточек красивый
                  // В дебаг-моде он тормозит
                  // viewportFraction: kReleaseMode ? 0.9 : 1,
                  // scale: kReleaseMode ? 0.9 : 1,
                  viewportFraction: 0.9,
                  scale: 0.9,
                  controller: controller,
                  itemBuilder: (context, index) {
                    var vm = vms[index];

                    return Consumer(
                      builder: (context, watch, child) {
                        var ad = watch(_adProvider(index));
                        return CoreCard(
                          color: vm.isPerformedToday ? Color(0xfff1fafa) : null,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Headline5(
                                vm.habit.title,
                                trailing: IconButton(
                                  onPressed: () async {
                                    var habit = await showHabitFormBottomSheet(
                                      context,
                                      initial: vm.habit,
                                    );
                                    if (habit != null) {
                                      await context
                                          .read(
                                              habitControllerProvider.notifier)
                                          .update(habit);
                                    }
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Headline6("Прогресс"),
                                  HabitPerformingCalendar(vm: vm),
                                  CoreButton(
                                    text: "Выполнить",
                                    icon: Icons.done,
                                    onPressed: () => context
                                        .read(habitControllerProvider.notifier)
                                        .perform(vm.habit),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Headline6("Статистика"),
                                  HabitStats(vm: vm),
                                ],
                              ),
                              Container(
                                height: AdSize.banner.height.toDouble(),
                                width: AdSize.banner.width.toDouble(),
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
      bottomNavigationBar: MyBottomNav(),
    );
  }
}
