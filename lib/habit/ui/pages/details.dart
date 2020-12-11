import 'package:flutter/material.dart';


/// Страничка с инфой о привычке
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
                // HabitProgressControl(
                // ),
              ],
            ),
            PaddedContainerCard(
              children: [
                BiggerText(text: "История"),
                SizedBox(height: 5),
                DatePicker(),
                for (var e in [
                  HabitHistoryEntry(
                    datetime: DateTime(2020, 17, 11, 11),
                    value: 60,
                  ),
                  HabitHistoryEntry(
                    datetime: DateTime(2020, 17, 11, 12),
                    value: 60,
                  ),
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
