import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/core/ui/widgets/text.dart';

import '../../../core/ui/widgets/app_bars.dart';
import '../../../core/ui/widgets/bottom_nav.dart';
import '../../../core/ui/widgets/circular_progress.dart';
import '../../../core/ui/widgets/date.dart';
import '../../../routes.dart';
import '../../domain/models.dart';
import '../core/deps.dart';
import 'widgets.dart';

/// Страница с календарем привычек
class HabitCalendarPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await context.read(habitControllerProvider).load();
        await context
            .read(habitPerformingController)
            .loadDateHabitPerformings(DateTime.now());
      });
      return;
    }, []);
    var vmsAsyncValue = useProvider(listHabitVMs);

    var animatedListKey =
        useProvider(habitCalendarPage_AnimatedListState_Provider.state);

    var pageViewController = useState(PageController(initialPage: 1));

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        children: [
          Expanded(
            child: DateCarousel(
              initial: context.read(selectedDateProvider).state,
              change: (date) {
                context.read(selectedDateProvider).state = date;
                context
                    .read(habitPerformingController)
                    .loadDateHabitPerformings(date);
                // resetAnimatedList();
              },
            ),
          ),
        ],
        transparent: true,
        big: true,
      ),
      body: vmsAsyncValue.maybeWhen(
        data: (vms) => PageView.builder(
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
          itemBuilder: (BuildContext context, int index) {
            return vms.isNotEmpty
                ? AnimatedList(
                    key: animatedListKey,
                    initialItemCount: vms.length,
                    itemBuilder: (context, index, animation) =>
                        vms.length != index
                            ? HabitCalendarPage_HabitProgressControl(
                                index: index,
                                vm: vms[index],
                                animation: animation,
                              )
                            : null,
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
        ),
        orElse: () => CenteredCircularProgress(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: "HabitCalendarPage",
        child: Icon(Icons.add, size: 50),
        onPressed: () async {
          var habit =
              (await Navigator.of(context).pushNamed(Routes.form)) as Habit;
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
