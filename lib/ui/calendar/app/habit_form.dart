import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/models.dart';

import 'bottom_sheet.dart';
import 'button_with_icon_and_text.dart';
import 'habit_info_card.dart';

class HabitForm extends HookWidget {
  final Habit? initial;

  HabitForm({this.initial});

  @override
  Widget build(BuildContext context) {
    var habit = useState(
      initial ?? Habit.blank(userId: FirebaseAuth.instance.currentUser!.uid),
    );

    var titleTec = useTextEditingController(text: habit.value.title);
    titleTec.addListener(() {
      habit.value = habit.value.copyWith(title: titleTec.text);
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              habit.value.id != null ? "Редактирование" : "Создание",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: Colors.white),
            ),
            Opacity(
              opacity: habit.value.id != null ? 1 : 0,
              child: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () => showHabitActionsBottomSheet(
                  context,
                  habit.value,
                ),
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              "Название",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.white),
            ),
            SizedBox(height: 8),
            TextFormField(
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              readOnly: habit.value.archived,
              controller: titleTec,
              decoration: InputDecoration(
                hintText: 'Например, "Зайти в приложение"',
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(height: 8),
            ButtonWithIconAndText(
              icon: Icons.save,
              text: "Сохранить",
              onPressed: () {
                if (habit.value.title.isNotEmpty) {
                  Navigator.of(context).pop(habit.value);
                }
              },
            ),
            SizedBox(height: 8),
          ],
        )
      ],
    );
  }
}

Future<Habit?> showHabitFormBottomSheet(
  BuildContext context, {
  Habit? initial,
}) =>
    showModalBottomSheet<Habit>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BottomSheetContainer(
        child: HabitInfoCard(
          roundOnlyTop: true,
          color: Theme.of(context).canvasColor,
          margin: EdgeInsets.zero,
          child: HabitForm(initial: initial),
        ),
      ),
    );

Future<void> showHabitActionsBottomSheet(
  BuildContext context,
  Habit habit,
) =>
    showModalBottomSheet<Habit>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BottomSheetContainer(
        height: 100,
        child: HabitInfoCard(
          roundOnlyTop: true,
          color: Theme.of(context).canvasColor,
          margin: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWithIconAndText(
                text: "Отправить в архив",
                icon: Icons.archive,
                onPressed: () async {
                  await context
                      .read(habitControllerProvider.notifier)
                      .archive(habit);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
