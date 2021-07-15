import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/ads/state.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/logic/subscription/hooks.dart';
import 'package:yaxxxta/ui/calendar/habit_swiper.dart';
import 'package:yaxxxta/ui/core/brand.dart';
import 'bottom_nav.dart';
import 'no_habits_label.dart';

class CalendarPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // BannerAd? ad = useProvider(adProvider(0));
    BannerAd? ad = null;

    List<HabitVM> vms = useProvider(habitVMsProvider);
    // List<HabitVM> vms = [];

    useSubscription(context);

    return Scaffold(
      appBar: AppBar(title: Brand(), centerTitle: true),
      body: Column(
        children: [
          // SizedBox(height: MediaQuery.of(context).padding.top),
          Expanded(
            child: vms.isEmpty
                ? Center(child: NoHabitsLabel())
                : HabitSwiper(vms: vms),
          ),
          Container(
            height: AdSize.banner.height.toDouble(),
            width: AdSize.banner.width.toDouble(),
            child: ad != null ? AdWidget(ad: ad) : null,
          ),
        ],
      ),
      bottomNavigationBar: CalendarBottomNav(),
    );
  }
}
