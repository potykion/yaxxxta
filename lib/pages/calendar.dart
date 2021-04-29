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
    var vms = useProvider(habitVMsProvider);

    var currentIndex = useState(0);
    var controller = useState(SwiperController());
    // При открытии аппа скроллим на первую невыполненную привычку
    useEffect(
      () {
        WidgetsBinding.instance!.addPostFrameCallback((_) async {
          var nextIndex = getNextUnperformedHabitIndex(
            vms,
            initialIndex: 0,
            includeInitial: true,
          );
          if (nextIndex != -1) {
            currentIndex.value = nextIndex;
            controller.value.move(nextIndex);
          }
        });
      },
      [],
    );

    return WebPadding(
      child: Scaffold(
        appBar: AppBar(
          title: HabitPagination(
            vms: vms,
            currentIndex: currentIndex.value,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.of(context).pushNamed(Routes.form),
            ),
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () async {
                var index =
                    await Navigator.of(context).pushNamed(Routes.list) as int?;
                if (index != null) {
                  currentIndex.value = index;
                  controller.value.move(index);
                }
              },
            )
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
                onIndexChanged: (index) => currentIndex.value = index,
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
                            PerformHabitButton(
                              vm: vm,
                              onPerform: () {
                                var nextIndex = getNextUnperformedHabitIndex(
                                  vms,
                                  initialIndex: index,
                                );
                                if (nextIndex != -1) {
                                  currentIndex.value = nextIndex;
                                  controller.value.move(nextIndex);
                                }
                              },
                            ),
                            FloatingActionButton(
                              heroTag: null,
                              onPressed: () async {
                                var archived = await Navigator.of(context)
                                    .pushNamed(Routes.form,
                                        arguments: vm.habit) as bool?;
                                if (archived ?? false) {
                                  currentIndex.value = 0;
                                  controller.value.move(0);
                                }
                              },
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
