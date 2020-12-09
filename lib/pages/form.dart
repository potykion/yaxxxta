import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../deps.dart';
import '../models.dart';
import '../routes.dart';
import '../theme.dart';
import '../widgets.dart';

/// Страница с формой создания/редактирования привычки
class HabitFormPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var repo = useProvider(habitRepoProvider);

    final vm = useState(
      Get.arguments != null
          ? repo.get(Get.arguments as int)
          : Habit(habitPeriod: HabitPeriod()),
    );

    return Scaffold(
      body: ListView(
        children: [
          PaddedContainerCard(
            children: [
              BiggerText(text: "Название"),
              SizedBox(height: 5),
              TextInput(
                initial: vm.value.title,
                change: (dynamic t) =>
                    vm.value = vm.value.copyWith(title: t as String),
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
                  if (vm.value.isUpdate) SmallerText(text: "нельзя изменить")
                ],
              ),
              SizedBox(height: 5),
              HabitTypeRadioGroup(
                initial: vm.value.type,
                change: (type) =>
                    vm.value = vm.value.copyWith(type: type, goalValue: 0),
                setBefore: vm.value.isUpdate,
              ),
              HabitRepeatDuringDayCheckbox(
                initial: vm.value.dailyRepeatsEnabled,
                change: (selected) =>
                    vm.value = vm.value.copyWith(dailyRepeatsEnabled: selected),
              )
            ],
          ),
          if (vm.value.type == HabitType.time)
            PaddedContainerCard(
              children: [
                BiggerText(text: "Продолжительность"),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: TextInput<double>(
                        suffix: Text("ч", textAlign: TextAlign.center),
                        initial: vm.value.goalValueHours,
                        change: (dynamic h) =>
                            vm.value = vm.value.setGoalValueHours(h as double),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextInput<double>(
                        suffix: Text("мин", textAlign: TextAlign.center),
                        initial: vm.value.goalValueMinutes,
                        change: (dynamic m) => vm.value =
                            vm.value.setGoalValueMinutes(m as double),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextInput<double>(
                        suffix: Text("сек", textAlign: TextAlign.center),
                        initial: vm.value.goalValueSeconds,
                        change: (dynamic s) => vm.value =
                            vm.value.setGoalValueSeconds(s as double),
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
                      onTap: () =>
                          vm.value = vm.value.increaseGoalValueByPercent(),
                    ),
                    SimpleButton(
                      text: "+ 1 сек",
                      onTap: () => vm.value =
                          vm.value.copyWith(goalValue: vm.value.goalValue + 1),
                    ),
                    SimpleButton(
                      text: "+ 1 мин",
                      onTap: () => vm.value = vm.value
                          .copyWith(goalValue: vm.value.goalValue + 1 * 60),
                    ),
                    SimpleButton(
                      text: "+ 1 ч",
                      onTap: () => vm.value = vm.value
                          .copyWith(goalValue: vm.value.goalValue + 1 * 3600),
                    ),
                  ],
                ),
              ],
            ),
          if (vm.value.type == HabitType.repeats)
            PaddedContainerCard(
              children: [
                BiggerText(text: "Число повторений за раз"),
                SizedBox(height: 5),
                TextInput<double>(
                  initial: vm.value.goalValue,
                  change: (dynamic v) =>
                      vm.value = vm.value.copyWith(goalValue: v as double),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleButton(
                      text: "+ 1 %",
                      onTap: () =>
                          vm.value = vm.value.increaseGoalValueByPercent(),
                    ),
                    SimpleButton(
                      text: "+ 1",
                      onTap: () => vm.value =
                          vm.value.copyWith(goalValue: vm.value.goalValue + 1),
                    ),
                    SimpleButton(
                      text: "+ 10",
                      onTap: () => vm.value =
                          vm.value.copyWith(goalValue: vm.value.goalValue + 10),
                    ),
                    SimpleButton(
                      text: "+ 100",
                      onTap: () => vm.value = vm.value
                          .copyWith(goalValue: vm.value.goalValue + 100),
                    ),
                  ],
                )
              ],
            ),
          if (vm.value.dailyRepeatsEnabled)
            PaddedContainerCard(
              children: [
                BiggerText(text: "Число повторений за день"),
                SizedBox(height: 5),
                TextInput<double>(
                  initial: vm.value.dailyRepeats,
                  change: (dynamic r) =>
                      vm.value = vm.value.copyWith(dailyRepeats: r as double),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleButton(
                      text: "+ 1 %",
                      onTap: () => vm.value.increaseDailyRepeatsByPercent(),
                    ),
                    SimpleButton(
                      text: "+ 1",
                      onTap: () => vm.value = vm.value
                          .copyWith(dailyRepeats: vm.value.dailyRepeats + 1),
                    ),
                    SimpleButton(
                      text: "+ 10",
                      onTap: () => vm.value = vm.value
                          .copyWith(dailyRepeats: vm.value.dailyRepeats + 10),
                    ),
                    SimpleButton(
                      text: "+ 100",
                      onTap: () => vm.value = vm.value
                          .copyWith(dailyRepeats: vm.value.dailyRepeats + 100),
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
                    text: "Ежедневная",
                    selected: !vm.value.habitPeriod.isCustom &&
                        vm.value.habitPeriod.type == HabitPeriodType.day,
                    change: (_) => vm.value = vm.value.copyWith(
                      habitPeriod: vm.value.habitPeriod
                          .copyWith(type: HabitPeriodType.day, isCustom: false),
                    ),
                  ),
                  SimpleChip(
                    text: "Еженедельная",
                    selected: !vm.value.habitPeriod.isCustom &&
                        vm.value.habitPeriod.type == HabitPeriodType.week,
                    change: (_) => vm.value = vm.value.copyWith(
                      habitPeriod: vm.value.habitPeriod.copyWith(
                          type: HabitPeriodType.week, isCustom: false),
                    ),
                  ),
                  SimpleChip(
                    text: "Ежемесячная",
                    selected: !vm.value.habitPeriod.isCustom &&
                        vm.value.habitPeriod.type == HabitPeriodType.month,
                    change: (_) => vm.value = vm.value.copyWith(
                      habitPeriod: vm.value.habitPeriod.copyWith(
                          type: HabitPeriodType.month, isCustom: false),
                    ),
                  ),
                  SimpleChip(
                    text: "Другая",
                    selected: vm.value.habitPeriod.isCustom,
                    change: (_) => vm.value = vm.value.copyWith(
                      habitPeriod:
                          vm.value.habitPeriod.copyWith(isCustom: true),
                    ),
                  ),
                ],
              )
            ],
          ),
          if (vm.value.habitPeriod.isCustom)
            PaddedContainerCard(
              children: [
                BiggerText(text: "Периодичность"),
                SizedBox(height: 5),
                Row(
                  children: [
                    Flexible(
                        child: TextInput<int>(
                      initial: vm.value.habitPeriod.periodValue,
                      change: (dynamic v) => vm.value = vm.value.copyWith(
                          habitPeriod: vm.value.habitPeriod
                              .copyWith(periodValue: v as int)),
                    )),
                    SizedBox(width: 10),
                    Expanded(
                      child: HabitPeriodTypeSelect(
                        initial: vm.value.habitPeriod.type,
                        change: (t) => vm.value = vm.value.copyWith(
                            habitPeriod:
                                vm.value.habitPeriod.copyWith(type: t)),
                      ),
                      flex: 3,
                    )
                  ],
                ),
              ],
            ),
          if (vm.value.habitPeriod.type == HabitPeriodType.week)
            PaddedContainerCard(
              children: [
                BiggerText(text: "Дни выполнения"),
                SizedBox(height: 5),
                WeekdaysPicker(
                  initial: vm.value.habitPeriod.weekdays,
                  change: (ws) => vm.value = vm.value.copyWith(
                      habitPeriod: vm.value.habitPeriod.copyWith(weekdays: ws)),
                )
              ],
            ),
          if (vm.value.habitPeriod.type == HabitPeriodType.month)
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
                  initial: vm.value.habitPeriod.monthDay,
                  change: (dynamic d) => vm.value = vm.value.copyWith(
                      habitPeriod:
                          vm.value.habitPeriod.copyWith(monthDay: d as int)),
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
            onPressed: () async {
              if (vm.value.isUpdate) {
                await context.read(habitRepoProvider).update(vm.value);
              } else {
                await context.read(habitRepoProvider).insert(vm.value);
              }
              Navigator.of(context).pushNamed(Routes.list);
            },
            label: SmallerText(text: "Сохранить", dark: true),
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
