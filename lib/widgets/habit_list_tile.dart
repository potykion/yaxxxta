import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/theme.dart';

class HabitListTile extends StatelessWidget {
  final HabitVM vm;
  final int index;
  final void Function() onTap;
  final bool isReorder;

  const HabitListTile({
    Key? key,
    required this.vm,
    required this.index,
    required this.onTap,
    this.isReorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(index),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: vm.isPerformedToday
                ? CustomColors.green
                : CustomColors.lightGrey.withAlpha(31),
            width: 8,
          ),
          bottom: BorderSide(color: CustomColors.lightGrey.withAlpha(31)),
        ),
      ),
      child: ListTile(
        title: Text(vm.habit.title),
        onTap: isReorder ? null : onTap,
        trailing: !kIsWeb && isReorder ? Icon(Icons.drag_handle) : null,
      ),
    );
  }
}
