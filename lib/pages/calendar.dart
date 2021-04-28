import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/widgets/habit_performing_calendar.dart';
import 'package:yaxxxta/widgets/pagination.dart';
import 'package:yaxxxta/widgets/perform_habit_btn.dart';
import 'package:yaxxxta/widgets/web_padding.dart';

import '../routes.dart';

class CalendarPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var currentIndex = useProvider(selectedHabitIndexProvider).state;

    var controller = useState(SwiperController());
    useValueChanged<int, void>(currentIndex, (_, __) {
      if (currentIndex == controller.value.index) return;
      controller.value.move(currentIndex);
    });

    var vms = useProvider(habitVMsProvider);

    return WebPadding(
      child: Scaffold(
        appBar: AppBar(
          title: HabitPagination(
            vms: vms,
            currentIndex: currentIndex,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.of(context).pushNamed(Routes.form),
            ),
            IconButton(
                icon: Icon(Icons.list),
                onPressed: () => Navigator.of(context).pushNamed(Routes.list))
          ].reversed.toList(),
          // titleSpacing: 0,
          leading: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FirebaseAuth.instance.currentUser?.photoURL != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                      FirebaseAuth.instance.currentUser!.photoURL!,
                    ),
                  )
                : Icon(Icons.account_circle),
          ),
        ),
        body: vms.isEmpty
            ? Center(child: Text("Привычки не найдены"))
            : Swiper(
                controller: controller.value,
                onIndexChanged: (index) {
                  print("onIndexChanged");
                  context.read(selectedHabitIndexProvider).state = index;
                },
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Opacity(
                              opacity: 0,
                              // opacity: 1,
                              child: FloatingActionButton(
                                heroTag: null,
                                onPressed: () {},
                                child: Icon(Icons.edit),
                              ),
                            ),
                            PerformHabitButton(vm: vm),
                            FloatingActionButton(
                              heroTag: null,
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(Routes.form, arguments: vm.habit),
                              child: Icon(Icons.edit),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        HabitPerformingCalendar(vm: vm),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
