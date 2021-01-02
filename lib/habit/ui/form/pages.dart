import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/habit/ui/core/deps.dart';
import 'package:yaxxxta/habit/ui/form/widgets.dart';

import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/input.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../theme.dart';
import '../../domain/models.dart';

var _vmProvider = StateProvider.autoDispose(
  (ref) =>
      Get.arguments as Habit ??
      Habit(habitPeriod: HabitPeriod(), created: DateTime.now()),
);

var _error = Provider.autoDispose((ref) {
  var habit = ref.watch(_vmProvider).state;

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
    var vmState = useProvider(_vmProvider);
    var vm = vmState.state;

    setVm(Habit newVm) => context.read(_vmProvider).state = newVm;

    var error = useProvider(_error);

    return Scaffold(
      body: ListView(
        children: [
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
          PaddedContainerCard(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
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
              SelectableCheckbox(
                initial: vm.dailyRepeatsEnabled,
                change: (selected) =>
                    setVm(vm.copyWith(dailyRepeatsEnabled: selected)),
                biggerText: "Повторы в течение дня",
                smallerText: "Например, 10 мин. 2 раза в день",
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
                BiggerText(text: "Число повторений за раз"),
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
          if (vm.dailyRepeatsEnabled)
            PaddedContainerCard(
              children: [
                BiggerText(text: "Число повторений за день"),
                SizedBox(height: 5),
                TextInput<double>(
                  initial: vm.dailyRepeats,
                  change: (dynamic r) =>
                      setVm(vm.copyWith(dailyRepeats: r as double)),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleButton(
                      text: "+ 1 %",
                      onTap: () => setVm(vm.increaseDailyRepeatsByPercent()),
                    ),
                    SimpleButton(
                      text: "+ 1",
                      onTap: () =>
                          setVm(vm.copyWith(dailyRepeats: vm.dailyRepeats + 1)),
                    ),
                    SimpleButton(
                      text: "+ 10",
                      onTap: () => setVm(
                          vm.copyWith(dailyRepeats: vm.dailyRepeats + 10)),
                    ),
                    SimpleButton(
                      text: "+ 100",
                      onTap: () => setVm(
                          vm.copyWith(dailyRepeats: vm.dailyRepeats + 100)),
                    ),
                  ],
                )
              ],
            ),
          PaddedContainerCard(
            children: [
              BiggerText(text: "Периодичность"),
              SizedBox(height: 5),
              Wrap(
                spacing: 10,
                children: [
                  SimpleChip(
                    text: vm.habitPeriod.type.verbose(),
                    selected: !vm.habitPeriod.isCustom &&
                        vm.habitPeriod.type == HabitPeriodType.day,
                    change: (_) => setVm(
                      vm.copyWith(
                          habitPeriod: vm.habitPeriod.copyWith(
                              type: HabitPeriodType.day, isCustom: false)),
                    ),
                  ),
                  SimpleChip(
                    text: vm.habitPeriod.type.verbose(),
                    selected: !vm.habitPeriod.isCustom &&
                        vm.habitPeriod.type == HabitPeriodType.week,
                    change: (_) => setVm(
                      vm.copyWith(
                          habitPeriod: vm.habitPeriod.copyWith(
                              type: HabitPeriodType.week, isCustom: false)),
                    ),
                  ),
                  SimpleChip(
                    text: vm.habitPeriod.type.verbose(),
                    selected: !vm.habitPeriod.isCustom &&
                        vm.habitPeriod.type == HabitPeriodType.month,
                    change: (_) => setVm(
                      vm.copyWith(
                          habitPeriod: vm.habitPeriod.copyWith(
                              type: HabitPeriodType.month, isCustom: false)),
                    ),
                  ),
                  SimpleChip(
                    text: "Другая",
                    selected: vm.habitPeriod.isCustom,
                    change: (_) => setVm(
                      vm.copyWith(
                          habitPeriod: vm.habitPeriod.copyWith(isCustom: true)),
                    ),
                  ),
                ],
              )
            ],
          ),
          if (vm.habitPeriod.isCustom)
            PaddedContainerCard(
              children: [
                BiggerText(text: "Периодичность"),
                SizedBox(height: 5),
                Row(
                  children: [
                    Flexible(
                        child: TextInput<int>(
                      initial: vm.habitPeriod.periodValue,
                      change: (dynamic v) => setVm(
                        vm.copyWith(
                            habitPeriod:
                                vm.habitPeriod.copyWith(periodValue: v as int)),
                      ),
                    )),
                    SizedBox(width: 10),
                    Expanded(
                      child: HabitPeriodTypeSelect(
                        initial: vm.habitPeriod.type,
                        change: (t) => setVm(vm.copyWith(
                            habitPeriod: vm.habitPeriod.copyWith(type: t))),
                      ),
                      flex: 3,
                    )
                  ],
                ),
              ],
            ),
          if (vm.habitPeriod.type == HabitPeriodType.week)
            PaddedContainerCard(
              children: [
                BiggerText(text: "Дни выполнения"),
                SizedBox(height: 5),
                WeekdaysPicker(
                  initial: vm.habitPeriod.weekdays,
                  change: (ws) => setVm(vm.copyWith(
                      habitPeriod: vm.habitPeriod.copyWith(weekdays: ws))),
                )
              ],
            ),
          if (vm.habitPeriod.type == HabitPeriodType.month)
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
                  initial: vm.habitPeriod.monthDay,
                  change: (dynamic d) => setVm(vm.copyWith(
                      habitPeriod:
                          vm.habitPeriod.copyWith(monthDay: d as int))),
                ),
              ],
            ),
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
                    await context
                        .read(habitControllerProvider)
                        .createOrUpdateHabit(vm);
                    Navigator.of(context).pop();
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
