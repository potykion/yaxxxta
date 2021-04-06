import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/widgets/core/text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../routes.dart';
import '../../theme.dart';

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
  const HabitActionsButton({Key? key, required this.habit}) : super(key: key);

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
            await context.read(habitControllerProvider.notifier).delete(habit.id!);
            Navigator.of(context).pop(true);
          }
        }
      });
}
