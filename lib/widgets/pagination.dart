import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/vms.dart';

import '../theme.dart';

class HabitPagination extends StatelessWidget {
  final int currentIndex;
  final List<HabitVM> vms;

  const HabitPagination({
    Key? key,
    required this.currentIndex,
    required this.vms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i in List.generate(vms.length, (index) => index))
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: i == currentIndex
                    ? CustomColors.yellow
                    : vms[i].isPerformedToday
                        ? CustomColors.green
                        : CustomColors.lightGrey.withAlpha(31),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          )
      ],
    );
  }
}
