import 'package:flutter/material.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/view_models.dart';
import 'package:yaxxxta/widgets.dart';

class HabitEditPage extends StatelessWidget {
  get hasId => false;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView(
          children: [
            PaddedContainerCard(
              children: [
                BiggerText(text: "Название"),
                SizedBox(height: 5),
                TextInput(),
              ],
            ),
            PaddedContainerCard(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    BiggerText(text: "Тип"),
                    Spacer(),
                    if (hasId) SmallerText(text: "нельзя изменить")
                  ],
                ),
                SizedBox(height: 5),
                HabitTypeInput(
                  initial: HabitType.repeats,
                  change: (type) => print(type),
                  setBefore: hasId,
                ),
                HabitRepeatDuringDayCheckbox(
                  initial: false,
                  change: (selected) {},
                )
              ],
            ),
            PaddedContainerCard(
              children: [
                BiggerText(text: "Продолжительность"),
                SizedBox(height: 5),
                Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextInput(
                        suffix: buildTimeSuffix("ч"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(child: TextInput(suffix: buildTimeSuffix("мин"))),
                    SizedBox(width: 10),
                    Expanded(child: TextInput(suffix: buildTimeSuffix("сек"))),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleButton(text: "+ 1 %", onTap: () {}),
                    SimpleButton(text: "+ 1 сек", onTap: () {}),
                    SimpleButton(text: "+ 1 мин", onTap: () {}),
                    SimpleButton(text: "+ 1 ч", onTap: () {}),
                  ],
                ),
              ],
            ),
            PaddedContainerCard(
              children: [
                BiggerText(text: "Число повторений за раз"),
                SizedBox(height: 5),
                TextInput(),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleButton(text: "+ 1 %", onTap: () {}),
                    SimpleButton(text: "+ 1", onTap: () {}),
                    SimpleButton(text: "+ 10", onTap: () {}),
                    SimpleButton(text: "+ 100", onTap: () {}),
                  ],
                )
              ],
            ),
            PaddedContainerCard(
              children: [
                BiggerText(text: "Число повторений за день"),
                SizedBox(height: 5),
                TextInput(),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SimpleButton(text: "+ 1 %", onTap: () {}),
                    SimpleButton(text: "+ 1", onTap: () {}),
                    SimpleButton(text: "+ 10", onTap: () {}),
                    SimpleButton(text: "+ 100", onTap: () {}),
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
                        text: "Ежедневная", selected: true, change: (_) {}),
                    SimpleChip(
                        text: "Еженедельная", selected: false, change: (_) {}),
                    SimpleChip(
                        text: "Ежемесячная", selected: false, change: (_) {}),
                    SimpleChip(text: "Другая", selected: false, change: (_) {}),
                  ],
                )
              ],
            ),
            PaddedContainerCard(
              children: [
                BiggerText(text: "Дни выполнения"),
                SizedBox(height: 5),
                Wrap(
                  spacing: 5,
                  children: [
                    SimpleChip(
                        text: "Пн",
                        selected: true,
                        change: (_) {},
                        color: CustomColors.yellow,
                        padding: EdgeInsets.all(5)),
                    SimpleChip(
                        text: "Вт",
                        selected: false,
                        change: (_) {},
                        color: CustomColors.yellow,
                        padding: EdgeInsets.all(5)),
                    SimpleChip(
                        text: "Ср",
                        selected: false,
                        change: (_) {},
                        color: CustomColors.yellow,
                        padding: EdgeInsets.all(5)),
                    SimpleChip(
                        text: "Чт",
                        selected: false,
                        change: (_) {},
                        color: CustomColors.yellow,
                        padding: EdgeInsets.all(5)),
                    SimpleChip(
                        text: "Пт",
                        selected: false,
                        change: (_) {},
                        color: CustomColors.yellow,
                        padding: EdgeInsets.all(5)),
                    SimpleChip(
                        text: "Сб",
                        selected: false,
                        change: (_) {},
                        color: CustomColors.yellow,
                        padding: EdgeInsets.all(5)),
                    SimpleChip(
                        text: "Вс",
                        selected: false,
                        change: (_) {},
                        color: CustomColors.yellow,
                        padding: EdgeInsets.all(5)),
                  ],
                )
              ],
            ),
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
                TextInput(),
              ],
            )
          ],
        ),
      );

  Padding buildTimeSuffix(String text) => Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Text(text, textAlign: TextAlign.center),
      );
}
