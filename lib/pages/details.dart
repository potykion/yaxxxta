import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/utils.dart';
import 'package:yaxxxta/view_models.dart';
import 'package:yaxxxta/widgets.dart';

import '../models.dart';

class HabitDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  BiggestText(text: "Планочка"),
                  Spacer(),
                  IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Wrap(
                spacing: 5,
                children: [
                  Chip(
                      label: Text("На время"),
                      backgroundColor: CustomColors.blue),
                  Chip(
                      label: Text("Ежедневная"),
                      backgroundColor: CustomColors.red),
                  Chip(
                      label: Text("Спорт"), backgroundColor: CustomColors.pink),
                ],
              ),
            ),
            PaddedContainerCard(
              children: [
                BiggerText(text: "Сегодня"),
                SizedBox(height: 5),
                HabitProgressControl(
                  progressPercentage: 0.3,
                  progressStr: "3 / 10",
                  type: HabitType.repeats,
                  isSingleRepeat: false,
                ),
              ],
            ),
            PaddedContainerCard(
              children: [
                BiggerText(text: "История"),
                SizedBox(height: 5),
                DateScroll(),
                for (var e in [
                  HabitHistoryEntry(datetime: DateTime(2020, 17, 11, 11), value: 60),
                  HabitHistoryEntry(datetime: DateTime(2020, 17, 11, 12), value: 60),
                ])
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(children: [
                      SmallerText(
                        text: formatTime(e.datetime),
                        dark: true,
                      ),
                      Spacer(),
                      SmallerText(
                        text: "+ ${e.format(HabitType.time)}",
                        dark: true,
                      )
                    ]),
                  )
              ],
            ),
          ],
        ),
      );
}
