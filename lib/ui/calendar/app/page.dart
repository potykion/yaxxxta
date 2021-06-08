import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/ui/core/app_bar_buttons.dart';
import 'package:yaxxxta/ui/calendar/app/habit_swiper.dart';
import 'package:yaxxxta/ui/core/text.dart';

import 'bottom_nav.dart';
import 'habit_list.dart';

class CalendarAppPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vms = useProvider(habitVMsProvider);
    var showList = useState(false);
    var initialIndex = useState(0);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: kToolbarHeight + 24,
        title: Headline4(showList.value ? "Список" : "Календарь"),
        actions: [
          AppBarIconButton(
            onPressed: () => showList.value = !showList.value,
            icon: showList.value ? Icons.today : Icons.list,
          ),
        ],
      ),
      body: vms.isEmpty
          ? Center(child: Text("Привычки не найдены"))
          : AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: showList.value
                  ? HabitList(
                      vms: vms,
                      onHabitSelect: (index) {
                        initialIndex.value = index;
                        showList.value = false;
                      },
                    )
                  : HabitSwiper(
                      initialIndex: initialIndex.value,
                      vms: vms,
                    ),
            ),
      bottomNavigationBar: MyBottomNav(),
    );
  }
}
