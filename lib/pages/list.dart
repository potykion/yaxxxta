import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../deps.dart';
import '../habit/ui/core/widgets.dart';
import '../routes.dart';
import '../widgets/core/app_bars.dart';
import '../widgets/core/card.dart';
import '../widgets/core/padding.dart';
import '../widgets/core/text.dart';

/// Страница со списком привычек
class HabitListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var habits = useProvider(habitControllerProvider.state);

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        children: [
          BackButton(),
          BiggestText(text: "Привычки"),
        ],
      ),
      body: habits.isNotEmpty
          ? ListView(
              children: [
                for (var habit in habits)
                  GestureDetector(
                    onTap: () async {
                      context.read(selectedHabitIdProvider).state = habit.id;
                      await Navigator.of(context).pushNamed(Routes.details);
                    },
                    child: ContainerCard(
                      children: [
                        ListTile(
                          title: BiggerText(text: habit.title),
                          dense: true,
                        ),
                        SmallPadding(child: HabitChips(habit: habit)),
                      ],
                    ),
                  )
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmallerText(text: "Что-то не видать привычек"),
                  BiggerText(text: "Самое время завести одну!"),
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        heroTag: "HabitListPage",
        child: Icon(Icons.add, size: 50),
        onPressed: () => Navigator.of(context).pushNamed(Routes.form),
      ),
    );
  }
}
