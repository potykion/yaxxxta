import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:yaxxxta/ui/calendar/core/habit_list_tile.dart';
import '../../../theme.dart';
import 'page.dart';

class HabitList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vms = useProvider(habitVMsProvider);
    var archivedVms = useProvider(archivedHabitVMsProvider);

    var selectedHabitIndex = useProvider(selectedHabitIndexProvider).state;

    var archived = useState(false);

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
    List<Widget> archivedChildren =
        List.generate(archivedVms.length, (index) => index)
            .map(
              (index) => HabitListTile(
                vm: archivedVms[index],
                index: index,
                onTap: () {
                  context.read(habitToEditProvider).state =
                      archivedVms[index].habit;
                  context.read(drawerTypeProvider).state = DrawerType.editHabit;
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            )
            .toList();

    return Row(
      children: [
        SizedBox(
          child: ListView(
            children: [
              if (!archived.value)
                ...children,
              ExpansionTile(
                textColor: OldCustomColors.grey,
                collapsedTextColor: OldCustomColors.grey,
                collapsedIconColor: OldCustomColors.grey,
                iconColor: OldCustomColors.grey,

                key: PageStorageKey(0),
                title: Text("Архив"),
                trailing: Icon(null),
                leading: archived.value ? Icon(Icons.arrow_back) : null,
                children: [...archivedChildren],
                onExpansionChanged: (expanded) {
                  archived.value = expanded;
                },
              ),
            ],
          ),
          width: min(MediaQuery.of(context).size.width / 4, 300),
        ),
        VerticalDivider(),
      ],
    );
  }
}
