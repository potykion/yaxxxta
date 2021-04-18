import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme.dart';

class PerformHabitButton extends StatelessWidget {
  final HabitVM vm;
  final double size;

  const PerformHabitButton({
    Key? key,
    required this.vm,
    this.size = 90,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
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
            onPressed: () => context
                .read(habitControllerProvider.notifier)
                .perform(vm.habit),
          ),
        ),
      ],
    );
  }
}
