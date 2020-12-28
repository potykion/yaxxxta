import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/core/ui/widgets/new_progress.dart';
import 'package:yaxxxta/core/utils/dt.dart';
import 'package:yaxxxta/deps.dart';
import 'package:yaxxxta/habit/ui/core/deps.dart';
import 'package:yaxxxta/habit/ui/core/view_models.dart';

import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../routes.dart';

class HabitRepeatControl extends StatelessWidget {
  final HabitListPageVM vm;

  const HabitRepeatControl({Key key, @required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 130,
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              HabitCard(vm: vm, repeatIndex: index),
          itemCount: vm.repeats.length,
          controller:
              PageController(initialPage: vm.firstIncompleteRepeatIndex),
        ),
      );
}

/// Карточка привычки
class HabitCard extends HookWidget {
  final HabitListPageVM vm;
  final int repeatIndex;

  HabitCard({this.vm, this.repeatIndex});

  @override
  Widget build(BuildContext context) {
    var repeat = vm.repeats[repeatIndex];
    var isSingleRepeat = vm.repeats.length == 1;
    var repeatCounter = "${repeatIndex + 1} / ${vm.repeats.length}";
    var selectedDate = useProvider(selectedDateProvider).state;

    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(Routes.details, arguments: vm.id),
      child: PaddedContainerCard(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            BiggerText(text: vm.title),
            SizedBox(width: 5),
            if (repeat.performTime != null)
              SmallerText(text: repeat.performTimeStr),
            Spacer(),
            if (!isSingleRepeat) SmallerText(text: repeatCounter)
          ],
        ),
        SizedBox(height: 5),
        HabitProgressControl(
          habitType: repeat.type,
          currentValue: repeat.currentValue,
          goalValue: repeat.goalValue,
          onValueIncrement: (value) =>
              context.read(createHabitPerformingProvider)(
            habitId: vm.id,
            repeatIndex: repeatIndex,
            performValue: value,
            performDateTime: buildDateTime(selectedDate, DateTime.now()),
          ),
        )
      ]),
    );
  }
}
