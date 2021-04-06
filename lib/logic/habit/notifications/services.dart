import 'db.dart';

class DeletePendingNotifications {
  final HabitNotificationRepo _repo;

  DeletePendingNotifications(this._repo);

  Future<void> call(String habitId) async {
    var pending = (await _repo.getPending())
        .where((n) => n.habitId == habitId)
        .map((n) => n.id);
    await Future.wait(pending.map(_repo.cancel));
  }
}
