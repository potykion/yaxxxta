import 'package:yaxxxta/logic/core/utils/compare.dart';
import 'package:meta/meta.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:yaxxxta/logic/reward/db.dart';
import 'package:yaxxxta/logic/reward/models.dart';
import 'package:yaxxxta/logic/reward/services.dart';
import 'package:yaxxxta/logic/user/controllers.dart';

/// Контроллер наград
class RewardController extends StateNotifier<List<Reward>> {
  /// Репо наград
  @protected
  final RewardRepo repo;

  /// Создает награду
  @protected
  final CreateReward createReward;

  /// Получение награды
  @protected
  final CollectReward collectReward;

  /// Контроллер наград
  RewardController({
    required this.repo,
    required this.createReward,
    required this.collectReward,
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

  /// Получение награды
  Future<void> collect(Reward rewardToCollect) async {
    state = [
      for (var reward in state)
        reward.id == rewardToCollect.id
            ? await collectReward(rewardToCollect)
            : reward
    ];
  }

  /// Обновляет награду
  Future<void> update(Reward rewardToUpdate) async {
    await repo.update(rewardToUpdate);
    state = [
      for (var reward in state)
        reward.id == rewardToUpdate.id ? rewardToUpdate : reward
    ];
  }

  /// Удаляет награду
  Future<void> delete(Reward rewardToDelete) async {
    await repo.deleteById(rewardToDelete.id!);
    state = [
      for (var reward in state)
        if (reward.id != rewardToDelete.id) reward
    ];
  }
}

var _addRewardToUserProvider = Provider(
  (ref) => ref.watch(userDataControllerProvider.notifier).addReward,
);
var _decreasePerformingPointsProvider = Provider(
  (ref) =>
      ref.watch(userDataControllerProvider.notifier).decreasePerformingPoints,
);

/// Провайдер RewardController
StateNotifierProvider<RewardController, List<Reward>> rewardControllerProvider =
    StateNotifierProvider<RewardController, List<Reward>>(
  (ref) {
    var repo = ref.watch(rewardRepoProvider);
    return RewardController(
      repo: repo,
      createReward: CreateReward(
        rewardRepo: repo,
        addRewardToUser: ref.watch(_addRewardToUserProvider),
      ),
      collectReward: CollectReward(
        decreasePerformingPoints: ref.watch(_decreasePerformingPointsProvider),
        rewardRepo: repo,
      ),
    );
  },
);

/// Награды, отсортированные по получению и возможности получения
ProviderFamily<List<Reward>, int> sortedRewardsProvider =
    Provider.family<List<Reward>, int>(
  (ref, userPerformingPoints) => ref.watch(rewardControllerProvider)
    ..sort(
      (r1, r2) =>
          Tuple2<bool, int>(r1.collected, -(userPerformingPoints - r1.cost))
              .compareTo(
        Tuple2<bool, int>(r2.collected, -(userPerformingPoints - r2.cost)),
      ),
    ),
);
