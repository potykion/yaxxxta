import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/widgets/bottom_nav.dart';
import 'package:yaxxxta/widgets/habit_performing_calendar.dart';
import 'package:yaxxxta/widgets/pagination.dart';
import 'package:yaxxxta/widgets/perform_habit_btn.dart';

import '../routes.dart';

class CalendarPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var initialIndex = ModalRoute.of(context)!.settings.arguments as int? ?? 0;
    var currentIndex = useState(initialIndex);

    var vms = useProvider(habitVMsProvider);

    return Scaffold(
      appBar: AppBar(
        title: HabitPagination(
          vms: vms,
          currentIndex: currentIndex.value,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(Routes.add),
          ),
          IconButton(
              icon: Icon(Icons.list),
              onPressed: () => Navigator.of(context).pushNamed(Routes.list))
        ].reversed.toList(),
        // titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            backgroundImage:
                NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
            // radius: 2,
          ),
        ),
      ),
      body: Stack(
        children: [
          if (vms.isEmpty)
            Center(child: Text("Привычки не найдены"))
          else ...[
            Swiper(
              onIndexChanged: (index) => currentIndex.value = index,
              index: currentIndex.value,
              key: ValueKey(vms.length),
              itemCount: vms.length,
              itemBuilder: (context, index) {
                var vm = vms[index];

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        vm.habit.title,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SizedBox(height: 10),
                      PerformHabitButton(vm: vm),
                      SizedBox(height: 20),
                      HabitPerformingCalendar(vm: vm),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
