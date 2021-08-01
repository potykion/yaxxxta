import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:vibration/vibration.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/ui/core/button.dart';

/// Кнопа выполнения привычки
class PerformHabitButton extends HookWidget {
  /// Привычка
  final Habit habit;

  /// Кнопа выполнения привычки
  const PerformHabitButton(this.habit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var confettiController = useMemoized(
      () => ConfettiController(duration: Duration(milliseconds: 500)),
    );
    useEffect(() => confettiController.dispose, []);

    return Stack(
      alignment: Alignment.center,
      children: [
        ConfettiWidget(
          confettiController: confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          colors: [Theme.of(context).colorScheme.primary],
          createParticlePath: drawStar,
        ),
        CoreButton(
          text: "Выполнить",
          icon: Icons.done,
          onPressed: () async {
            await context
                .read(habitCalendarStateProvider.notifier)
                .perform(habit);
            confettiController.play();
            if (await Vibration.hasVibrator() ?? false) {
              Vibration.vibrate(duration: 100);
            }
            await Future<void>.delayed(
              confettiController.duration - Duration(milliseconds: 100),
            );
          },
        ),
      ],
    );
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}
