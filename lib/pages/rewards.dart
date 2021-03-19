import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/reward/controllers.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/logic/user/ui/controllers.dart';
import '../logic/reward/models.dart';

import '../widgets/core/app_bars.dart';
import '../widgets/core/bottom_nav.dart';
import '../widgets/core/text.dart';
import '../widgets/reward/create_modal.dart';

/// Страничка с наградами
class RewardsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var userData = useProvider(userDataControllerProvider.state)!;
    var rewards = useProvider(rewardControllerProvider.state);

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
                itemBuilder: (context, index) {
                  var reward = rewards[index];

                  return ListTile(
                    title: BiggerText(text: reward.title),
                    subtitle: SmallerText(text: "${reward.cost} 🅿"),
                    trailing: !reward.collected
                        ? IconButton(
                            icon: Icon(
                              Icons.done,
                              color: CustomColors.almostBlack,
                            ),
                            onPressed: () async {
                              await context
                                  .read(rewardControllerProvider)
                                  .collect(reward);
                            },
                          )
                        : null,
                  );
                },
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
          if (reward != null) {
            await context.read(rewardControllerProvider).create(reward);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
