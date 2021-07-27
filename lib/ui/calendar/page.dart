import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/ads/state.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/logic/subscription/hooks.dart';
import 'package:yaxxxta/ui/calendar/habit_swiper.dart';
import 'bottom_nav.dart';
import 'no_habits_label.dart';

class CalendarPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    late BannerAd? ad;
    if (kReleaseMode) {
      ad = useProvider(adProvider(0));
    } else {
      ad = useProvider(adProvider(0));
      // ad = null;
    }

    List<HabitVM> vms = useProvider(habitVMsProvider);
    // List<HabitVM> vms = [];

    useSubscription(context);

    return Scaffold(
      // appBar: AppBar(title: Brand(), centerTitle: true),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Expanded(
            child: vms.isEmpty
                ? Center(child: NoHabitsLabel())
                : HabitSwiper(vms: vms),
          ),
          if (ad != null)
            Container(
              height: AdSize.banner.height.toDouble(),
              width: AdSize.banner.width.toDouble(),
              child: AdWidget(ad: ad),
            ),
        ],
      ),
      bottomNavigationBar: CalendarBottomNav(),
    );
  }
}
