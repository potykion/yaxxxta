import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaxxxta/logic/reward/controllers.dart';
import 'package:yaxxxta/logic/reward/models.dart';
import 'package:yaxxxta/widgets/core/card.dart';
import 'package:yaxxxta/widgets/core/text.dart';

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
        ListTile(
          title: BiggerText(
            text: reward.title,
            decoration: reward.collected ? TextDecoration.lineThrough : null,
            color: reward.collected ? CustomColors.grey : null,
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
      ],
    );
  }
}
