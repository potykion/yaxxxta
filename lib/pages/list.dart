import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/ui/widgets/app_bars.dart';
import '../core/ui/widgets/bottom_nav.dart';
import '../core/ui/widgets/card.dart';
import '../core/ui/widgets/padding.dart';
import '../core/ui/widgets/text.dart';
import '../deps.dart';
import '../habit/ui/core/widgets.dart';
import '../routes.dart';

/// Страница со списком привычек
class HabitListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var habits = useProvider(habitControllerProvider.state);

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        children: [BiggestText(text: "Привычки", withPadding: true)],
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
      bottomNavigationBar: AppBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: "HabitListPage",
        child: Icon(Icons.add, size: 50),
        onPressed: () => Navigator.of(context).pushNamed(Routes.form),
      ),
    );
  }
}
