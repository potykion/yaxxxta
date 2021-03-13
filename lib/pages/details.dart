import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/utils/dt.dart';
import '../deps.dart';
import '../habit/domain/models.dart';
import '../habit/ui/core/view_models.dart';
import '../habit/ui/core/widgets.dart';
import '../habit/ui/details/widgets.dart';
import '../widgets/core/app_bars.dart';
import '../widgets/core/card.dart';
import '../widgets/core/circular_progress.dart';
import '../widgets/core/date.dart';
import '../widgets/core/text.dart';

GlobalKey _scaffold = GlobalKey();

/// Страничка с инфой о привычке
class HabitDetailsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        context.read(habitPerformingController).loadSelectedHabitPerformings(
            context.read(selectedHabitIdProvider).state!);
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
            context: context,
            children: [
              BackButton(),
              Expanded(child: BiggestText(text: habit.title)),
              HabitActionsButton(habit: habit),
            ],
          ),
          body: ListView(
            children: [
              ListTile(title: HabitChips(habit: habit), dense: true),
              _buildTodayHabitProgressControl(context, habit, progress),
              ContainerCard(
                children: [
                  ListTile(
                    dense: true,
                    title: BiggerText(text: "История"),
                    trailing: CreateHabitPerformingButton(
                      habit: habit,
                      initialDate: historyDateState.value,
                    ),
                  ),
                  DateCarousel(
                    initial: historyDateState.value,
                    change: (d) => historyDateState.value = d,
                    highlights: history.highlights,
                  ),
                  for (var e in history.getForDate(historyDateState.value))
                    HabitHistoryEntrySlidable(historyEntry: e, habit: habit)
                ],
              )
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
    BuildContext context,
    Habit habit,
    HabitProgressVM progress,
  ) =>
      HabitProgressControl(
        key: Key("HabitDetailsPage_HabitRepeatControl"),
        vm: progress,
        onRepeatIncrement: (incrementValue, _, [__]) async {
          await navigatorKey.currentContext!
              .read(habitPerformingController)
              .insert(HabitPerforming.blank(
                habitId: habit.id!,
                performValue: incrementValue,
              ));

          context.read(habitCalendarPage_AnimatedListState_Provider).reset();
        },
        repeatTitle: "Сегодня",
      );
}