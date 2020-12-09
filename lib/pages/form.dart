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

    var vm = useState(
      Get.arguments != null
          ? repo.get(Get.arguments as int)
          : Habit(habitPeriod: HabitPeriod()),
    ).value;

    return Scaffold(
      body: ListView(
        children: [
          PaddedContainerCard(
            children: [
              BiggerText(text: "Название"),
              SizedBox(height: 5),
              TextInput(
                initial: vm.title,
                change: (dynamic t) => vm = vm.copyWith(title: t as String),
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
                change: (type) => vm = vm.copyWith(type: type, goalValue: 0),
                setBefore: vm.isUpdate,
              ),
              HabitRepeatDuringDayCheckbox(
                initial: vm.dailyRepeatsEnabled,
                change: (selected) =>
                    vm = vm.copyWith(dailyRepeatsEnabled: selected),
              )
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
                            vm.setGoalValueHours(h as double),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextInput<double>(
                        suffix: Text("мин", textAlign: TextAlign.center),
                        initial: vm.goalValueMinutes,
                        change: (dynamic m) =>
                            vm.setGoalValueMinutes(m as double),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextInput<double>(
                        suffix: Text("сек", textAlign: TextAlign.center),
                        initial: vm.goalValueSeconds,
                        change: (dynamic s) =>
                            vm.setGoalValueSeconds(s as double),
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
                      onTap: () => vm.increaseGoalValueByPercent(),
                    ),
                    SimpleButton(
                      text: "+ 1 сек",
                      onTap: () =>
                          vm = vm.copyWith(goalValue: vm.goalValue + 1),
                    ),
                    SimpleButton(
                      text: "+ 1 мин",
                      onTap: () =>
                          vm = vm.copyWith(goalValue: vm.goalValue + 1 * 60),
                    ),
                    SimpleButton(
                      text: "+ 1 ч",
                      onTap: () =>
                          vm = vm.copyWith(goalValue: vm.goalValue + 1 * 3600),
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
                      vm = vm.copyWith(goalValue: v as double),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleButton(
                      text: "+ 1 %",
                      onTap: () => vm.increaseGoalValueByPercent(),
                    ),
                    SimpleButton(
                      text: "+ 1",
                      onTap: () =>
                          vm = vm.copyWith(goalValue: vm.goalValue + 1),
                    ),
                    SimpleButton(
                      text: "+ 10",
                      onTap: () =>
                          vm = vm.copyWith(goalValue: vm.goalValue + 10),
                    ),
                    SimpleButton(
                      text: "+ 100",
                      onTap: () =>
                          vm = vm.copyWith(goalValue: vm.goalValue + 100),
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
                      vm = vm.copyWith(dailyRepeats: r as double),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleButton(
                      text: "+ 1 %",
                      onTap: () => vm.increaseDailyRepeatsByPercent(),
                    ),
                    SimpleButton(
                      text: "+ 1",
                      onTap: () =>
                          vm = vm.copyWith(dailyRepeats: vm.dailyRepeats + 1),
                    ),
                    SimpleButton(
                      text: "+ 10",
                      onTap: () =>
                          vm = vm.copyWith(dailyRepeats: vm.dailyRepeats + 10),
                    ),
                    SimpleButton(
                      text: "+ 100",
                      onTap: () =>
                          vm = vm.copyWith(dailyRepeats: vm.dailyRepeats + 100),
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
                    selected: !vm.habitPeriod.isCustom &&
                        vm.habitPeriod.type == HabitPeriodType.day,
                    change: (_) => vm = vm.copyWith(
                      habitPeriod: vm.habitPeriod
                          .copyWith(type: HabitPeriodType.day, isCustom: false),
                    ),
                  ),
                  SimpleChip(
                    text: "Еженедельная",
                    selected: !vm.habitPeriod.isCustom &&
                        vm.habitPeriod.type == HabitPeriodType.week,
                    change: (_) => vm = vm.copyWith(
                      habitPeriod: vm.habitPeriod.copyWith(
                          type: HabitPeriodType.week, isCustom: false),
                    ),
                  ),
                  SimpleChip(
                    text: "Ежемесячная",
                    selected: !vm.habitPeriod.isCustom &&
                        vm.habitPeriod.type == HabitPeriodType.month,
                    change: (_) => vm = vm.copyWith(
                      habitPeriod: vm.habitPeriod.copyWith(
                          type: HabitPeriodType.month, isCustom: false),
                    ),
                  ),
                  SimpleChip(
                    text: "Другая",
                    selected: vm.habitPeriod.isCustom,
                    change: (_) => vm = vm.copyWith(
                      habitPeriod: vm.habitPeriod.copyWith(isCustom: true),
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
                      change: (dynamic v) => vm = vm.copyWith(
                          habitPeriod:
                              vm.habitPeriod.copyWith(periodValue: v as int)),
                    )),
                    SizedBox(width: 10),
                    Expanded(
                      child: HabitPeriodTypeSelect(
                        initial: vm.habitPeriod.type,
                        change: (t) => vm = vm.copyWith(
                            habitPeriod: vm.habitPeriod.copyWith(type: t)),
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
                  change: (ws) => vm = vm.copyWith(
                      habitPeriod: vm.habitPeriod.copyWith(weekdays: ws)),
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
                  change: (dynamic d) => vm = vm.copyWith(
                      habitPeriod: vm.habitPeriod.copyWith(monthDay: d as int)),
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
              if (vm.isUpdate) {
                await context.read(habitRepoProvider).update(vm);
              } else {
                await context.read(habitRepoProvider).insert(vm);
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
