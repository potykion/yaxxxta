import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/view_models.dart';
import 'package:yaxxxta/widgets/habit/habit_calendar_page_habit_progress_control.dart';
import 'package:yaxxxta/widgets/core/swiper.dart';

import '../routes.dart';
import '../widgets/core/app_bars.dart';
import '../widgets/core/bottom_nav.dart';
import '../widgets/core/circular_progress.dart';
import '../widgets/core/date.dart';
import '../widgets/core/padding.dart';
import '../widgets/core/text.dart';

/// Страница с календарем привычек
class HabitCalendarPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var listHabitVMs = useProvider(listHabitVMsProvider);
    var selectedDate = useProvider(selectedDateProvider).state;

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        children: [
          SmallPadding.noBottom(child: BiggestText(text: "Календарь")),
          Spacer(),
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () async {
                await Navigator.of(context).pushNamed(Routes.list);
              }),
        ],
      ),
      body: Column(
        children: [
          SmallPadding.onlyBottom(
            child: DateCarousel(
              initial: selectedDate,
              change: (date) {
                context.read(selectedDateProvider).state = date;
                context
                    .read(habitPerformingController)
                    .loadDateHabitPerformings(date);
              },
            ),
          ),
          Expanded(
            child: Swiper(
              onSwipe: (isSwipeLeft) {
                var newDate = context
                    .read(selectedDateProvider)
                    .state
                    .add(Duration(days: isSwipeLeft ? 1 : -1));
                context.read(selectedDateProvider).state = newDate;
                context
                    .read(habitPerformingController)
                    .loadDateHabitPerformings(newDate);
              },
              builder: (context) => listHabitVMs.maybeWhen(
                data: (vms) => vms.isNotEmpty
                    ? ListView.builder(
                        itemCount: vms.length,
                        itemBuilder: (context, index) => vms.length > index
                            ? HabitCalendarPage_HabitProgressControl(
                                index: index,
                                vm: vms[index],
                              )
                            : Container(),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BiggerText(text: "Все привычки выполнены!"),
                            SmallerText(text: "Или нечего выполнять"),
                          ],
                        ),
                      ),
                orElse: () => CenteredCircularProgress(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: "HabitCalendarPage",
        child: Icon(Icons.add, size: 50),
        onPressed: () async {
          await Navigator.of(context).pushNamed(Routes.form);
        },
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
