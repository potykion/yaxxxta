import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/view_models.dart';
import 'package:yaxxxta/widgets/habit/habit_calendar_page_habit_progress_control.dart';

import '../routes.dart';
import '../widgets/core/app_bars.dart';
import '../widgets/core/bottom_nav.dart';
import '../widgets/core/circular_progress.dart';
import '../widgets/core/date.dart';
import '../widgets/core/padding.dart';
import '../widgets/core/text.dart';
import '../widgets/habit/date_swiper.dart';

/// Страница с календарем привычек
class HabitCalendarPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var alKey = useState(GlobalKey<AnimatedListState>());

    var listHabitVMs = useProvider(listHabitVMsProvider);

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
                alKey.value = GlobalKey<AnimatedListState>();
              }),
        ],
      ),
      body: Column(
        children: [
          DateCarousel(
            initial: context.read(selectedDateProvider).state,
            change: (date) {
              context.read(selectedDateProvider).state = date;
              context
                  .read(habitPerformingController)
                  .loadDateHabitPerformings(date);
            },
          ),
          Expanded(
            child: DateSwiper(
              (context) => listHabitVMs.maybeWhen(
                data: (vms) => vms.isNotEmpty
                    ? AnimatedList(
                        key: alKey.value,
                        initialItemCount: vms.length,
                        itemBuilder: (context, index, animation) =>
                            vms.length > index
                                ? HabitCalendarPage_HabitProgressControl(
                                    index: index,
                                    vm: vms[index],
                                    animation: animation,
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
          alKey.value = GlobalKey<AnimatedListState>();
        },
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
