import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/ui/calendar/app/habit_swiper.dart';
import 'package:yaxxxta/ui/core/text.dart';

import 'bottom_nav.dart';

class CalendarAppPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vms = useProvider(habitVMsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Headline4("*лого*"),
        centerTitle: true,
      ),
      body: vms.isEmpty
          ? Center(child: Text("Привычки не найдены"))
          : HabitSwiper(vms: vms),
      bottomNavigationBar: MyBottomNav(),
    );
  }
}
