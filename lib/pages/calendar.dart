import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/widgets/bottom_nav.dart';

class CalendarPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var habits = useProvider(habitControllerProvider);

    return Scaffold(
      body: habits.isEmpty
          ? Center(child: Text("Привычки не найдены"))
          : Center(child: Text("CalendarPage")),
      bottomNavigationBar: MyBottomNav(),
    );
  }
}
