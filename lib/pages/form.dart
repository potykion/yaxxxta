import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:yaxxxta/widgets/full_width_btn.dart';

enum HabitExtraAction { archive }

@Deprecated("Юзай lib/ui/calendar/app/habit_form.dart!!!!!!!!!!!!!!1")
class HabitFormPage extends HookWidget {
  final Habit? initial;

  HabitFormPage({this.initial});

  @override
  Widget build(BuildContext context) {
    var habit = useState(
      initial ?? Habit.blank(userId: FirebaseAuth.instance.currentUser!.uid),
    );

    var titleTec = useTextEditingController(text: habit.value.title);
    titleTec.addListener(() {
      habit.value = habit.value.copyWith(title: titleTec.text);
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          habit.value.id != null ? "Редактирование" : "Создание",
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [
          if (habit.value.id != null)
            PopupMenuButton(
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: HabitExtraAction.archive,
                  child: Text('Архивировать'),
                ),
              ],
              onSelected: (HabitExtraAction action) {
                switch (action) {
                  case HabitExtraAction.archive:
                    context
                        .read(habitControllerProvider.notifier)
                        .archive(habit.value);
                    return Navigator.of(context).pop(true);
                }
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Название привычки",
              style: Theme.of(context).textTheme.headline6,
            ),
            Padding(padding: EdgeInsets.only(bottom: 4)),
            TextFormField(
              readOnly: habit.value.archived,
              controller: titleTec,
              decoration: InputDecoration(
                hintText: 'Например "Зайти в приложение"',
              ),
            ),
            Spacer(),
            if (!habit.value.archived)
              FullWidthButton(
                onPressed: () async {
                  var created = false;
                  if (habit.value.id != null) {
                    await context
                        .read(habitControllerProvider.notifier)
                        .update(habit.value);
                  } else {
                    await context
                        .read(habitControllerProvider.notifier)
                        .create(habit.value);
                    created = true;
                  }

                  Navigator.of(context).pop(created);
                },
                text: "Сохранить",
              ),
            if (habit.value.archived) ...<Widget>[
              FullWidthButton(
                text: "Разархивировать",
                onPressed: () async {
                  await context
                      .read(habitControllerProvider.notifier)
                      .update(habit.value.copyWith(archived: false));
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 10),
              FullWidthButton(
                text: "Удалить",
                isDanger: true,
                onPressed: () async {
                  await context
                      .read(habitControllerProvider.notifier)
                      .delete(habit.value);
                  Navigator.of(context).pop();
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
}
