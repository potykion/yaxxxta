import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/ui/core/bottom_sheet.dart';
import 'package:yaxxxta/ui/core/text.dart';

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
        Headline5(
          habit.value.id != null ? "Редактирование" : "Создание",
          trailing: habit.value.id != null
              ? IconButton(
                  color: Theme.of(context).canvasColor,
                  icon: Icon(Icons.more_vert),
                  onPressed: () => showHabitActionsBottomSheet(
                    context,
                    habit.value,
                  ),
                )
              : null,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Headline6("Название"),
            TextFormField(
              readOnly: habit.value.archived,
              controller: titleTec,
              decoration: InputDecoration(
                hintText: 'Например, "Зайти в приложение"',
              ),
            ),
          ],
        ),
        ButtonWithIconAndText(
          icon: Icons.save,
          text: "Сохранить",
          onPressed: () {
            if (habit.value.title.isNotEmpty) {
              Navigator.of(context).pop(habit.value);
            }
          },
        ),
      ],
    );
  }
}

Future<Habit?> showHabitFormBottomSheet(
  BuildContext context, {
  Habit? initial,
}) =>
    showCoreBottomSheet<Habit>(
      context,
      HabitInfoCard(
        roundOnlyTop: true,
        margin: EdgeInsets.zero,
        child: HabitForm(initial: initial),
      ),
    );

Future<void> showHabitActionsBottomSheet(
  BuildContext context,
  Habit habit,
) =>
    showCoreBottomSheet(
      context,
      HabitInfoCard(
        roundOnlyTop: true,
        margin: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Headline5("Другие действия"),
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
            ),
          ],
        ),
      ),
      height: 140,
    );
