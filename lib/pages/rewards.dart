import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/reward/controllers.dart';
import 'package:yaxxxta/logic/user/controllers.dart';
import 'package:yaxxxta/widgets/reward/reward_card.dart';
import '../logic/reward/models.dart';

import '../widgets/core/app_bars.dart';
import '../widgets/core/bottom_nav.dart';
import '../widgets/core/text.dart';
import '../widgets/reward/reward_modal.dart';

/// Страничка с наградами
class RewardsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var userData = useProvider(userDataControllerProvider)!;
    var rewards = useProvider(sortedRewardsProvider(userData.performingPoints));

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        children: [
          Expanded(
            child: ListTile(
              title: BiggestText(text: "Награды"),
              trailing: BiggerText(text: "${userData.performingPoints} 🅿"),
            ),
          )
        ],
      ),
      body: Center(
        child: rewards.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmallerText(text: "Что-то не видать наград"),
                  BiggerText(text: "Самое время создать одну"),
                ],
              )
            : ListView.builder(
                itemCount: rewards.length,
                itemBuilder: (context, index) => RewardCard(
                  reward: rewards[index],
                  userPerformingPoints: userData.performingPoints,
                ),
              ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 50),
        onPressed: () async {
          var reward = await showModalBottomSheet<Reward?>(
            context: context,
            isScrollControlled: true,
            builder: (context) => RewardModal(),
          );
          if (reward != null) {
            await context.read(rewardControllerProvider.notifier).create(reward);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
