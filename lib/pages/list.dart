import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:yaxxxta/theme.dart';

import '../db.dart';
import '../deps.dart';
import '../routes.dart';
import '../view_models.dart';
import '../widgets.dart';

/// Страница списка привычек
class HabitListPage extends ConsumerWidget  {
  @override
  Widget build(BuildContext context, watch) {
    var controller = watch(habitListControllerProvider);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: kToolbarHeight),
              DatePicker(),
            ],
          ),
        ),
        body: ListView(
          children: [
            for (var vm in controller.state)
              SizedBox(
                height: 130,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      HabitCard(vm: vm, repeatIndex: index),
                  itemCount: vm.repeats.length,
                ),
              )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, size: 50),
          onPressed: () => Get.toNamed<void>(Routes.form),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: CustomColors.almostBlack,
          unselectedItemColor: CustomColors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.today),
              label: "Календарь",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Настройки",
            ),
          ],
        ),
      );
  }
}
