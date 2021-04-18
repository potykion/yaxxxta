import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/widgets/bottom_nav.dart';

import '../routes.dart';

class ListHabitPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vms = useState(context.read(habitVMsProvider));
    var reorderEnabled = useState(false);

    Widget buildListTile(int index) {
      return ListTile(
        key: ValueKey(index),
        title: Text(vms.value[index].habit.title),
        onTap: reorderEnabled.value
            ? null
            : () => Navigator.pushReplacementNamed(
                  context,
                  Routes.calendar,
                  arguments: index,
                ),
        trailing: reorderEnabled.value ? Icon(Icons.reorder) : null,
      );
    }

    reorder(int oldIndex, int newIndex) {
      var _items = [...vms.value];
      if (oldIndex < newIndex) newIndex -= 1;
      var item = _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
      vms.value = _items;

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

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: reorderEnabled.value ? Icon(Icons.list) : Icon(Icons.reorder),
            onPressed: () => reorderEnabled.value = !reorderEnabled.value,
          ),
        ],
      ),
      body: reorderEnabled.value
          ? ReorderableListView.builder(
              itemBuilder: (_, index) => buildListTile(index),
              itemCount: vms.value.length,
              onReorder: reorder,
            )
          : ListView.builder(
              itemCount: vms.value.length,
              itemBuilder: (_, index) => buildListTile(index),
            ),
      bottomNavigationBar: MyBottomNav(),
    );
  }
}
