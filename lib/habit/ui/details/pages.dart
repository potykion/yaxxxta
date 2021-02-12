import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../core/ui/deps.dart';
import '../../../core/ui/widgets/app_bars.dart';
import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/circular_progress.dart';
import '../../../core/ui/widgets/date.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../core/utils/dt.dart';
import '../../domain/models.dart';
import '../core/deps.dart';
import '../core/view_models.dart';
import '../core/widgets.dart';
import 'widgets.dart';

GlobalKey _scaffold = GlobalKey();

/// Страничка с инфой о привычке
class HabitDetailsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        context.read(habitPerformingController).loadSelectedHabitPerformings(
            context.read(selectedHabitIdProvider).state);
      });
      return;
    }, []);

    var vmAsyncValue = useProvider(habitDetailsPageVMProvider);
    var historyDateState = useState(DateTime.now().date());

    return vmAsyncValue.maybeWhen(
      data: (vm) {
        var habit = vm.habit;
        var progress = vm.progress;
        var history = vm.history;

        return Scaffold(
          key: _scaffold,
          appBar: buildAppBar(
            child: Row(
              children: [
                BackButton(),
                Expanded(child: BiggestText(text: habit.title)),
                HabitActionsButton(habit: habit),
              ],
            ),
          ),
          body: ListView(
            children: [
              ListTile(title: HabitChips(habit: habit)),
              _buildTodayHabitProgressControl(habit, progress),
              PaddedContainerCard(children: [
                Row(
                  children: [
                    BiggerText(text: "История"),
                    Spacer(),
                    CreateHabitPerformingButton(habit: habit),
                  ],
                ),
                SizedBox(height: 5),
                DateCarousel(
                  change: (d) => historyDateState.value = d,
                  highlights: history.highlights,
                ),
                for (var e in history.getForDate(historyDateState.value))
                  HabitHistoryEntrySlidable(historyEntry: e, habit: habit)
              ])
            ],
          ),
        );
      },
      orElse: () => Scaffold(
        body: CenteredCircularProgress(),
      ),
    );
  }

  HabitProgressControl _buildTodayHabitProgressControl(
    Habit habit,
    HabitProgressVM progress,
  ) =>
      HabitProgressControl(
        key: Key("HabitDetailsPage_HabitRepeatControl"),
        vm: progress,
        onRepeatIncrement: (incrementValue, _, [__]) => navigatorKey
            .currentContext
            .read(habitPerformingController)
            .insert(HabitPerforming.blank(
              habit.id,
              performValue: incrementValue,
            )),
        repeatTitle: "Сегодня",
      );
}
