import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/routes.gr.dart';

class HabitArchivePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    List<HabitVM> vms = useProvider(archivedHabitVMsProvider);
    print(vms.length);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => AutoRouter.of(context).replace(CalendarRoute()),
        ),
        title: Text(
          "Архив",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemBuilder: (context, index) {
          var vm = vms[index];

          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            showAllActionsThreshold: 1,
            secondaryActions: [
              IconSlideAction(
                caption: "Вернуть",
                icon: Icons.unarchive,
                onTap: () async => await context
                    .read(habitCalendarStateProvider.notifier)
                    .unarchive(vm.habit),
              ),
              IconSlideAction(
                caption: "Удалить",
                icon: Icons.delete,
                onTap: () async => await context
                    .read(habitCalendarStateProvider.notifier)
                    .delete(vm.habit),
              ),
            ],
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(vm.habit.title),
              tileColor: Colors.white,
            ),
          );
        },
        itemCount: vms.length,
        separatorBuilder: (context, index) => SizedBox(height: 10),
      ),
    );
  }
}
