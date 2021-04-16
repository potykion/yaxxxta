import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/db.dart';
import 'package:yaxxxta/logic/habit/models.dart';

class HabitController extends StateNotifier<List<Habit>> {
  final FirebaseHabitRepo repo;

  HabitController(this.repo) : super([]);

  Future<void> load(String userId) async {
    state = await repo.listByUserId(userId);
  }

  Future<void> create(Habit habit) async {
    await repo.insert(habit);
    state = [...state, habit];
  }
}

var habitControllerProvider =
    StateNotifierProvider<HabitController, List<Habit>>(
  (ref) => HabitController(
    FirebaseHabitRepo(
      FirebaseFirestore.instance.collection("FirebaseHabitRepo"),
    ),
  ),
);
