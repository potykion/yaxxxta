import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/widgets/habit/habit_type_radio_group.dart';

import '../logic/core/models.dart';
import '../theme.dart';
import '../widgets/core/app_bars.dart';
import '../widgets/core/card.dart';
import '../widgets/core/duration.dart';
import '../widgets/core/input.dart';
import '../widgets/core/padding.dart';
import '../widgets/core/text.dart';
import '../widgets/core/time.dart';

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
    var vmState = useState(
      ModalRoute.of(context)!.settings.arguments as Habit? ?? Habit.blank(),
    );
    var habit = vmState.value;
    setVM(Habit newVm) => vmState.value = newVm;

    var error = useProvider(_error(habit));

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        children: [
          BackButton(),
          BiggestText(
            text: habit.isUpdate
                ? "Редактирование привычки"
                : "Создание привычки",
          )
        ],
      ),
      body: ListView(
        children: [
          //////////////////////////////////////////////////////////////////////
          // Название
          //////////////////////////////////////////////////////////////////////
          ContainerCard(
            children: [
              ListTile(
                title: BiggerText(text: "Название"),
                dense: true,
              ),
              SmallPadding(
                child: TextInput(
                  initial: habit.title,
                  change: (dynamic t) =>
                      setVM(habit.copyWith(title: t as String)),
                ),
              ),
            ],
          ),
          //////////////////////////////////////////////////////////////////////
          // Тип + продолжительность / повыторы
          //////////////////////////////////////////////////////////////////////
          // region
          ContainerCard(
            children: [
              ListTile(
                title: BiggerText(text: "Тип"),
                trailing: habit.isUpdate
                    ? SmallerText(text: "нельзя изменить")
                    : null,
                dense: true,
              ),
              SmallPadding(
                child: HabitTypeRadioGroup(
                  initial: habit.type,
                  change: (type) =>
                      setVM(habit.copyWith(type: type, goalValue: 1)),
                  setBefore: habit.isUpdate,
                ),
              ),
            ],
          ),
          if (habit.type == HabitType.time)
            ContainerCard(
              children: [
                ListTile(
                  title: BiggerText(text: "Продолжительность"),
                  dense: true,
                ),
                SmallPadding(
                  child: DurationInput(
                    initial: DoubleDuration.fromSeconds(habit.goalValue),
                    change: (newDuration) =>
                        setVM(habit.applyDuration(newDuration)),
                  ),
                ),
                // todo extract to component
                SmallPadding(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SimpleButton(
                        text: "+ 1 %",
                        onTap: () => setVM(habit.increaseGoalValueByPercent()),
                      ),
                      SimpleButton(
                        text: "+ 1 сек",
                        onTap: () => setVM(
                            habit.copyWith(goalValue: habit.goalValue + 1)),
                      ),
                      SimpleButton(
                        text: "+ 1 мин",
                        onTap: () => setVM(habit.copyWith(
                            goalValue: habit.goalValue + 1 * 60)),
                      ),
                      SimpleButton(
                        text: "+ 1 ч",
                        onTap: () => setVM(habit.copyWith(
                            goalValue: habit.goalValue + 1 * 3600)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          if (habit.type == HabitType.repeats)
            ContainerCard(
              children: [
                ListTile(
                  title: BiggerText(text: "Число повторений"),
                  dense: true,
                ),
                SmallPadding(
                  child: TextInput<double>(
                    initial: habit.goalValue,
                    change: (dynamic v) =>
                        setVM(habit.copyWith(goalValue: v as double)),
                  ),
                ),
                SmallPadding(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SimpleButton(
                        text: "+ 1 %",
                        onTap: () => setVM(habit.increaseGoalValueByPercent()),
                      ),
                      SimpleButton(
                        text: "+ 1",
                        onTap: () => setVM(
                            habit.copyWith(goalValue: habit.goalValue + 1)),
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
                  ),
                )
              ],
            ),
          // endregion
          //////////////////////////////////////////////////////////////////////
          // Периодичность
          //////////////////////////////////////////////////////////////////////
          // region
          ContainerCard(
            children: [
              ListTile(
                title: BiggerText(text: "Периодичность"),
                dense: true,
              ),
              SmallPadding(
                child: Wrap(
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
              ),
              if (habit.isCustomPeriod)
                SmallPadding(
                  child: Row(
                    children: [
                      Flexible(
                          child: TextInput<int>(
                        initial: habit.periodValue,
                        change: (dynamic v) => setVM(
                          habit.copyWith(periodValue: v as int),
                        ),
                      )),
                      SmallPadding.between(),
                      Expanded(
                        child: HabitPeriodTypeSelect(
                          initial: habit.periodType,
                          change: (t) => setVM(habit.copyWith(periodType: t)),
                        ),
                        flex: 3,
                      )
                    ],
                  ),
                ),
              if (habit.periodType == HabitPeriodType.week)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: BiggerText(text: "Дни выполнения"),
                      dense: true,
                    ),
                    SmallPadding(
                      child: WeekdaysPicker(
                        initial: habit.performWeekdays,
                        change: (ws) => setVM(
                          habit.copyWith(performWeekdays: ws),
                        ),
                      ),
                    )
                  ],
                ),
              if (habit.periodType == HabitPeriodType.month)
                Column(
                  children: [
                    ListTile(
                      title: BiggerText(text: "День выполнения"),
                      dense: true,
                      trailing: SmallerText(text: "1 .. 31"),
                    ),
                    SmallPadding(
                      child: TextInput<int>(
                        initial: habit.performMonthDay,
                        change: (dynamic d) =>
                            setVM(habit.copyWith(performMonthDay: d as int)),
                      ),
                    ),
                  ],
                ),
            ],
          ),

          // endregion

          //////////////////////////////////////////////////////////////////////
          // Время выполнения
          //////////////////////////////////////////////////////////////////////

          ContainerCard(
            children: [
              ListTile(
                title: BiggerText(text: "Время выполнения"),
                dense: true,
                trailing: habit.performTime != null
                    ? IconButton(
                        onPressed: () =>
                            setVM(habit.copyWith(performTime: null)),
                        icon: Icon(Icons.close),
                      )
                    : null,
              ),
              SmallPadding(
                child: TimePickerInput(
                  initial: habit.performTime,
                  change: (time) => setVM(habit.copyWith(performTime: time)),
                ),
              ),
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
                        .createOrUpdate(habit);
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
