import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/ui/calendar/core/habit_list_tile.dart';
import 'page.dart';

class HabitList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vms = useProvider(habitVMsProvider);
    var selectedHabitIndex = useProvider(selectedHabitIndexProvider).state;

    List<Widget> children = List.generate(vms.length, (index) => index)
        .map(
          (index) => HabitListTile(
            vm: vms[index],
            index: index,
            onTap: () => context.read(selectedHabitIndexProvider).state = index,
            isSelected: selectedHabitIndex == index,
          ),
        )
        .toList();

    return Row(
      children: [
        SizedBox(
          child: ListView(children: children),
          width: min(MediaQuery.of(context).size.width / 4,  300),
        ),
        VerticalDivider(),
      ],
    );
  }
}
