import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/ads/state.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/ui/core/button.dart';
import 'package:yaxxxta/ui/core/card.dart';
import 'package:yaxxxta/ui/core/chip.dart';
import 'package:yaxxxta/ui/core/text.dart';
import 'package:yaxxxta/ui/calendar/habit_performing_calendar.dart';

import '../form/habit_form.dart';
import 'habit_stats.dart';

/// Свайпер привычек
class HabitSwiper extends HookWidget {
  /// Привычки
  final List<HabitVM> vms;

  /// Свайпер привычек
  const HabitSwiper({
    Key? key,
    required this.vms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pageController = useMemoized(
      () => PageController(
        initialPage: vms.length * 10000,
        viewportFraction: 0.95,
      ),
    );
    useEffect(() => () => pageController.dispose, []);

    return PageView.builder(
      controller: pageController,
      itemBuilder: (context, index) {
        var vm = vms[index % vms.length];

        return Consumer(
          builder: (context, watch, child) {
            var ad = watch(adProvider(index));

            return CoreCard(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              color: vm.isPerformedToday ? CoreColors.lightGreen : null,
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Headline5(
                            vm.habit.title,
                            trailing: IconButton(
                              visualDensity: VisualDensity.comfortable,
                              onPressed: () async {
                                var habit = await showHabitFormBottomSheet(
                                  context,
                                  initial: vm.habit,
                                );
                                if (habit != null) {
                                  await context
                                      .read(habitCalendarStateProvider.notifier)
                                      .update(habit);
                                }
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ),
                          Wrap(
                            children: [
                              // Chip(label: Text("Ежедневная")),
                              // SizedBox(width: 4),
                              if (vm.habit.notification != null)
                                CoreChip(
                                  text: vm.habit.notification!.toTimeStr(),
                                  icon: Icons.notifications,
                                  color: vm.isPerformedToday
                                      ? CoreColors.lightGreen
                                      : CoreColors.white,
                                ),
                            ],
                          )
                        ],
                      ),
                      // SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Headline6("Статистика"),
                          HabitStats(vm: vm),
                        ],
                      ),
                      if (ad != null) ...[
                        SizedBox(height: 8),
                        Container(
                          height: AdSize.banner.height.toDouble(),
                          width: AdSize.banner.width.toDouble(),
                          child: Center(child: AdWidget(ad: ad)),
                        ),
                      ],
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Headline6("Прогресс"),
                          HabitPerformingCalendar(vm: vm),
                        ],
                      ),
                      SizedBox(height: 64),
                    ],
                  ),
                  Positioned(
                    child: CoreButton(
                      text: "Выполнить",
                      icon: Icons.done,
                      onPressed: () => context
                          .read(habitCalendarStateProvider.notifier)
                          .perform(vm.habit),
                    ),
                    // 0.95 - viewport, 16 - card padding, 4 - card margin
                    width: MediaQuery.of(context).size.width * 0.95 -
                        16 * 2 -
                        4 * 2,
                    bottom: 8,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}