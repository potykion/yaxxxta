import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/models.dart';

class PerformHabitButton extends StatelessWidget {
  final Habit habit;

  const PerformHabitButton({
    Key? key,
    required this.habit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonWithIconAndText(
        text: "Выполнить",
        icon: Icons.done,
        onPressed: () async {
          await context.read(habitControllerProvider.notifier).perform(habit);
        });
  }
}

class ButtonWithIconAndText extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const ButtonWithIconAndText({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 12, horizontal: 12)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          )),
        ),
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}
