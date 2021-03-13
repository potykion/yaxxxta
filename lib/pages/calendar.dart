import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../deps.dart';
import '../habit/domain/models.dart';
import '../habit/ui/calendar/widgets.dart';
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
    var vmsAsyncValue = useProvider(listHabitVMs);

    var animatedListKey =
        useProvider(habitCalendarPage_AnimatedListState_Provider.state);

    var pageViewController = useState(PageController(initialPage: 1));

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        children: [
          SmallPadding.noBottom(child: BiggestText(text: "Календарь")),
          Spacer(),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () => Navigator.pushNamed(context, Routes.list),
          ),
        ],
      ),
      body: vmsAsyncValue.maybeWhen(
        data: (vms) => Column(
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
                child: PageView.builder(
              itemCount: 3,
              controller: pageViewController.value,
              onPageChanged: (index) {
                var newDate = context
                    .read(selectedDateProvider)
                    .state
                    .add(Duration(days: index > 1 ? 1 : -1));
                context.read(selectedDateProvider).state = newDate;
                context
                    .read(habitPerformingController)
                    .loadDateHabitPerformings(newDate);
              },
              itemBuilder: (context, index) {
                return vms.isNotEmpty
                    ? AnimatedList(
                        key: animatedListKey,
                        initialItemCount: vms.length,
                        itemBuilder: (context, index, animation) =>
                            (vms.length != index
                                ? HabitCalendarPage_HabitProgressControl(
                                    index: index,
                                    vm: vms[index],
                                    animation: animation,
                                  )
                                : Container()),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BiggerText(text: "Все привычки выполнены!"),
                            SmallerText(text: "Или нечего выполнять"),
                          ],
                        ),
                      );
              },
            )),
          ],
        ),
        orElse: () => CenteredCircularProgress(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: "HabitCalendarPage",
        child: Icon(Icons.add, size: 50),
        onPressed: () async {
          var habit =
              (await Navigator.of(context).pushNamed(Routes.form)) as Habit?;
          if (habit != null &&
              habit.matchDate(context.read(selectedDateProvider).state)) {
            vmsAsyncValue.maybeWhen(
              data: (vms) => context
                  .read(habitCalendarPage_AnimatedListState_Provider)
                  .insertItem(vms.length),
              orElse: () => null,
            );
          }
        },
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
