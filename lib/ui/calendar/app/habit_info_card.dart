import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/vms.dart';

class HabitInfoCard extends StatelessWidget {
  final HabitVM vm;
  final Widget child;

  const HabitInfoCard({
    Key? key,
    required this.child,
    required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: vm.isPerformedToday
          ? Color(0xfff1fafa)
          : null,
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: child,
      ),
    );
  }
}
