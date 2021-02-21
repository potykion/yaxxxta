import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/ui/widgets/text.dart';
import '../../../core/utils/dt.dart';
import '../../../routes.dart';
import '../../../theme.dart';
import '../../domain/models.dart';
import '../core/deps.dart';
import '../core/widgets.dart';
import 'view_models.dart';

/// Тип действия над привычкой
enum HabitActionType {
  /// Редактирование привычки
  edit,

  /// Удаление привычки
  delete
}

/// Кнопочка, открывающая меню с действиями над привычкой
class HabitActionsButton extends StatelessWidget {
  /// Привычка
  final Habit habit;

  /// Кнопочка, открывающая меню с действиями над привычкой
  const HabitActionsButton({Key key, this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
      icon: Icon(Icons.more_vert),
      color: CustomColors.almostBlack,
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
            await context.read(habitControllerProvider).delete(habit.id);
            Navigator.of(context).pop(true);
          }
        }
      });
}

/// Инфа о выполнении выпривычки + действия над ней
class HabitHistoryEntrySlidable extends StatelessWidget {
  /// Запись о выполнении привычки
  final HabitHistoryEntry historyEntry;

  /// Привычка
  final Habit habit;

  /// Инфа о выполнении выпривычки + действия над ней
  const HabitHistoryEntrySlidable({
    Key key,
    this.historyEntry,
    this.habit,
  }) : super(key: key);

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

/// Кнопка, открывающая форму создания выполнения привычки
class CreateHabitPerformingButton extends StatelessWidget {
  /// Привычка
  final Habit habit;

  /// Дата выполнения
  final DateTime initialDate;

  /// Кнопка, открывающая форму создания выполнения привычки
  const CreateHabitPerformingButton({
    Key key,
    @required this.habit,
    @required this.initialDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () async {
        var habitPerforming = await showModalBottomSheet<HabitPerforming>(
          context: context,
          builder: (context) => HabitPerformingFormModal(
            initialHabitPerforming: HabitPerforming.blank(
              habitId: habit.id,
              performDateTime: buildDateTime(
                initialDate,
                DateTime.now(),
              ),
            ),
            habitType: habit.type,
          ),
        );
        if (habitPerforming != null) {
          await context.read(habitPerformingController).insert(habitPerforming);
        }
      },
    );
  }
}
