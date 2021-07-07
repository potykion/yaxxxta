import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/vms.dart';

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
                Text(vm.currentStrike.toString(),
                    style: Theme.of(context).textTheme.headline5),
                Text("Текущий стрик", style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
          VerticalDivider(color: Colors.grey),
          Expanded(
            child: Column(
              children: [
                Text(
                  vm.maxStrike.toString(),
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text("Макс. стрик", style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
