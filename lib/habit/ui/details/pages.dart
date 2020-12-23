import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/date.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../core/utils/dt.dart';
import '../../../deps.dart';
import '../../../theme.dart';
import '../../domain/models.dart';
import 'controllers.dart';
import 'view_models.dart';

StateNotifierProvider<HabitDetailsController> _controller =
    StateNotifierProvider((ref) {
  var controller = HabitDetailsController(
    habitRepo: ref.watch(habitRepoProvider),
    habitPerformingRepo: ref.watch(habitPerformingRepoProvider),
  );
  controller.load(Get.arguments as int);
  return controller;
});

/// Страничка с инфой о привычке
class HabitDetailsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var controller = useProvider(_controller.state);

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                BiggestText(text: controller.habit.title),
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
                Chip(label: Text("Спорт"), backgroundColor: CustomColors.pink),
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
}
