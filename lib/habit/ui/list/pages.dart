import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:yaxxxta/core/ui/widgets/card.dart';
import 'package:yaxxxta/core/ui/widgets/padding.dart';
import 'package:yaxxxta/core/ui/widgets/text.dart';
import 'package:yaxxxta/core/utils/dt.dart';

import '../../../core/ui/widgets/bottom_nav.dart';
import '../../../core/ui/widgets/circular_progress.dart';
import '../../../routes.dart';
import '../../../theme.dart';
import '../core/deps.dart';
import '../../domain/models.dart';

/// Страница со списком привычек
class HabitListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        context.read(habitControllerProvider).list();
      });
      return;
    }, []);

    var habitsAsyncValue = useProvider(habitControllerProvider.state);

    return Scaffold(
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
                      subtitle: Wrap(
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
