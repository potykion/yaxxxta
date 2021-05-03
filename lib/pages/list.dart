import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/widgets/habit_list_tile.dart';
import 'package:yaxxxta/widgets/web_padding.dart';

class ListHabitPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vms = useState(context.read(habitVMsProvider));
    var reorderEnabled = useState(false);

    reorder(int oldIndex, int newIndex) {
      var _items = [...vms.value];
      if (oldIndex < newIndex) newIndex -= 1;
      var item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
      vms.value = _items;
    }

    doneReorder() {
      var oldOrders =
          context.read(habitVMsProvider).map((vm) => vm.habit.order).toList();
      var newOrders = vms.value.map((vm) => vm.habit.order).toList();
      var habitsToUpdate = <String, int>{};
      for (var index in List.generate(vms.value.length, (index) => index)) {
        if (newOrders[index] != oldOrders[index]) {
          habitsToUpdate[vms.value[index].habit.id!] = oldOrders[index];
        }
      }
      context.read(habitControllerProvider.notifier).reorder(habitsToUpdate);
    }

    List<Widget> children = List.generate(vms.value.length, (index) => index)
        .map(
          (index) => HabitListTile(
            vm: vms.value[index],
            index: index,
            onTap: () => Navigator.of(context).pop(index),
            isReorder: reorderEnabled.value,
          ),
        )
        .toList();

    return WebPadding(
      child: Scaffold(
        appBar: AppBar(
          actions: [
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
            : ListView(children: children),
      ),
    );
  }
}
