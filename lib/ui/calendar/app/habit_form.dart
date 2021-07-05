import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/notifications/daily.dart';
import 'package:yaxxxta/logic/core/utils/time.dart';
import 'package:yaxxxta/ui/core/bottom_sheet.dart';
import 'package:yaxxxta/ui/core/text.dart';

import '../../core/button.dart';
import '../../core/card.dart';

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
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Headline5(
          habit.value.id != null ? "Изменить привычку" : "Создать привычку",
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Headline6("Напоминалка"),
            if (habit.value.notification != null)
              TextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: habit.value.notification!.toTimeStr(),
                ),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () async {
                      await DailyHabitPerformNotifications.remove(
                          habit.value.notification!.id);
                      habit.value = habit.value.copyWith(notification: null);
                    },
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
                  var datetime = time.toDateTime();
                  var notificationId =
                      await DailyHabitPerformNotifications.create(
                    habit.value,
                    datetime,
                  );
                  habit.value = habit.value.copyWith(
                    notification: HabitNotificationSettings(
                      id: notificationId,
                      time: datetime,
                    ),
                  );
                },
              ),
          ],
        ),
        SizedBox(height: 16),
        CoreButton(
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
      HabitForm(initial: initial),
    );

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
                  .read(habitControllerProvider.notifier)
                  .archive(habit);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      height: 140,
    );
