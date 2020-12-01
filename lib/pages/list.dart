import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../db.dart';
import '../view_models.dart';
import '../widgets.dart';

/// Страница списка привычек
class HabitListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
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
            for (var vm in Get.find<HabitRepo>()
                .list()
                .map((h) => HabitVM.fromHabit(h)))
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
      );
}
