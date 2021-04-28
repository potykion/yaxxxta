import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/widgets/web_padding.dart';

class ListHabitPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vms = useState(context.read(habitVMsProvider));
    var reorderEnabled = useState(false);

    Widget buildListTile(int index) {
      var vm = vms.value[index];

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
          onTap: reorderEnabled.value
              ? null
              : () => Navigator.of(context).pop(index),
          trailing:
              !kIsWeb && reorderEnabled.value ? Icon(Icons.drag_handle) : null,
        ),
      );
    }

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
        .map(buildListTile)
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
