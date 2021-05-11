import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/app_user_info/controllers.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/widgets/habit_list_tile.dart';
import 'package:yaxxxta/widgets/habit_performing_card.dart';
import 'package:yaxxxta/widgets/calendar_app_bar.dart';

var _selectedHabitIndexProvider = StateProvider((ref) => 0);

class CalendarWebPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var selectedHabitIndex = useProvider(_selectedHabitIndexProvider).state;

    var pageController =
        useMemoized(() => PageController(initialPage: selectedHabitIndex));
    useEffect(() {
      updateIndex() {
        context.read(_selectedHabitIndexProvider).state =
            pageController.page!.toInt();
      }

      pageController.addListener(updateIndex);
      return () => pageController.removeListener(updateIndex);
    }, []);
    useValueChanged<int, void>(selectedHabitIndex, (_, __) {
      if (selectedHabitIndex == pageController.page) return;
      pageController.jumpToPage(selectedHabitIndex);
    });

    var swipeToNextUnperformed = useProvider(swipeToNextUnperformedProvider);

    var vms = useProvider(habitVMsProvider);

    List<Widget> children = List.generate(vms.length, (index) => index)
        .map(
          (index) => HabitListTile(
            vm: vms[index],
            index: index,
            onTap: () =>
                context.read(_selectedHabitIndexProvider).state = index,
            isSelected: selectedHabitIndex == index,
          ),
        )
        .toList();

    return Scaffold(
      appBar: buildCalendarAppBar(context),
      body: Row(
        children: [
          Flexible(child: ListView(children: children)),
          VerticalDivider(),
          Flexible(
            child: PageView.builder(
              itemCount: vms.length,
              scrollDirection: Axis.vertical,
              controller: pageController,
              itemBuilder: (_, index) => HabitPerformingCard(
                vm: vms[index],
                onPerform: () {
                  if (swipeToNextUnperformed) {
                    var nextIndex = getNextUnperformedHabitIndex(
                      vms,
                      initialIndex: index,
                    );
                    if (nextIndex != -1) {
                      context.read(_selectedHabitIndexProvider).state =
                          nextIndex;
                    }
                  }
                },
              ),
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }
}
