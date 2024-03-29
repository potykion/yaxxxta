import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';

import 'package:yaxxxta/ui/core/button.dart';

/// Инпут напоминалки о привычки
class HabitNotificationInput extends StatelessWidget {
  /// Привычка
  final Habit habit;

  /// Событие установки напоминалки
  final void Function(DateTime atDatetime) setNotification;

  /// Событие удаления напоминалки
  final void Function() removeNotification;

  /// Инпут напоминалки о привычки
  const HabitNotificationInput({
    Key? key,
    required this.habit,
    required this.setNotification,
    required this.removeNotification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return habit.notification != null
        ? TextFormField(
            readOnly: true,
            controller: TextEditingController(
              text: habit.notification!.toTimeStr(),
            ),
            onTap: () {
              _setNotification(context, habit);
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: removeNotification,
                icon: Icon(
                  Icons.clear,
                  color: Color(0xff272343),
                ),
              ),
            ),
          )
        : CoreButton(
            text: "Добавить",
            icon: Icons.notifications,
            onPressed: () {
              _setNotification(context, habit);
            },
          );
  }

  Future _setNotification(BuildContext context, Habit habit) async {
    var time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        habit.notification?.time ?? DateTime.now(),
      ),
      cancelText: "Отмена",
      confirmText: "Ок",
      helpText: "Выбери время напоминалки",
    );
    if (time == null) return;
    var atDatetime = time.toDateTime(weekday: habit.performWeekday);
    setNotification(atDatetime);
  }
}
