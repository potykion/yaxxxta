import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vibration/vibration.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/ui/calendar/app/app_bar_fab.dart';
import 'package:yaxxxta/ui/calendar/app/bottom_nav.dart';
import 'package:yaxxxta/ui/calendar/core/habit_list_tile.dart';
import 'package:yaxxxta/routes.gr.dart';

class ListHabitPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var archivedState = useState(false);
    var archived = archivedState.value;
    List<HabitVM> vms = useProvider(
      archived ? archivedHabitVMsProvider : habitVMsProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          archived ? "Архив" : "Список",
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [
          AppBarFab(
            icon: archived ? Icons.list : Icons.archive,
            onPressed: () => archivedState.value = !archivedState.value,
            text: archived ? "Список" : "Архив",
          )
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemBuilder: (context, index) {
          var vm = vms[index];

          return HabitListTile(
            key: ValueKey(index),
            vm: vm,
            index: index,
            onTap: () {
              if (archived) {
                AutoRouter.of(context).push(
                  HabitFormRoute(initial: vm.habit),
                );
              } else {
                Navigator.of(context).pop(index);
              }
            },
            onLongPress: () async {
              if (archived) return;

              await context
                  .read(habitControllerProvider.notifier)
                  .perform(vm.habit);
              if (await Vibration.hasVibrator() ?? false) {
                Vibration.vibrate(duration: 100);
              }
            },
          );
        },
        itemCount: vms.length,
        separatorBuilder: (context, index) => SizedBox(height: 10),
      ),
      bottomNavigationBar: MyBottomNav(),
    );
  }
}
