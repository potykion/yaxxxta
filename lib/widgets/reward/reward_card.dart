import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:yaxxxta/logic/reward/controllers.dart';
import 'package:yaxxxta/logic/reward/models.dart';
import 'package:yaxxxta/widgets/core/card.dart';
import 'package:yaxxxta/widgets/core/text.dart';
import 'package:yaxxxta/widgets/reward/reward_modal.dart';

import '../../theme.dart';

/// Карточка награды
class RewardCard extends StatelessWidget {
  /// Награда
  final Reward reward;

  /// Кол-во баллов юзера
  final int userPerformingPoints;

  /// Карточка награды
  const RewardCard({
    Key? key,
    required this.reward,
    required this.userPerformingPoints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerCard(
      children: [
        Slidable(
          child: ListTile(
            title: BiggerText(
              text: reward.title,
              disabled: reward.collected,
            ),
            subtitle: SmallerText(text: "${reward.cost} 🅿"),
            trailing: !reward.collected
                ? IconButton(
                    icon: Icon(
                      Icons.done,
                      color: reward.canBeCollected(userPerformingPoints)
                          ? CustomColors.almostBlack
                          : CustomColors.grey,
                    ),
                    onPressed: reward.canBeCollected(userPerformingPoints)
                        ? () async {
                            await context
                                .read(rewardControllerProvider)
                                .collect(reward);
                          }
                        : null,
                  )
                : null,
          ),
          secondaryActions: [
            IconSlideAction(
              caption: "Изменить",
              color: CustomColors.orange,
              icon: Icons.edit,
              onTap: () async {
                var updatedReward = await showModalBottomSheet<Reward?>(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => RewardModal(
                    initial: reward,
                  ),
                );
                if (updatedReward != null) {
                  await context
                      .read(rewardControllerProvider)
                      .update(updatedReward);
                }
              },
            ),
            IconSlideAction(
              caption: "Удалить",
              color: CustomColors.red,
              icon: Icons.delete,
              onTap: () {
                context.read(rewardControllerProvider).delete(reward);
              },
            ),
          ],
          actionPane: SlidableDrawerActionPane(),
        ),
      ],
    );
  }
}
