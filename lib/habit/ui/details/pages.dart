import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../core/ui/deps.dart';
import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/circular_progress.dart';
import '../../../core/ui/widgets/date.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../core/utils/dt.dart';
import '../../../routes.dart';
import '../../../theme.dart';
import '../../domain/models.dart';
import '../core/deps.dart';
import '../core/widgets.dart';

/// Тип действия над привычкой
enum HabitActionType {
  /// Редактирование привычки
  edit,

  /// Удаление привычки
  delete
}

GlobalKey _scaffold = GlobalKey();

/// Страничка с инфой о привычке
class HabitDetailsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        context.read(habitPerformingController).loadSelectedHabitPerformings(
            context.read(selectedHabitIdProvider).state);
      });
      return;
    }, []);

    var vmAsyncValue = useProvider(habitDetailsPageVMProvider);
    var historyDateState = useState(DateTime.now().date());

    return Scaffold(
        key: _scaffold,
        body: vmAsyncValue.maybeMap(
          data: (maybeVM) {
            var vm = maybeVM.value;
            var habit = vm.habit;
            var progress = vm.progress;
            var history = vm.history;

            return ListView(
              children: [
                // todo отдельным компонентом + в апп-бар перенести
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () => Navigator.of(context).pop()),
                      Expanded(child: BiggestText(text: vm.habit.title)),
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
                                Navigator.of(context).pop(true);
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
                        label: Text(habit.periodType.verbose()),
                        backgroundColor: CustomColors.red,
                      ),
                      if (habit.performTime != null)
                        Chip(
                          avatar: Icon(Icons.access_time),
                          label: Text(formatTime(habit.performTime)),
                          backgroundColor: CustomColors.purple,
                        ),
                    ],
                  ),
                ),
                HabitProgressControl(
                  key: Key("HabitDetailsPage_HabitRepeatControl"),
                  vm: progress,
                  onRepeatIncrement: (incrementValue, _, [__]) => navigatorKey
                      .currentContext
                      .read(habitPerformingController)
                      .insert(HabitPerforming(
                        habitId: habit.id,
                        performValue: incrementValue,
                        performDateTime: DateTime.now(),
                      )),
                  repeatTitle: "Сегодня",
                ),
                PaddedContainerCard(children: [
                  Row(
                    children: [
                      BiggerText(text: "История"),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () async {
                          var habitPerforming =
                              await showModalBottomSheet<HabitPerforming>(
                            context: context,
                            builder: (context) => HabitPerformingFormModal(
                              initialHabitPerforming:
                                  HabitPerforming.blank(habit.id),
                              habitType: habit.type,
                            ),
                          );
                          if (habitPerforming != null) {
                            await context
                                .read(habitPerformingController)
                                .insert(habitPerforming);
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  DateCarousel(
                    change: (d) => historyDateState.value = d,
                    highlights: history.highlights,
                  ),
                  if (history.history.containsKey(historyDateState.value))
                    for (var e in history.history[historyDateState.value])
                      Slidable(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 15,
                          ),
                          child: Row(children: [
                            SmallerText(
                              text: formatTime(e.time),
                              dark: true,
                            ),
                            Spacer(),
                            SmallerText(
                              text: "+ ${e.format(habit.type)}",
                              dark: true,
                            )
                          ]),
                        ),
                        secondaryActions: [
                          IconSlideAction(
                            caption: "Изменить",
                            color: CustomColors.orange,
                            icon: Icons.edit,
                            onTap: () async {
                              var habitPerforming =
                                  await showModalBottomSheet<HabitPerforming>(
                                context: context,
                                builder: (context) => HabitPerformingFormModal(
                                  initialHabitPerforming: HabitPerforming(
                                    habitId: habit.id,
                                    performValue: e.value,
                                    performDateTime: e.time,
                                  ),
                                  habitType: habit.type,
                                ),
                              );
                              if (habitPerforming != null) {
                                await context
                                    .read(habitPerformingController)
                                    .update(habitPerforming);
                              }
                            },
                          ),
                          IconSlideAction(
                            caption: "Удалить",
                            color: CustomColors.red,
                            icon: Icons.delete,
                            onTap: () => context
                                .read(habitPerformingController)
                                .deleteForDateTime(e.time),
                          ),
                        ],
                        actionPane: SlidableDrawerActionPane(),
                      )
                ])
              ],
            );
          },
          orElse: () => CenteredCircularProgress(),
        ));
  }
}
