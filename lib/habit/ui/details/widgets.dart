import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:yaxxxta/core/utils/dt.dart';
import 'package:yaxxxta/habit/ui/core/deps.dart';
import 'package:yaxxxta/habit/ui/core/widgets.dart';
import 'package:yaxxxta/habit/ui/details/view_models.dart';

import '../../../core/ui/widgets/text.dart';
import '../../../routes.dart';
import '../../../theme.dart';
import '../../domain/models.dart';

/// Тип действия над привычкой
enum HabitActionType {
  /// Редактирование привычки
  edit,

  /// Удаление привычки
  delete
}

class HabitActionsButton extends StatelessWidget {
  final Habit habit;

  const HabitActionsButton({Key key, this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () async {
        var actionType = await showModalBottomSheet<HabitActionType>(
          context: context,
          builder: (context) => Container(
            height: 170,
            child: ListView(
              children: [
                ListTile(
                  title: BiggerText(text: "Что делаем с привычкой?"),
                ),
                ListTile(
                  title: Text("Редактируем"),
                  onTap: () => Navigator.of(context).pop(HabitActionType.edit),
                ),
                ListTile(
                  title: Text("Удаляем"),
                  onTap: () =>
                      Navigator.of(context).pop(HabitActionType.delete),
                ),
              ],
            ),
          ),
        );

        if (actionType == HabitActionType.edit) {
          Navigator.of(context).pushNamed(Routes.form, arguments: habit);
        } else if (actionType == HabitActionType.delete) {
          var isDelete = await showModalBottomSheet<bool>(
            context: context,
            builder: (context) => Container(
              height: 170,
              child: ListView(
                children: [
                  ListTile(
                    title: BiggerText(text: "Точно удаляем?"),
                  ),
                  ListTile(
                    title: Text("Да"),
                    onTap: () => Navigator.of(context).pop(true),
                  ),
                  ListTile(
                    title: Text("Не"),
                    onTap: () => Navigator.of(context).pop(false),
                  ),
                ],
              ),
            ),
          );
          if (isDelete ?? false) {
            context.read(habitControllerProvider).delete(habit.id);
            Navigator.of(context).pop(true);
          }
        }
      });
}

class HabitHistoryEntrySlidable extends StatelessWidget {
  final HabitHistoryEntry historyEntry;
  final Habit habit;

  const HabitHistoryEntrySlidable({Key key, this.historyEntry, this.habit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        child: Row(children: [
          SmallerText(
            text: formatTime(historyEntry.time),
            dark: true,
          ),
          Spacer(),
          SmallerText(
            text: "+ ${historyEntry.format(habit.type)}",
            dark: true,
          )
        ]),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: "Изменить",
          color: CustomColors.orange,
          icon: Icons.edit,
          onTap: () async {
            var habitPerforming = await showModalBottomSheet<HabitPerforming>(
              context: context,
              builder: (context) => HabitPerformingFormModal(
                initialHabitPerforming: HabitPerforming(
                  habitId: habit.id,
                  performValue: historyEntry.value,
                  performDateTime: historyEntry.time,
                ),
                habitType: habit.type,
              ),
            );
            if (habitPerforming != null) {
              await context
                  .read(habitPerformingController)
                  .update(habitPerforming);
            }
          },
        ),
        IconSlideAction(
          caption: "Удалить",
          color: CustomColors.red,
          icon: Icons.delete,
          onTap: () => context
              .read(habitPerformingController)
              .deleteForDateTime(historyEntry.time),
        ),
      ],
      actionPane: SlidableDrawerActionPane(),
    );
  }
}


class CreateHabitPerformingButton extends StatelessWidget {
  final Habit habit;

  const CreateHabitPerformingButton({Key key, this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return                     IconButton(
      icon: Icon(Icons.add),
      onPressed: () async {
        var habitPerforming =
        await showModalBottomSheet<HabitPerforming>(
          context: context,
          builder: (context) => HabitPerformingFormModal(
            initialHabitPerforming:
            HabitPerforming.blank(habit.id),
            habitType: habit.type,
          ),
        );
        if (habitPerforming != null) {
          await context
              .read(habitPerformingController)
              .insert(habitPerforming);
        }
      },
    );
  }
}
