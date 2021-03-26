import 'package:yaxxxta/logic/habit/db.dart';
import 'package:yaxxxta/logic/reward/db.dart';
import 'package:yaxxxta/logic/user/db.dart';

class FirebaseToHiveSync {
  final FirebaseUserDataRepo fbUserDataRepo;
  final FirebaseHabitRepo fbHabitRepo;
  final FirebaseHabitPerformingRepo fbHabitPerformingRepo;
  final FirebaseRewardRepo fbRewardRepo;

  final HiveUserDataRepo hiveUserDataRepo;
  final HiveHabitRepo hiveHabitRepo;
  final HiveHabitPerformingRepo hiveHabitPerformingRepo;
  final HiveRewardRepo hiveRewardRepo;

  FirebaseToHiveSync({
    required this.fbUserDataRepo,
    required this.fbHabitRepo,
    required this.fbHabitPerformingRepo,
    required this.fbRewardRepo,
    required this.hiveUserDataRepo,
    required this.hiveHabitRepo,
    required this.hiveHabitPerformingRepo,
    required this.hiveRewardRepo,
  });

  Future<void> call(String? userId) async {
    // todo userId должно быть String, а не String?
    var fbUserData = userId != null
        ? await fbUserDataRepo.getByUserId(userId)
        : await fbUserDataRepo.first();
    var fbHabits = await fbHabitRepo.listByIds(fbUserData!.habitIds);
    var fgHabitPerformings = await fbHabitPerformingRepo
        .listByHabits(fbHabits.map((h) => h.id!).toList());
    var fbRewards = await fbRewardRepo.listByIds(fbUserData.rewardIds);

    // todo
    // var hiveRewards =
  }
}
