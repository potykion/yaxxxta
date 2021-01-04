import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/core/ui/deps.dart';
import 'package:yaxxxta/core/ui/widgets/circular_progress.dart';

import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/date.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../core/utils/dt.dart';
import '../../../main.dart';
import '../../../routes.dart';
import '../../../theme.dart';
import '../../domain/models.dart';
import '../core/deps.dart';
import '../core/widgets.dart';

enum HabitActionType { edit, delete }

GlobalKey _scaffold = GlobalKey();

/// Страничка с инфой о привычке
class HabitDetailsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var habit = useProvider(selectedHabitProvider);
    var historyDateState = useState(DateTime.now().date());
    var progress = useProvider(selectedHabitProgressProvider);
    var history = useProvider(selectedHabitHistoryProvider);

    return Scaffold(
      key: _scaffold,
      body: habit != null
          ? ListView(
              children: [
                // todo отдельным компонентом + в апп-бар перенести
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.of(context).pop()),
                      Expanded(child: BiggestText(text: habit.title)),
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
                                  .pushNamed(Routes.form, arguments: habit);
                            } else if (actionType == HabitActionType.delete) {
                              var isDelete = await showModalBottomSheet<bool>(
                                context: context,
                                builder: (context) => Container(
                                  height: 170,
                                  child: ListView(
                                    children: [
                                      ListTile(
                                        title:
                                            BiggerText(text: "Точно удаляем?"),
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
                                context
                                    .read(habitControllerProvider)
                                    .delete(habit.id);
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
                        label: Text(habit.type.verbose()),
                        backgroundColor: CustomColors.blue,
                      ),
                      Chip(
                        label: Text(habit.habitPeriod.type.verbose()),
                        backgroundColor: CustomColors.red,
                      ),
                    ],
                  ),
                ),
                HabitRepeatControl(
                  repeats: progress.repeats,
                  onRepeatIncrement: (repeatIndex, incrementValue, [_]) =>
                      navigatorKey.currentContext
                          .read(habitPerformingController)
                          .create(
                            habitId: habit.id,
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
                      change: (d) => historyDateState.value = d,
                      highlights: history.highlights,
                    ),
                    if (history.history.containsKey(historyDateState.value))
                      for (var e in history.history[historyDateState.value])
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
            )
          : CenteredCircularProgress(),
    );
  }
}
