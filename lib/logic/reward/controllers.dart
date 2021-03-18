import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/reward/db.dart';
import 'package:yaxxxta/logic/reward/models.dart';
import 'package:yaxxxta/logic/reward/services.dart';
import 'package:yaxxxta/user/ui/controllers.dart';


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
}

var _rewardRepoProvider = Provider<RewardRepo>(
  (ref) => FirebaseRewardRepo(
    FirebaseFirestore.instance.collection("rewards"),
  ),
);
var _addRewardToUserProvider = Provider(
  (ref) => ref.watch(userDataControllerProvider).addReward,
);
var _decreasePerformingPointsProvider = Provider(
  (ref) => ref.watch(userDataControllerProvider).decreasePerformingPoints,
);

/// Провайдер RewardController
StateNotifierProvider<RewardController> rewardControllerProvider =
    StateNotifierProvider(
  (ref) {
    var repo = ref.watch(_rewardRepoProvider);
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
