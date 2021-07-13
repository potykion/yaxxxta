import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/ads/state.dart';

import 'no_habits_label.dart';

/// Страничка, на которой написано, что нет привычек + рекламка
class NoHabitsPage extends HookWidget {
  /// Страничка, на которой написано, что нет привычек + рекламка
  const NoHabitsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ad = useProvider(adProvider(0));

    return Column(
      children: [
        Expanded(child: Center(child: NoHabitsLabel())),
        Container(
          height: AdSize.banner.height.toDouble(),
          width: AdSize.banner.width.toDouble(),
          child: ad != null ? AdWidget(ad: ad) : null,
        ),
      ],
    );
  }
}
