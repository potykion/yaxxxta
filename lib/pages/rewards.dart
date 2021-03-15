import 'package:flutter/material.dart';
import 'package:yaxxxta/reward/models.dart';

import '../widgets/core/app_bars.dart';
import '../widgets/core/bottom_nav.dart';
import '../widgets/core/padding.dart';
import '../widgets/core/text.dart';
import '../widgets/reward/create_modal.dart';

/// Страничка с наградами
class RewardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        children: [SmallPadding.noBottom(child: BiggestText(text: "Награды"))],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SmallerText(text: "Что-то не видать наград"),
            BiggerText(text: "Самое время создать одну"),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 50),
        onPressed: () async {
          var reward = await showModalBottomSheet<Reward?>(
            context: context,
            isScrollControlled: true,
            builder: (context) => CreateRewardModal(),
          );

          //  todo insert reward
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
