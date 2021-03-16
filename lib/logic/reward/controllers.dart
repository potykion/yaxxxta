import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/reward/db.dart';
import 'package:yaxxxta/logic/reward/models.dart';
import 'package:yaxxxta/logic/reward/services.dart';

/// Контроллер наград
class RewardController extends StateNotifier<List<Reward>> {
  /// Репо наград
  final RewardRepo repo;

  /// Создает награду
  final CreateReward createReward;

  /// Контроллер наград
  RewardController({
    required this.repo,
    required this.createReward,
    List<Reward> state = const <Reward>[],
  }) : super(state);

  /// Грузит награды юзера
  Future<void> load(List<String> userRewardIds) async {
    state = await repo.listByIds(userRewardIds);
  }

  /// Создает награду юзера
  Future<void> create(Reward reward) async {
    state = [...state, await createReward(reward)];
  }
}
