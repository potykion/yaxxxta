import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/ui/core/text.dart';

class HabitStats extends StatelessWidget {
  final HabitVM vm;

  const HabitStats({
    Key? key,
    required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Column(
              children: [
                Headline5(vm.currentStrike.toString(), center: true),
                Caption("Текущий рекорд"),
              ],
            ),
          ),
          VerticalDivider(color: Colors.grey),
          Expanded(
            child: Column(
              children: [
                Headline5(vm.maxStrike.toString(), center: true),
                Caption("Макс. рекорд"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
