import 'db.dart';
import 'models.dart';

/// Создает награду
class CreateReward {
  /// Репо наград
  final RewardRepo rewardRepo;

  /// Привязывает награду к юзеру
  final Future<void> Function(Reward reward) addRewardToUser;

  /// Создает награду
  CreateReward({
    required this.rewardRepo,
    required this.addRewardToUser,
  });

  /// Создает награду + привязывает награду к юзеру
  Future<Reward> call(Reward reward) async {
    reward = reward.copyWith(id: await rewardRepo.insert(reward));
    await addRewardToUser(reward);
    return reward;
  }
}

/// Получение награды
class CollectReward {
  /// Репо наград
  final RewardRepo rewardRepo;

  /// Отнимает баллы у юзера
  final Future<void> Function(int points) decreasePerformingPoints;

  /// Получение награды
  CollectReward({
    required this.rewardRepo,
    required this.decreasePerformingPoints,
  });

  /// Получение награды
  Future<Reward> call(Reward reward) async {
    reward = reward.copyWith(collected: true);
    await rewardRepo.update(reward);
    await decreasePerformingPoints(reward.cost);
    return reward;
  }
}
