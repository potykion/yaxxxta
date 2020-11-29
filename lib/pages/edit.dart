import 'package:flutter/material.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/view_models.dart';
import 'package:yaxxxta/widgets.dart';

class HabitEditPage extends StatefulWidget {
  @override
  _HabitEditPageState createState() => _HabitEditPageState();
}

class _HabitEditPageState extends State<HabitEditPage> {
  HabitWriteVM vm = HabitWriteVM();

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
                  change: (t) => setState(() => vm.title = t),
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
                HabitTypeInput(
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
                          change: (h) => setState(
                            () => vm.setGoalValueHours(h),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextInput<double>(
                          suffix: buildTimeSuffix("мин"),
                          initial: vm.goalValueMinutes,
                          change: (m) =>
                              setState(() => vm.setGoalValueMinutes(m)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextInput<double>(
                          suffix: buildTimeSuffix("сек"),
                          initial: vm.goalValueSeconds,
                          change: (s) =>
                              setState(() => vm.setGoalValueSeconds(s)),
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
                    change: (v) => setState(() => vm.goalValue = v),
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
                    change: (r) => setState(() => vm.dailyRepeats = r),
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
                        change: (v) =>
                            setState(() => vm.habitPeriod.periodValue = v),
                      )),
                      SizedBox(width: 10),
                      Expanded(
                        child: PeriodTypeSelect(
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
                    change: (d) => setState(() => vm.habitPeriod.monthDay = d),
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
              onPressed: () {
                var s = "As";
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
