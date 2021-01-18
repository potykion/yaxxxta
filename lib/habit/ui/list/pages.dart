import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/settings/ui/core/deps.dart';

import '../../../core/ui/widgets/bottom_nav.dart';
import '../../../core/ui/widgets/circular_progress.dart';
import '../../../core/ui/widgets/date.dart';
import '../../../core/ui/widgets/time.dart';
import '../../../core/utils/dt.dart';
import '../../../routes.dart';
import '../core/deps.dart';
import '../core/view_models.dart';
import '../core/widgets.dart';

/// Страница списка привычек
class HabitListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await context.read(habitControllerProvider).list();
        context.read(habitPerformingController).load(DateTime.now());
      });
      return;
    }, []);
    var vms = useProvider(listHabitVMs);
    var loading = useProvider(loadingState).state;

    var animatedListKey = useState(GlobalKey<AnimatedListState>());
    resetAnimatedList() {
      animatedListKey.value = GlobalKey<AnimatedListState>();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: kToolbarHeight),
            DatePicker(
              change: (date) {
                context.read(selectedDateProvider).state = date;
                context.read(habitPerformingController).load(date);
                resetAnimatedList();
              },
            ),
          ],
        ),
      ),
      body: loading
          ? CenteredCircularProgress()
          : AnimatedList(
              key: animatedListKey.value,
              initialItemCount: vms.length,
              itemBuilder: (context, index, animation) =>
                  _buildHabitRepeatControl(
                      context, index, vms[index], animation),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 50),
        onPressed: () async {
          var created =
              await Navigator.of(context).pushNamed(Routes.form) as bool ??
                  false;
          if (created) {
            animatedListKey.value.currentState.insertItem(
              vms.length,
              duration: Duration(milliseconds: 500),
            );
          }
        },
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
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
                context.read(selectedHabitId).state = vm.id;
                var deleted = await Navigator.of(context)
                        .pushNamed(Routes.details) as bool ??
                    false;
                if (deleted) {
                  AnimatedList.of(context).removeItem(
                    index,
                    (context, animation) => _buildHabitRepeatControl(
                        context, index, vm, animation,
                        removed: true),
                    duration: Duration(milliseconds: 500),
                  );
                }
              },
        child: HabitRepeatControl(
          key: Key(vm.id),
          repeatTitle: vm.firstRepeat.performTime != null
              ? "${vm.firstRepeat.performTimeStr}: ${vm.title}"
              : vm.title,
          repeats: vm.repeats,
          initialRepeatIndex: vm.firstIncompleteRepeatIndex,
          onRepeatIncrement: removed
              ? null
              : (repeatIndex, incrementValue, isCompleteOrExceeded,
                  [date]) async {
                  context.read(habitPerformingController).create(
                        habitId: vm.id,
                        repeatIndex: repeatIndex,
                        performValue: incrementValue,
                        performDateTime:
                            await _computePerformDateTime(context, date),
                      );

                  if (isCompleteOrExceeded &&
                      !context.read(settingsProvider).state.showCompleted) {
                    AnimatedList.of(context).removeItem(
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
