import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/widgets/bottom_nav.dart';

import '../routes.dart';

class CalendarPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vms = useProvider(habitControllerProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(Routes.add),
          )
        ],
      ),
      body: vms.isEmpty
          ? Center(child: Text("Привычки не найдены"))
          : Swiper(
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
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: FloatingActionButton(
                          heroTag: null,
                          child: Icon(Icons.done, size: 40),
                          onPressed: () => context
                              .read(habitControllerProvider.notifier)
                              .perform(vm.habit),
                        ),
                      ),
                      if (vm.performings.isNotEmpty) ...[
                        SizedBox(height: 10),
                        Text("Выполнения привычки:"),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) =>
                                ListTile(
                              dense: true,
                              title: Text(
                                vm.performings[index].created.toString(),
                              ),
                            ),
                            itemCount: vm.performings.length,
                          ),
                        )
                      ]
                    ],
                  ),
                );
              },
              pagination: SwiperPagination(alignment: Alignment.topCenter),
            ),
      bottomNavigationBar: MyBottomNav(),
    );
  }
}
