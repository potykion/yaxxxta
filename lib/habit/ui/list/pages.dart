import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../core/ui/widgets/bottom_nav.dart';
import '../../../core/ui/widgets/app_bars.dart';
import '../../../core/ui/widgets/card.dart';
import '../../../core/ui/widgets/circular_progress.dart';
import '../../../core/ui/widgets/text.dart';
import '../../../routes.dart';
import '../core/deps.dart';
import '../core/widgets.dart';

/// Страница со списком привычек
class HabitListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        context.read(habitControllerProvider).load();
      });
      return;
    }, []);

    var habitsAsyncValue = useProvider(habitControllerProvider.state);

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        children: [BiggestText(text: "Привычки", withPadding: true)],
      ),
      body: habitsAsyncValue.maybeWhen(
        data: (habits) => ListView(
          children: [
            for (var habit in habits)
              GestureDetector(
                onTap: () async {
                  context.read(selectedHabitIdProvider).state = habit.id;
                  await Navigator.of(context).pushNamed(Routes.details);
                },
                child: PaddedContainerCard(
                  padVerticalOnly: true,
                  children: [
                    ListTile(
                      title: BiggerText(text: habit.title),
                      subtitle: HabitChips(habit: habit),
                    ),
                  ],
                ),
              )
          ],
        ),
        orElse: () => CenteredCircularProgress(),
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
