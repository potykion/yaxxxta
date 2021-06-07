import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/theme.dart';

class HabitListTile extends StatelessWidget {
  final HabitVM vm;
  final int index;
  final void Function() onTap;
  final void Function()? onLongPress;
  final bool isReorder;
  final bool isSelected;

  const HabitListTile({
    Key? key,
    required this.vm,
    required this.index,
    required this.onTap,
    this.onLongPress,
    this.isReorder = false,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      tileColor: vm.isPerformedToday ? Color(0xfff1fafa) : Colors.white,
      title: Text(vm.habit.title),
      subtitle: Text(
        "Текущий стрик: ${vm.currentStrike} · Макс. стрик: ${vm.maxStrike}",
      ),
      onTap: isReorder ? null : onTap,
      onLongPress: onLongPress,
      trailing: !kIsWeb && isReorder ? Icon(Icons.drag_handle) : null,
    );
  }
}
