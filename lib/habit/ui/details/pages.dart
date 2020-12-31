import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/habit/ui/core/deps.dart';
import 'package:yaxxxta/habit/ui/core/widgets.dart';
import 'package:yaxxxta/habit/ui/details/view_models.dart';

import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/date.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../core/utils/dt.dart';
import '../../../routes.dart';
import '../../../theme.dart';
import '../../domain/models.dart';
import 'deps.dart';
import 'widgets.dart';

enum HabitActionType { edit, delete }

/// Страничка с инфой о привычке
class HabitDetailsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    HabitDetailsPageVM vm = useProvider(habitDetailsVMProvider);
    var selectedHistoryDateState = useState(DateTime.now().date());

    return Scaffold(
      body: ListView(
        children: [
          // todo отдельным компонентом + в апп-бар перенести
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop()),
                BiggestText(text: vm.habit.title),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () async {
                      var actionType =
                          await showModalBottomSheet<HabitActionType>(
                        context: context,
                        builder: (context) => Container(
                          height: 170,
                          child: ListView(
                            children: [
                              ListTile(
                                title: BiggerText(
                                    text: "Что делаем с привычкой?"),
                              ),
                              ListTile(
                                title: Text("Редактируем"),
                                onTap: () => Navigator.of(context)
                                    .pop(HabitActionType.edit),
                              ),
                              ListTile(
                                title: Text("Удаляем"),
                                onTap: () => Navigator.of(context)
                                    .pop(HabitActionType.delete),
                              ),
                            ],
                          ),
                        ),
                      );

                      if (actionType == HabitActionType.edit) {
                        Navigator.of(context)
                            .pushNamed(Routes.form, arguments: vm.habit.id);
                      } else if (actionType == HabitActionType.delete) {
                        var isDelete = await showModalBottomSheet<bool>(
                          context: context,
                          builder: (context) => Container(
                            height: 170,
                            child: ListView(
                              children: [
                                ListTile(
                                  title: BiggerText(text: "Точно удаляем?"),
                                ),
                                ListTile(
                                  title: Text("Да"),
                                  onTap: () =>
                                      Navigator.of(context).pop(true),
                                ),
                                ListTile(
                                  title: Text("Не"),
                                  onTap: () =>
                                      Navigator.of(context).pop(false),
                                ),
                              ],
                            ),
                          ),
                        );
                        if (isDelete ?? false) {
                          context.read(habitRepoProvider).delete(vm.habit.id);
                          //  todo бля тут тож надо стейт в списке изменить
                          Navigator.of(context).pop();
                        }
                      } else {
                        //  ничо не делаем
                      }
                    })
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Wrap(
              spacing: 5,
              children: [
                Chip(
                  label: Text(vm.habit.type.verbose()),
                  backgroundColor: CustomColors.blue,
                ),
                Chip(
                  label: Text(vm.habit.habitPeriod.type.verbose()),
                  backgroundColor: CustomColors.red,
                ),
              ],
            ),
          ),
          HabitRepeatControl(
            repeats: vm.progress.repeats,
            onRepeatIncrement: (repeatIndex, incrementValue) =>
                context.read(habitPerformingController).create(
                  habitId: vm.habit.id,
                  repeatIndex: repeatIndex,
                  performValue: incrementValue,
                  performDateTime: DateTime.now(),
                ),
            repeatTitle: "Сегодня",
          ),
          PaddedContainerCard(
            children: [
              BiggerText(text: "История"),
              SizedBox(height: 5),
              DatePicker(
                change: (d) => selectedHistoryDateState.value = d,
                highlights: vm.historyHighlights,
              ),
              if (vm.history.containsKey(selectedHistoryDateState.value))
                for (var e in vm.history[selectedHistoryDateState.value])
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(children: [
                      SmallerText(
                        text: formatTime(e.time),
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
