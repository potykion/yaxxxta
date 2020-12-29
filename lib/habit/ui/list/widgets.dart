import 'package:flutter/material.dart';

import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/new_progress.dart';
import '../../../core/ui/widgets/text.dart';
import '../core/view_models.dart';

class HabitRepeatControl extends StatelessWidget {
  final List<HabitRepeatVM> repeats;
  final int initialRepeatIndex;
  final Function(int repeatIndex, double incrementValue) onRepeatIncrement;
  final String repeatTitle;
  final Widget Function(HabitRepeatVM repeat) repeatTitleBuilder;

  const HabitRepeatControl({
    Key key,
    @required this.repeats,
    @required this.onRepeatIncrement,
    this.initialRepeatIndex = 0,
    this.repeatTitle = "",
    this.repeatTitleBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 130,
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var repeat = repeats[index];

            return PaddedContainerCard(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  repeatTitleBuilder?.call(repeat) ??
                      BiggerText(text: repeatTitle),
                  Spacer(),
                  if (repeats.length != 1)
                    SmallerText(text: "${index + 1} / ${repeats.length}")
                ],
              ),
              SizedBox(height: 5),
              HabitProgressControl(
                habitType: repeat.type,
                currentValue: repeat.currentValue,
                goalValue: repeat.goalValue,
                onValueIncrement: (value) => onRepeatIncrement(index, value),
              )
            ]);
          },
          itemCount: repeats.length,
          controller: PageController(initialPage: initialRepeatIndex),
        ),
      );
}
