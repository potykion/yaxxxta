import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../logic/reward/models.dart';

import '../core/buttons.dart';
import '../core/card.dart';
import '../core/input.dart';
import '../core/padding.dart';
import '../core/text.dart';

/// Модалька создания награды
class CreateRewardModal extends HookWidget {
  final Reward? initial;

  CreateRewardModal({this.initial});

  @override
  Widget build(BuildContext context) {
    var rewardState = useState(initial ?? Reward(title: "", cost: 1));
    setReward(Reward reward) => rewardState.value = reward;
    var reward = rewardState.value;

    return ContainerCard(
      children: [
        ListTile(title: BiggerText(text: "Название награды"), dense: true),
        SmallPadding(
          child: TextInput<String>(
            initial: reward.title,
            change: (dynamic v) =>
                setReward(reward.copyWith(title: v as String)),
          ),
        ),
        ListTile(title: BiggerText(text: "Стоимость"), dense: true),
        SmallPadding(
          child: TextInput<int>(
            initial: reward.cost,
            change: (dynamic v) => setReward(reward.copyWith(cost: v as int)),
            suffix: BiggerText(text: "🅿"),
          ),
        ),
        SmallPadding(
          child: FullWidthButton(
            onPressed: () => Navigator.of(context).pop(reward),
            child: BiggerText(text: "Сохранить"),
          ),
        ),
      ],
    );
  }
}
