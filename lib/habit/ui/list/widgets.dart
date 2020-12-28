import 'package:flutter/material.dart';

import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/new_progress.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../routes.dart';
import '../core/view_models.dart';

class HabitRepeatControl extends StatelessWidget {
  final ProgressHabitVM vm;
  final Function(int repeatIndex, double incrementValue) onRepeatIncrement;

  final String repeatTitle;
  final Widget Function(HabitRepeatVM repeat) repeatTitleBuilder;

  const HabitRepeatControl({
    Key key,
    this.repeatTitleBuilder,
    @required this.vm,
    @required this.onRepeatIncrement,
    this.repeatTitle = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 130,
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            // todo vm.repeats + vm.firstIncompleteRepeatIndex as params
            var repeat = vm.repeats[index];
            var isSingleRepeat = vm.repeats.length == 1;
            var repeatCounter = "${index + 1} / ${vm.repeats.length}";

            return GestureDetector(
              // todo extract pushNamed
              onTap: () => Navigator.of(context).pushNamed(
                Routes.details,
                arguments: vm.id,
              ),
              child: PaddedContainerCard(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    repeatTitleBuilder?.call(repeat) ??
                        BiggerText(text: repeatTitle),
                    Spacer(),
                    if (!isSingleRepeat) SmallerText(text: repeatCounter)
                  ],
                ),
                SizedBox(height: 5),
                HabitProgressControl(
                  habitType: repeat.type,
                  currentValue: repeat.currentValue,
                  goalValue: repeat.goalValue,
                  onValueIncrement: (value) => onRepeatIncrement(index, value),
                )
              ]),
            );
          },
          itemCount: vm.repeats.length,
          controller: PageController(
            initialPage: vm.firstIncompleteRepeatIndex,
          ),
        ),
      );
}
