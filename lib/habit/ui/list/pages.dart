import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/all.dart';

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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read(habitPerformingController).load(DateTime.now());
      });
      return;
    }, []);
    var vms = useProvider(listHabitVMs);
    var loading = useProvider(loadingState).state;

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
              },
            ),
          ],
        ),
      ),
      body: loading
          ? CenteredCircularProgress()
          : ListView(
              children: [
                for (HabitProgressVM vm in vms)
                  GestureDetector(
                    onTap: () {
                      context.read(selectedHabitId).state = vm.id;
                      return Navigator.of(context).pushNamed(Routes.details);
                    },
                    child: HabitRepeatControl(
                      key: Key(vm.id),
                      repeatTitle: vm.firstRepeat.performTime != null
                          ? "${vm.firstRepeat.performTimeStr}: ${vm.title}"
                          : vm.title,
                      repeats: vm.repeats,
                      initialRepeatIndex: vm.firstIncompleteRepeatIndex,
                      onRepeatIncrement: (repeatIndex, incrementValue,
                          [date]) async {
                        var performDate =
                            date ?? context.read(selectedDateProvider).state;

                        /// Если выбранная дата не сегодня,
                        /// то выбираем в какое время хотим добавить
                        /// выполнение привычки за другую дату
                        var performTime = DateTime.now();
                        if (!performDate.isToday()) {
                          performTime = (await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(performTime),
                          ))
                              .toDateTime();
                        }

                        return context.read(habitPerformingController).create(
                              habitId: vm.id,
                              repeatIndex: repeatIndex,
                              performValue: incrementValue,
                              performDateTime:
                                  buildDateTime(performDate, performTime),
                            );
                      },
                      initialDate: context.read(selectedDateProvider).state,
                    ),
                  )
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 50),
        onPressed: () => Navigator.of(context).pushNamed(Routes.form),
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
