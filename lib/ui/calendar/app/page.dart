import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/logic/subscription/hooks.dart';
import 'package:yaxxxta/ui/calendar/app/habit_swiper.dart';
import 'package:yaxxxta/ui/core/text.dart';

import 'bottom_nav.dart';

class CalendarAppPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vms = useProvider(habitVMsProvider);
    // var vms = <HabitVM>[];

    useSubscription(context);

    return Scaffold(
      appBar: AppBar(
        title: Headline4(
          "Яхта",
          style: TextStyle(
            fontFamily: "mr_DopestyleG",
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
      ),
      body: vms.isEmpty
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Что-то не видать привычек",
                  style: TextStyle(color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Заведи привычку, нажав на ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.add_circle,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ))
          : HabitSwiper(vms: vms),
      bottomNavigationBar: MyBottomNav(),
    );
  }
}
