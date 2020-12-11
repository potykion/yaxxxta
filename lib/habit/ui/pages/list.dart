import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../core/ui/widgets/date.dart';
import '../../../deps.dart';
import '../../../routes.dart';
import '../../../theme.dart';
import '../widgets/list.dart';

/// Страница списка привычек
class HabitListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var habits = useProvider(habitListControllerProvider.state);

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
          for (var vm in habits)
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
        onPressed: () => Navigator.of(context).pushNamed(Routes.form),
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
