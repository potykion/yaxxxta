import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vibration/vibration.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/ui/calendar/app/bottom_nav.dart';
import 'package:yaxxxta/ui/calendar/core/habit_list_tile.dart';
import 'package:yaxxxta/routes.gr.dart';

class ListHabitPage extends HookWidget {
  final bool canReorder;
  final bool archived;

  ListHabitPage({
    this.canReorder = true,
    this.archived = false,
  });

  @override
  Widget build(BuildContext context) {
    List<HabitVM> vms = useProvider(
      archived ? archivedHabitVMsProvider : habitVMsProvider,
    );
    var vmsToReorder = useState(vms);
    useValueChanged<List<HabitVM>, void>(vms, (_, __) {
      vmsToReorder.value = vms;
    });

    var reorderEnabled = useState(false);

    reorder(int oldIndex, int newIndex) {
      var _items = [...vmsToReorder.value];
      if (oldIndex < newIndex) newIndex -= 1;
      var item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
      vmsToReorder.value = _items;
    }

    doneReorder() {
      var oldOrders =
          context.read(habitVMsProvider).map((vm) => vm.habit.order).toList();
      var newOrders = vmsToReorder.value.map((vm) => vm.habit.order).toList();
      var habitsToUpdate = <String, int>{};
      for (var index
          in List.generate(vmsToReorder.value.length, (index) => index)) {
        if (newOrders[index] != oldOrders[index]) {
          habitsToUpdate[vmsToReorder.value[index].habit.id!] =
              oldOrders[index];
        }
      }
      context.read(habitControllerProvider.notifier).reorder(habitsToUpdate);
    }

    List<Widget> children =
        List.generate(vmsToReorder.value.length, (index) => index)
            .map(
              (index) => HabitListTile(
                key: ValueKey(index),
                vm: vmsToReorder.value[index],
                index: index,
                onTap: () {
                  if (archived) {
                    AutoRouter.of(context).push(
                      HabitFormRoute(initial: vmsToReorder.value[index].habit),
                    );
                  } else {
                    Navigator.of(context).pop(index);
                  }
                },
                onLongPress: () async {
                  if (archived) return;

                  await context
                      .read(habitControllerProvider.notifier)
                      .perform(vmsToReorder.value[index].habit);
                  if (await Vibration.hasVibrator() ?? false) {
                    Vibration.vibrate(duration: 100);
                  }
                },
                isReorder: reorderEnabled.value,
              ),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        actions: [
          if (canReorder)
            IconButton(
              icon:
                  reorderEnabled.value ? Icon(Icons.done) : Icon(Icons.reorder),
              onPressed: () {
                if (reorderEnabled.value) {
                  doneReorder();
                }
                reorderEnabled.value = !reorderEnabled.value;
              },
            ),
        ],
      ),
      body: reorderEnabled.value
          ? ReorderableListView(children: children, onReorder: reorder)
          : Column(
              children: [
                Expanded(child: ListView(children: children)),
                if (!archived) ...[
                  Divider(),
                  ListTile(
                    title: Text(
                      "Архив",
                      style: TextStyle(color: CustomColors.grey),
                    ),
                    onTap: () => AutoRouter.of(context).push(
                      ListHabitRoute(canReorder: false, archived: true),
                    ),
                  ),
                ],
              ],
            ),
      bottomNavigationBar: MyBottomNav(),
    );
  }
}
