import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/ui/calendar/core/habit_list_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HabitList extends StatelessWidget {
  final List<HabitVM> vms;
  final void Function(int index)? onHabitSelect;

  const HabitList({
    Key? key,
    required this.vms,
    this.onHabitSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      itemBuilder: (context, index) {
        var vm = vms[index];

        return HabitListTile(
          vm: vm,
          index: index,
          onTap: () {
            if (onHabitSelect != null) {
              onHabitSelect!(index);
            }
          },
          onLongPress: () async {
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
      separatorBuilder: (context, index) => SizedBox(height: 8),
    );
  }
}
