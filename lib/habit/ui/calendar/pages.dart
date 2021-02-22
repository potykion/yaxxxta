import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/all.dart';

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

    var animatedListKey = useProvider(habitAnimatedListStateProvider);

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        children: [
          Expanded(
            child: DateCarousel(
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
        data: (vms) => AnimatedList(
          key: animatedListKey.state,
          initialItemCount: vms.length,
          itemBuilder: (context, index, animation) => vms.length != index
              ? HabitCalendarPage_HabitProgressControl(
                  index: index,
                  vm: vms[index],
                  animation: animation,
                )
              : null,
        ),
        orElse: () => CenteredCircularProgress(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: vmsAsyncValue.maybeWhen(
        data: (vms) => FloatingActionButton(
          heroTag: "HabitCalendarPage",
          child: Icon(Icons.add, size: 50),
          onPressed: () async {
            var habit =
                (await Navigator.of(context).pushNamed(Routes.form)) as Habit;
            if (habit != null &&
                habit.matchDate(context.read(selectedDateProvider).state)) {
              animatedListKey.state.currentState.insertItem(
                vms.length,
                duration: Duration(milliseconds: 500),
              );
            }
          },
        ),
        orElse: () => null,
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
