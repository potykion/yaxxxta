import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/view_models.dart';
import 'package:yaxxxta/widgets/core/text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme.dart';
import 'habit_performing_form_modal.dart';

/// Инфа о выполнении выпривычки + действия над ней
class HabitHistoryEntrySlidable extends StatelessWidget {
  /// Запись о выполнении привычки
  final HabitHistoryEntry historyEntry;

  /// Привычка
  final Habit habit;

  /// Инфа о выполнении выпривычки + действия над ней
  const HabitHistoryEntrySlidable({
    Key? key,
    required this.historyEntry,
    required this.habit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: ListTile(
        dense: true,
        title: SmallerText(text: formatTime(historyEntry.time), dark: true),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmallerText(
              text: habit.type == HabitType.repeats
                  ? "число повторений: "
                  : "продолжительность: ",
            ),
            SmallerText(
              text: "${historyEntry.format(habit.type)}",
              dark: true,
            )
          ],
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: "Изменить",
          color: CustomColors.orange,
          icon: Icons.edit,
          onTap: () async {
            var habitPerforming = await showModalBottomSheet<HabitPerforming>(
              isScrollControlled: true,
              context: context,
              builder: (context) => HabitPerformingFormModal(
                initialHabitPerforming: HabitPerforming(
                  habitId: habit.id!,
                  performValue: historyEntry.value,
                  performDateTime: historyEntry.time,
                ),
                habitType: habit.type,
              ),
            );
            if (habitPerforming != null) {
              await context
                  .read(habitPerformingController.notifier)
                  .update(habit, habitPerforming);
            }
          },
        ),
        IconSlideAction(
          caption: "Удалить",
          color: CustomColors.red,
          icon: Icons.delete,
          onTap: () => context
              .read(habitPerformingController.notifier)
              .deleteForDateTime(habit.id!, historyEntry.time),
        ),
      ],
      actionPane: SlidableDrawerActionPane(),
    );
  }
}
