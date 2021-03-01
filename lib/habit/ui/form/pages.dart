import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/domain/models.dart';
import '../../../core/ui/widgets/app_bars.dart';
import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/duration.dart';
import '../../../core/ui/widgets/input.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../core/ui/widgets/time.dart';
import '../../../deps.dart';
import '../../../theme.dart';
import '../../domain/models.dart';
import 'widgets.dart';

var _error = Provider.family<String, Habit>((ref, habit) {
  if (habit.goalValue <= 0) {
    return habit.type == HabitType.repeats
        ? "Число повторений должно быть > 0"
        : "Продолжительность должна быть > 0";
  }

  return "";
});

/// Страница с формой создания/редактирования привычки
class HabitFormPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vmState = useState(ModalRoute.of(context).settings.arguments as Habit ??
        Habit(created: DateTime.now()));
    var habit = vmState.value;
    setVM(Habit newVm) => vmState.value = newVm;

    var error = useProvider(_error(habit));

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        children: [
          BiggestText(
            text: habit.isUpdate
                ? "Редактирование привычки"
                : "Создание привычки",
            withPadding: true,
          )
        ],
      ),
      body: ListView(
        children: [
          //////////////////////////////////////////////////////////////////////
          // Название
          //////////////////////////////////////////////////////////////////////
          PaddedContainerCard(
            children: [
              BiggerText(text: "Название"),
              SizedBox(height: 5),
              TextInput(
                initial: habit.title,
                change: (dynamic t) =>
                    setVM(habit.copyWith(title: t as String)),
              ),
            ],
          ),
          //////////////////////////////////////////////////////////////////////
          // Тип + продолжительность / повыторы
          //////////////////////////////////////////////////////////////////////
          // region
          PaddedContainerCard(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  BiggerText(text: "Тип"),
                  Spacer(),
                  if (habit.isUpdate) SmallerText(text: "нельзя изменить")
                ],
              ),
              SizedBox(height: 5),
              HabitTypeRadioGroup(
                initial: habit.type,
                change: (type) =>
                    setVM(habit.copyWith(type: type, goalValue: 1)),
                setBefore: habit.isUpdate,
              ),
            ],
          ),
          if (habit.type == HabitType.time)
            PaddedContainerCard(
              children: [
                BiggerText(text: "Продолжительность"),
                SizedBox(height: 5),
                DurationInput(
                  initial: DoubleDuration.fromSeconds(habit.goalValue),
                  change: (newDuration) =>
                      setVM(habit.applyDuration(newDuration)),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleButton(
                      text: "+ 1 %",
                      onTap: () => setVM(habit.increaseGoalValueByPercent()),
                    ),
                    SimpleButton(
                      text: "+ 1 сек",
                      onTap: () =>
                          setVM(habit.copyWith(goalValue: habit.goalValue + 1)),
                    ),
                    SimpleButton(
                      text: "+ 1 мин",
                      onTap: () => setVM(
                          habit.copyWith(goalValue: habit.goalValue + 1 * 60)),
                    ),
                    SimpleButton(
                      text: "+ 1 ч",
                      onTap: () => setVM(habit.copyWith(
                          goalValue: habit.goalValue + 1 * 3600)),
                    ),
                  ],
                ),
              ],
            ),
          if (habit.type == HabitType.repeats)
            PaddedContainerCard(
              children: [
                BiggerText(text: "Число повторений"),
                SizedBox(height: 5),
                TextInput<double>(
                  initial: habit.goalValue,
                  change: (dynamic v) =>
                      setVM(habit.copyWith(goalValue: v as double)),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleButton(
                      text: "+ 1 %",
                      onTap: () => setVM(habit.increaseGoalValueByPercent()),
                    ),
                    SimpleButton(
                      text: "+ 1",
                      onTap: () =>
                          setVM(habit.copyWith(goalValue: habit.goalValue + 1)),
                    ),
                    SimpleButton(
                      text: "+ 10",
                      onTap: () => setVM(
                          habit.copyWith(goalValue: habit.goalValue + 10)),
                    ),
                    SimpleButton(
                      text: "+ 100",
                      onTap: () => setVM(
                          habit.copyWith(goalValue: habit.goalValue + 100)),
                    ),
                  ],
                )
              ],
            ),
          // endregion
          //////////////////////////////////////////////////////////////////////
          // Периодичность
          //////////////////////////////////////////////////////////////////////
          // region
          PaddedContainerCard(
            children: [
              BiggerText(text: "Периодичность"),
              SizedBox(height: 5),
              Wrap(
                spacing: 10,
                children: [
                  SimpleChip(
                    text: HabitPeriodType.day.verbose(),
                    selected: !habit.isCustomPeriod &&
                        habit.periodType == HabitPeriodType.day,
                    change: (_) => setVM(
                      habit.copyWith(
                        periodType: HabitPeriodType.day,
                        isCustomPeriod: false,
                      ),
                    ),
                  ),
                  SimpleChip(
                    text: HabitPeriodType.week.verbose(),
                    selected: !habit.isCustomPeriod &&
                        habit.periodType == HabitPeriodType.week,
                    change: (_) => setVM(
                      habit.copyWith(
                        periodType: HabitPeriodType.week,
                        isCustomPeriod: false,
                      ),
                    ),
                  ),
                  SimpleChip(
                    text: HabitPeriodType.month.verbose(),
                    selected: !habit.isCustomPeriod &&
                        habit.periodType == HabitPeriodType.month,
                    change: (_) => setVM(
                      habit.copyWith(
                        periodType: HabitPeriodType.month,
                        isCustomPeriod: false,
                      ),
                    ),
                  ),
                  SimpleChip(
                    text: "Другая",
                    selected: habit.isCustomPeriod,
                    change: (_) => setVM(
                      habit.copyWith(isCustomPeriod: true),
                    ),
                  ),
                ],
              ),
              if (habit.isCustomPeriod)
                Column(children: [
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Flexible(
                          child: TextInput<int>(
                        initial: habit.periodValue,
                        change: (dynamic v) => setVM(
                          habit.copyWith(periodValue: v as int),
                        ),
                      )),
                      SizedBox(width: 10),
                      Expanded(
                        child: HabitPeriodTypeSelect(
                          initial: habit.periodType,
                          change: (t) => setVM(habit.copyWith(periodType: t)),
                        ),
                        flex: 3,
                      )
                    ],
                  ),
                ]),
              if (habit.periodType == HabitPeriodType.week)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    BiggerText(text: "Дни выполнения"),
                    SizedBox(height: 5),
                    WeekdaysPicker(
                      initial: habit.performWeekdays,
                      change: (ws) =>
                          setVM(habit.copyWith(performWeekdays: ws)),
                    )
                  ],
                ),
              if (habit.periodType == HabitPeriodType.month)
                Column(
                  children: [
                    SizedBox(height: 5),
                    Row(
                      children: [
                        BiggerText(text: "День выполнения"),
                        Spacer(),
                        SmallerText(text: "1 .. 31"),
                      ],
                    ),
                    SizedBox(height: 5),
                    TextInput<int>(
                      initial: habit.performMonthDay,
                      change: (dynamic d) =>
                          setVM(habit.copyWith(performMonthDay: d as int)),
                    ),
                  ],
                ),
            ],
          ),

          // endregion

          //////////////////////////////////////////////////////////////////////
          // Время выполнения
          //////////////////////////////////////////////////////////////////////

          PaddedContainerCard(
            children: [
              BiggerText(text: "Время выполнения"),
              SizedBox(height: 5),
              TimePickerInput(
                initial: habit.performTime,
                change: (time) => setVM(habit.copyWith(performTime: time)),
              ),
              if (habit.performTime != null)
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: BiggerText(
                    text: "Отправить уведомление перед выполнением?",
                  ),
                  value: habit.isNotificationsEnabled,
                  onChanged: (isNotificationsEnabled) => setVM(
                    habit.copyWith(
                        isNotificationsEnabled: isNotificationsEnabled),
                  ),
                  checkColor: CustomColors.almostBlack,
                )
            ],
          ),

          //////////////////////////////////////////////////////////////////////
          // Воздух, чтобы кнопка "Сохранить" не перекрывала последний инпут
          //////////////////////////////////////////////////////////////////////
          SizedBox(height: 60)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: FloatingActionButton.extended(
            onPressed: error.isEmpty
                ? () async {
                    var createdHabit = await context
                        .read(habitControllerProvider)
                        .createOrUpdateHabit(habit);
                    Navigator.of(context).pop(createdHabit);
                  }
                : null,
            label: SmallerText(
                text: error.isEmpty ? "Сохранить" : error, dark: true),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: CustomColors.yellow,
            foregroundColor: CustomColors.almostBlack,
          ),
        ),
      ),
    );
  }
}
