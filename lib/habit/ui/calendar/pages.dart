import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/core/ui/widgets/app_bars.dart';

import '../../../core/ui/widgets/bottom_nav.dart';
import '../../../core/ui/widgets/circular_progress.dart';
import '../../../core/ui/widgets/date.dart';
import '../../../core/ui/widgets/time.dart';
import '../../../core/utils/dt.dart';
import '../../../routes.dart';
import '../../../settings/ui/core/deps.dart';
import '../../domain/models.dart';
import '../core/deps.dart';
import '../core/view_models.dart';
import '../core/widgets.dart';

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
    resetAnimatedList() {
      animatedListKey.state = GlobalKey<AnimatedListState>();
    }

    Widget _buildHabitRepeatControl(BuildContext context, int index,
        HabitProgressVM vm, Animation<double> animation,
        {bool removed = false}) {
      return FadeTransition(
        opacity: animation,
        child: GestureDetector(
          onTap: removed
              ? null
              : () async {
            context.read(selectedHabitIdProvider).state = vm.id;
            var deleted = await Navigator.of(context)
                .pushNamed(Routes.details) as bool ??
                false;
            if (deleted) {
              animatedListKey.state.currentState.removeItem(
                index,
                    (context, animation) => _buildHabitRepeatControl(
                    context, index, vm, animation,
                    removed: true),
                duration: Duration(milliseconds: 500),
              );
            }
          },
          child: HabitProgressControl(
            key: Key(vm.id),
            repeatTitle: vm.performTime != null
                ? "${vm.performTimeStr}: ${vm.title}"
                : vm.title,
            vm: vm,
            onRepeatIncrement: removed
                ? null
                : (incrementValue, progressStatus, [date]) async {
              context
                  .read(habitPerformingController)
                  .insert(HabitPerforming(
                habitId: vm.id,
                performValue: incrementValue,
                performDateTime:
                await _computePerformDateTime(context, date),
              ));

              var settings = context.read(settingsProvider).state;
              var hideHabit = !settings.showCompleted &&
                  (progressStatus == HabitProgressStatus.complete ||
                      progressStatus == HabitProgressStatus.exceed) ||
                  !settings.showCompleted &&
                      (progressStatus == HabitProgressStatus.partial);

              if (hideHabit) {
                animatedListKey.state.currentState.removeItem(
                  index,
                      (context, animation) => _buildHabitRepeatControl(
                      context, index, vm, animation,
                      removed: true),
                  duration: Duration(milliseconds: 500),
                );
              }
            },
            initialDate: context.read(selectedDateProvider).state,
          ),
        ),
      );
    }

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
                  resetAnimatedList();
                },
              ),
            ),
          ],
        transparent: true,
        big: true
      ),
      body: vmsAsyncValue.maybeWhen(
        data: (vms) => AnimatedList(
          key: animatedListKey.state,
          initialItemCount: vms.length,
          itemBuilder: (context, index, animation) => vms.length != index
              ? _buildHabitRepeatControl(context, index, vms[index], animation)
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


  Future<DateTime> _computePerformDateTime(
      BuildContext context, DateTime initialDate) async {
    var performDate = initialDate ?? context.read(selectedDateProvider).state;

    /// Если выбранная дата не сегодня,
    /// то выбираем в какое время хотим добавить
    /// выполнение привычки за другую дату
    var performTime = DateTime.now();
    if (!performDate.isToday()) {
      performTime = (await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(performTime),
          ))
              ?.toDateTime() ??
          performTime;
    }

    return buildDateTime(performDate, performTime);
  }
}
