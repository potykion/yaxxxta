import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/models.dart';

import 'button_with_icon_and_text.dart';

class PerformHabitButton extends StatelessWidget {
  final Habit habit;

  const PerformHabitButton({
    Key? key,
    required this.habit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ButtonWithIconAndText(
        text: "Выполнить",
        icon: Icons.done,
        onPressed: () =>
            context.read(habitControllerProvider.notifier).perform(habit),
      );
}
