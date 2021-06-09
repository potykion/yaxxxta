import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/ads/state.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/ui/core/button.dart';
import 'package:yaxxxta/ui/core/card.dart';
import 'package:yaxxxta/ui/core/text.dart';
import 'package:yaxxxta/widgets/habit_performing_calendar.dart';

import 'habit_form.dart';
import 'habit_stats.dart';

class HabitSwiper extends StatelessWidget {
  final List<HabitVM> vms;

  const HabitSwiper({
    Key? key,
    required this.vms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Swiper(
        // В релиз-моде делаем скейл карточек красивый
        // В дебаг-моде он тормозит
        viewportFraction: kReleaseMode ? 0.9 : 1,
        scale: kReleaseMode ? 0.9 : 1,
        itemBuilder: (context, index) {
          var vm = vms[index];

          return Consumer(
            builder: (context, watch, child) {
              var ad = watch(adProvider(index));
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
                                .read(habitControllerProvider.notifier)
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
      );
}
