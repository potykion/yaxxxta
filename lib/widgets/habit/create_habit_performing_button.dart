import 'package:flutter/material.dart';
import 'package:yaxxxta/logic/core/utils/dt.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme.dart';
import 'habit_performing_form_modal.dart';

/// Кнопка, открывающая форму создания выполнения привычки
class CreateHabitPerformingButton extends StatelessWidget {
  /// Привычка
  final Habit habit;

  /// Дата выполнения
  final DateTime initialDate;

  /// Кнопка, открывающая форму создания выполнения привычки
  const CreateHabitPerformingButton({
    Key? key,
    required this.habit,
    required this.initialDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add, color: CustomColors.almostBlack),
      onPressed: () async {
        var habitPerforming = await showModalBottomSheet<HabitPerforming>(
          context: context,
          builder: (context) => HabitPerformingFormModal(
            initialHabitPerforming: HabitPerforming.blank(
              habitId: habit.id!,
              performDateTime: buildDateTime(
                initialDate,
                DateTime.now(),
              ),
            ),
            habitType: habit.type,
          ),
        );
        if (habitPerforming != null) {
          await context.read(habitPerformingController).insert(habit, habitPerforming);
        }
      },
    );
  }
}
