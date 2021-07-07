import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/logic/subscription/hooks.dart';
import 'package:yaxxxta/ui/calendar/app/brand.dart';
import 'package:yaxxxta/ui/calendar/app/habit_swiper.dart';
import 'package:yaxxxta/ui/calendar/app/no_habits_label.dart';
import 'package:yaxxxta/ui/core/text.dart';

import 'bottom_nav.dart';

class CalendarAppPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vms = useProvider(habitVMsProvider);

    useSubscription(context);

    return Scaffold(
      appBar: AppBar(title: Brand(), centerTitle: true),
      body:
          vms.isEmpty ? Center(child: NoHabitsLabel()) : HabitSwiper(vms: vms),
      bottomNavigationBar: MyBottomNav(),
    );
  }
}
