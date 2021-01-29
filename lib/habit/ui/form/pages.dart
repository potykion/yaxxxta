import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/input.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../core/ui/widgets/time.dart';
import '../../../theme.dart';
import '../../domain/models.dart';
import '../core/deps.dart';
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
    var vm = vmState.value;
    setVm(Habit newVm) => vmState.value = newVm;

    var error = useProvider(_error(vm));

    return Scaffold(
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
                initial: vm.title,
                change: (dynamic t) => setVm(vm.copyWith(title: t as String)),
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
                  if (vm.isUpdate) SmallerText(text: "нельзя изменить")
                ],
              ),
              SizedBox(height: 5),
              HabitTypeRadioGroup(
                initial: vm.type,
                change: (type) => setVm(vm.copyWith(type: type, goalValue: 1)),
                setBefore: vm.isUpdate,
              ),
            ],
          ),
          if (vm.type == HabitType.time)
            PaddedContainerCard(
              children: [
                BiggerText(text: "Продолжительность"),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: TextInput<double>(
                        suffix: Text("ч", textAlign: TextAlign.center),
                        initial: vm.goalValueHours,
                        change: (dynamic h) =>
                            setVm(vm.setGoalValueHours(h as double)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextInput<double>(
                        suffix: Text("мин", textAlign: TextAlign.center),
                        initial: vm.goalValueMinutes,
                        change: (dynamic m) =>
                            setVm(vm.setGoalValueMinutes(m as double)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextInput<double>(
                        suffix: Text("сек", textAlign: TextAlign.center),
                        initial: vm.goalValueSeconds,
                        change: (dynamic s) =>
                            setVm(vm.setGoalValueSeconds(s as double)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleButton(
                      text: "+ 1 %",
                      onTap: () => setVm(vm.increaseGoalValueByPercent()),
                    ),
                    SimpleButton(
                      text: "+ 1 сек",
                      onTap: () =>
                          setVm(vm.copyWith(goalValue: vm.goalValue + 1)),
                    ),
                    SimpleButton(
                      text: "+ 1 мин",
                      onTap: () =>
                          setVm(vm.copyWith(goalValue: vm.goalValue + 1 * 60)),
                    ),
                    SimpleButton(
                      text: "+ 1 ч",
                      onTap: () => setVm(
                          vm.copyWith(goalValue: vm.goalValue + 1 * 3600)),
                    ),
                  ],
                ),
              ],
            ),
          if (vm.type == HabitType.repeats)
            PaddedContainerCard(
              children: [
                BiggerText(text: "Число повторений"),
                SizedBox(height: 5),
                TextInput<double>(
                  initial: vm.goalValue,
                  change: (dynamic v) =>
                      setVm(vm.copyWith(goalValue: v as double)),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleButton(
                      text: "+ 1 %",
                      onTap: () => setVm(vm.increaseGoalValueByPercent()),
                    ),
                    SimpleButton(
                      text: "+ 1",
                      onTap: () =>
                          setVm(vm.copyWith(goalValue: vm.goalValue + 1)),
                    ),
                    SimpleButton(
                      text: "+ 10",
                      onTap: () =>
                          setVm(vm.copyWith(goalValue: vm.goalValue + 10)),
                    ),
                    SimpleButton(
                      text: "+ 100",
                      onTap: () =>
                          setVm(vm.copyWith(goalValue: vm.goalValue + 100)),
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
                    selected: !vm.isCustomPeriod &&
                        vm.periodType == HabitPeriodType.day,
                    change: (_) => setVm(
                      vm.copyWith(
                        periodType: HabitPeriodType.day,
                        isCustomPeriod: false,
                      ),
                    ),
                  ),
                  SimpleChip(
                    text: HabitPeriodType.week.verbose(),
                    selected: !vm.isCustomPeriod &&
                        vm.periodType == HabitPeriodType.week,
                    change: (_) => setVm(
                      vm.copyWith(
                        periodType: HabitPeriodType.week,
                        isCustomPeriod: false,
                      ),
                    ),
                  ),
                  SimpleChip(
                    text: HabitPeriodType.month.verbose(),
                    selected: !vm.isCustomPeriod &&
                        vm.periodType == HabitPeriodType.month,
                    change: (_) => setVm(
                      vm.copyWith(
                        periodType: HabitPeriodType.month,
                        isCustomPeriod: false,
                      ),
                    ),
                  ),
                  SimpleChip(
                    text: "Другая",
                    selected: vm.isCustomPeriod,
                    change: (_) => setVm(
                      vm.copyWith(isCustomPeriod: true),
                    ),
                  ),
                ],
              )
            ],
          ),
          if (vm.isCustomPeriod)
            PaddedContainerCard(
              children: [
                BiggerText(text: "Периодичность"),
                SizedBox(height: 5),
                Row(
                  children: [
                    Flexible(
                        child: TextInput<int>(
                      initial: vm.periodValue,
                      change: (dynamic v) => setVm(
                        vm.copyWith(periodValue: v as int),
                      ),
                    )),
                    SizedBox(width: 10),
                    Expanded(
                      child: HabitPeriodTypeSelect(
                        initial: vm.periodType,
                        change: (t) => setVm(vm.copyWith(periodType: t)),
                      ),
                      flex: 3,
                    )
                  ],
                ),
              ],
            ),
          if (vm.periodType == HabitPeriodType.week)
            PaddedContainerCard(
              children: [
                BiggerText(text: "Дни выполнения"),
                SizedBox(height: 5),
                WeekdaysPicker(
                  initial: vm.performWeekdays,
                  change: (ws) => setVm(vm.copyWith(performWeekdays: ws)),
                )
              ],
            ),
          if (vm.periodType == HabitPeriodType.month)
            PaddedContainerCard(
              children: [
                Row(
                  children: [
                    BiggerText(text: "День выполнения"),
                    Spacer(),
                    SmallerText(text: "1 .. 31"),
                  ],
                ),
                SizedBox(height: 5),
                TextInput<int>(
                  initial: vm.performMonthDay,
                  change: (dynamic d) =>
                      setVm(vm.copyWith(performMonthDay: d as int)),
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
                initial: vm.performTime,
                change: (time) => setVm(
                  vm.copyWith(performTime: time),
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
                    var habit = await context
                        .read(habitControllerProvider)
                        .createOrUpdateHabit(vm);
                    Navigator.of(context).pop(habit);
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
