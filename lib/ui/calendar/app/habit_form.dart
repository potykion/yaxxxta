import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/state/form.dart';
import 'package:yaxxxta/logic/core/utils/time.dart';
import 'package:yaxxxta/ui/core/bottom_sheet.dart';
import 'package:yaxxxta/ui/core/text.dart';

import '../../core/button.dart';

class HabitForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var habit = useProvider(habitFormStateProvider);

    var titleTec = useTextEditingController(text: habit.title);
    titleTec.addListener(() {
      context
          .read(habitFormStateProvider.notifier)
          .update(habit.copyWith(title: titleTec.text));
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Headline5(
          habit.id != null ? "Изменить привычку" : "Создать привычку",
          trailing: habit.id != null
              ? IconButton(
                  color: Theme.of(context).canvasColor,
                  icon: Icon(Icons.more_vert),
                  onPressed: () => showHabitActionsBottomSheet(
                    context,
                    habit,
                  ),
                )
              : null,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Headline6("Название"),
            TextFormField(
              readOnly: habit.archived,
              controller: titleTec,
              decoration: InputDecoration(
                hintText: 'Например, "Зайти в приложение"',
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Headline6("Напоминалка"),
            if (habit.notification != null)
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: habit.notification!.toTimeStr(),
                ),
                onTap: () {},
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => context
                        .read(habitFormStateProvider.notifier)
                        .removeNotification(),
                    icon: Icon(
                      Icons.clear,
                      color: Color(0xff272343),
                    ),
                  ),
                ),
              )
            else
              CoreButton(
                text: "Добавить",
                icon: Icons.notifications,
                onPressed: () async {
                  var time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                    cancelText: "Отмена",
                    confirmText: "Ок",
                    helpText: "Выбери время напоминалки",
                  );
                  if (time == null) return;
                  await context
                      .read(habitFormStateProvider.notifier)
                      .setNotification(time.toDateTime());
                },
              ),
          ],
        ),
        SizedBox(height: 16),
        CoreButton(
          icon: Icons.save,
          text: "Сохранить",
          onPressed: () {
            if (habit.title.isNotEmpty) {
              Navigator.of(context).pop(habit);
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
}) {
  if (initial != null) {
    context.read(habitFormStateProvider.notifier).update(initial);
  } else {
    context.read(habitFormStateProvider.notifier).reset();
  }

  return showCoreBottomSheet<Habit>(context, HabitForm());
}

Future<void> showHabitActionsBottomSheet(
  BuildContext context,
  Habit habit,
) =>
    showCoreBottomSheet(
      context,
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Headline5("Другие действия"),
          CoreButton(
            text: "Отправить в архив",
            icon: Icons.archive,
            onPressed: () async {
              await context
                  .read(habitCalendarStateProvider.notifier)
                  .archive(habit);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      height: 140,
    );
