import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/ui/core/text.dart';

/// Статы привычек
class HabitStats extends StatelessWidget {
  /// Привычка
  final HabitVM vm;

  /// Статы привычек
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
                Headline5(vm.currentRecord.toString(), center: true),
                // Headline5("1", center: true),
                Caption("Текущий рекорд"),
              ],
            ),
          ),
          VerticalDivider(color: Colors.grey),
          Expanded(
            child: Column(
              children: [
                Headline5(vm.maxRecord.toString(), center: true),
                Caption("Макс. рекорд"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
