import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme.dart';

class PerformHabitButton extends StatelessWidget {
  final HabitVM vm;

  const PerformHabitButton({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 90,
          height: 90,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(CustomColors.green),
            value: vm.isPerformedToday ? 1 : 0,
            strokeWidth: 10,
          ),
        ),
        SizedBox(
          width: 80,
          height: 80,
          child: FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.done, size: 40),
            onPressed: () => context
                .read(habitControllerProvider.notifier)
                .perform(vm.habit),
          ),
        ),
      ],
    );
  }
}
