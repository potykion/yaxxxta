import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/state/form.dart';
import 'package:yaxxxta/ui/core/bottom_sheet.dart';
import 'package:yaxxxta/ui/core/text.dart';
import 'package:yaxxxta/ui/form/habit_notification_input.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';

import '../core/button.dart';
import 'habit_frequency_type_input.dart';
import 'habit_perform_weekday_input.dart';

/// Форма привычки
class HabitForm extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var habit = useProvider(habitFormStateProvider);
    var habits = useProvider(habitVMsProvider);
    var showTooManyHabitsLabel =
        useMemoized(() => habits.length > 10 && Random().nextBool());

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
                  icon: Icon(Icons.more_vert),
                  onPressed: () => showHabitActionsBottomSheet(
                    context,
                    habit,
                  ),
                )
              : null,
        ),
        Column(
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
          children: [
            Headline6("Периодичность"),
            HabitFrequencyTypeInput(
              initial: habit.frequencyType,
              change: (freqType) => context
                  .read(habitFormStateProvider.notifier)
                  .update(habit.copyWith(frequencyType: freqType)),
            ),
          ],
        ),
        if (habit.frequencyType == HabitFrequencyType.weekly)
          Column(
            children: [
              Headline6("Когда выполняется привычка?"),
              HabitPerformWeekdayInput(
                initial: habit.performWeekday,
                change: (weekday) {
                  context
                      .read(habitFormStateProvider.notifier)
                      .update(habit.copyWith(performWeekday: weekday));

                  if (habit.notification != null) {
                    context
                        .read(habitFormStateProvider.notifier)
                        .setNotification(
                          TimeOfDay.fromDateTime(habit.notification!.time)
                              .toDateTime(weekday: weekday),
                        );
                  }
                },
              ),
            ],
          ),
        Column(
          children: [
            Headline6("Напоминалка"),
            HabitNotificationInput(
              habit: habit,
              setNotification:
                  context.read(habitFormStateProvider.notifier).setNotification,
              removeNotification: context
                  .read(habitFormStateProvider.notifier)
                  .removeNotification,
            ),
          ],
        ),
        SizedBox(height: 8),
        if (showTooManyHabitsLabel)
          Text(
            "Уже больше 10 привычек, может хватит?",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        SizedBox(height: 8),
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

/// Показывает формочку привычки в щите
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

/// Показывает боттом шит с другими действиями над привычками
/// напр. отправка в архив
Future<void> showHabitActionsBottomSheet(
  BuildContext context,
  Habit habit,
) =>
    showCoreBottomSheet(
      context,
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Headline5("Другие действия"),
          SizedBox(height: 8),
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
    );
