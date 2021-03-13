import 'package:flutter/material.dart';
import '../widgets/core/app_bars.dart';
import '../widgets/core/bottom_nav.dart';
import '../widgets/core/padding.dart';
import '../widgets/core/text.dart';

/// Страничка с наградами
class RewardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        children: [SmallPadding.noBottom(child: BiggestText(text: "Награды"))],
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
