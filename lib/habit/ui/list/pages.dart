import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/core/ui/widgets/circular_progress.dart';
import 'package:yaxxxta/core/ui/widgets/text.dart';
import 'package:yaxxxta/habit/ui/core/deps.dart';
import 'package:yaxxxta/habit/ui/core/view_models.dart';
import 'package:yaxxxta/theme.dart';
import '../../../core/ui/widgets/bottom_nav.dart';
import '../../../core/utils/dt.dart';

import '../../../core/ui/widgets/date.dart';
import '../../../routes.dart';
import '../core/widgets.dart';

/// Страница списка привычек
class HabitListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read(habitPerformingController).load(DateTime.now());
      });
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
                      withPerformTime: true,
                      repeatTitle: vm.firstRepeat.performTime != null
                          ? "${vm.firstRepeat.performTimeStr}: ${vm.title}"
                          : vm.title,
                      repeats: vm.repeats,
                      initialRepeatIndex: vm.firstIncompleteRepeatIndex,
                      onRepeatIncrement: (repeatIndex, incrementValue,
                              [date]) =>
                          context.read(habitPerformingController).create(
                                habitId: vm.id,
                                repeatIndex: repeatIndex,
                                performValue: incrementValue,
                                performDateTime: buildDateTime(
                                  date ??
                                      context.read(selectedDateProvider).state,
                                  DateTime.now(),
                                ),
                              ),
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
