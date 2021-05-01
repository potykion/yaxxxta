import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme.dart';

class PerformHabitButton extends HookWidget {
  final HabitVM vm;
  final double size;
  final void Function()? onPerform;

  PerformHabitButton({
    Key? key,
    required this.vm,
    this.size = 90,
    this.onPerform,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var confettiController = useMemoized(
      () => ConfettiController(duration: Duration(milliseconds: 600)),
    );
    useEffect(() => confettiController.dispose, []);

    return Stack(
      alignment: Alignment.center,
      children: [
        ConfettiWidget(
          confettiController: confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          colors: [
            CustomColors.yellow
          ],
          createParticlePath: drawStar,
        ),
        SizedBox(
          width: size + 10,
          height: size + 10,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(CustomColors.green),
            value: vm.isPerformedToday ? 1 : 0,
            strokeWidth: 10,
          ),
        ),
        SizedBox(
          width: size,
          height: size,
          child: FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.done, size: size / 2),
            onPressed: () async {
              await context
                  .read(habitControllerProvider.notifier)
                  .perform(vm.habit);
              confettiController.play();
              await Future<void>.delayed(confettiController.duration);
              if (onPerform != null) onPerform!();
            },
          ),
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
