import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../db.dart';
import '../models.dart';
import '../routes.dart';
import '../theme.dart';
import '../widgets.dart';

/// Страница с формой создания/редактирования привычки
class HabitFormPage extends StatefulWidget {
  @override
  _HabitFormPageState createState() => _HabitFormPageState();
}

class _HabitFormPageState extends State<HabitFormPage> {
  Habit vm;

  @override
  void initState() {
    super.initState();
    vm = Get.arguments != null
        ? Get.find<HabitRepo>().get(Get.arguments as int)
        : Habit();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView(
          children: [
            PaddedContainerCard(
              children: [
                BiggerText(text: "Название"),
                SizedBox(height: 5),
                TextInput(
                  initial: vm.title,
                  change: (dynamic t) => setState(() => vm.title = t as String),
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
                  change: (type) => setState(() {
                    vm.type = type;
                    vm.goalValue = 0;
                  }),
                  setBefore: vm.isUpdate,
                ),
                HabitRepeatDuringDayCheckbox(
                  initial: vm.dailyRepeatsEnabled,
                  change: (selected) =>
                      setState(() => vm.dailyRepeatsEnabled = selected),
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
                          suffix: buildTimeSuffix("ч"),
                          initial: vm.goalValueHours,
                          change: (dynamic h) => setState(
                            () => vm.setGoalValueHours(h as double),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextInput<double>(
                          suffix: buildTimeSuffix("мин"),
                          initial: vm.goalValueMinutes,
                          change: (dynamic m) => setState(
                            () => vm.setGoalValueMinutes(m as double),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextInput<double>(
                          suffix: buildTimeSuffix("сек"),
                          initial: vm.goalValueSeconds,
                          change: (dynamic s) => setState(
                              () => vm.setGoalValueSeconds(s as double)),
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
                            setState(() => vm.increaseGoalValueByPercent()),
                      ),
                      SimpleButton(
                        text: "+ 1 сек",
                        onTap: () => setState(() => vm.goalValue += 1),
                      ),
                      SimpleButton(
                        text: "+ 1 мин",
                        onTap: () => setState(() => vm.goalValue += 1 * 60),
                      ),
                      SimpleButton(
                        text: "+ 1 ч",
                        onTap: () => setState(() => vm.goalValue += 1 * 3600),
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
                        setState(() => vm.goalValue = v as double),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SimpleButton(
                        text: "+ 1 %",
                        onTap: () =>
                            setState(() => vm.increaseGoalValueByPercent()),
                      ),
                      SimpleButton(
                        text: "+ 1",
                        onTap: () => setState(() => vm.goalValue += 1),
                      ),
                      SimpleButton(
                        text: "+ 10",
                        onTap: () => setState(() => vm.goalValue += 10),
                      ),
                      SimpleButton(
                        text: "+ 100",
                        onTap: () => setState(() => vm.goalValue += 100),
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
                        setState(() => vm.dailyRepeats = r as double),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SimpleButton(
                        text: "+ 1 %",
                        onTap: () =>
                            setState(() => vm.increaseDailyRepeatsByPercent()),
                      ),
                      SimpleButton(
                        text: "+ 1",
                        onTap: () => setState(() => vm.dailyRepeats += 1),
                      ),
                      SimpleButton(
                        text: "+ 10",
                        onTap: () => setState(() => vm.dailyRepeats += 10),
                      ),
                      SimpleButton(
                        text: "+ 100",
                        onTap: () => setState(() => vm.dailyRepeats += 1000),
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
                      change: (_) => setState(() {
                        vm.habitPeriod.type = HabitPeriodType.day;
                        vm.habitPeriod.isCustom = false;
                      }),
                    ),
                    SimpleChip(
                      text: "Еженедельная",
                      selected: !vm.habitPeriod.isCustom &&
                          vm.habitPeriod.type == HabitPeriodType.week,
                      change: (_) => setState(() {
                        vm.habitPeriod.type = HabitPeriodType.week;
                        vm.habitPeriod.isCustom = false;
                      }),
                    ),
                    SimpleChip(
                      text: "Ежемесячная",
                      selected: !vm.habitPeriod.isCustom &&
                          vm.habitPeriod.type == HabitPeriodType.month,
                      change: (_) => setState(() {
                        vm.habitPeriod.type = HabitPeriodType.month;
                        vm.habitPeriod.isCustom = false;
                      }),
                    ),
                    SimpleChip(
                      text: "Другая",
                      selected: vm.habitPeriod.isCustom,
                      change: (_) =>
                          setState(() => vm.habitPeriod.isCustom = true),
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
                        change: (dynamic v) => setState(
                            () => vm.habitPeriod.periodValue = v as int),
                      )),
                      SizedBox(width: 10),
                      Expanded(
                        child: HabitPeriodTypeSelect(
                          initial: vm.habitPeriod.type,
                          change: (t) =>
                              setState(() => vm.habitPeriod.type = t),
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
                    change: (ws) =>
                        setState(() => vm.habitPeriod.weekdays = ws),
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
                    change: (dynamic d) =>
                        setState(() => vm.habitPeriod.monthDay = d as int),
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
                  await Get.find<HabitRepo>().update(vm);
                } else {
                  await Get.find<HabitRepo>().insert(vm);
                }
                Get.toNamed<void>(Routes.list);
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

  Widget buildTimeSuffix(String text) =>
      Text(text, textAlign: TextAlign.center);
}
