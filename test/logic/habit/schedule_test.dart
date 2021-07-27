import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yaxxxta/logic/habit/db.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/logic/notifications/daily.dart';

class FakeHabitPerformNotificationService extends Mock
    implements HabitPerformNotificationService {}

class FakeHabitRepo extends Mock implements FirebaseHabitRepo {}

class FakeHabitPerformingRepo extends Mock
    implements FirebaseHabitPerformingRepo {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      Habit(
        title: 'test',
        order: 2,
        userId: '',
        notification: HabitNotificationSettings(
          time: DateTime(2020, 1, 1, 13),
          id: 1,
        ),
      ),
    );
  });

  group("Тестируем скедулинг уведомлений", () {
    test("Ежедневная привычка без заскедуленых уведомлений", () async {
      HabitPerformNotificationService habitPerformNotificationService =
          FakeHabitPerformNotificationService();
      FirebaseHabitRepo habitRepo = FakeHabitRepo();
      FirebaseHabitPerformingRepo habitPerformingRepo =
          FakeHabitPerformingRepo();

      var habit = Habit(
        title: '',
        order: 1,
        userId: '',
        notification: HabitNotificationSettings(
          time: DateTime(2020, 1, 1, 13),
          id: 1,
        ),
      );
      final container = ProviderContainer(
        overrides: [
          habitCalendarStateProvider.overrideWithValue(
            HabitCalendarState(
              habitRepo,
              habitPerformingRepo,
              habitPerformNotificationService,
              [
                HabitVM(habit: habit),
              ],
            ),
          )
        ],
      );
      addTearDown(container.dispose);

      when(() => habitPerformNotificationService.pending())
          .thenAnswer((_) async => <int>[]);
      when(() => habitPerformNotificationService.remove(any()))
          .thenAnswer((_) async {});
      var newNotificationId = 2;
      when(() => habitPerformNotificationService.create(habit, any()))
          .thenAnswer((_) async => newNotificationId);
      when(() => habitRepo.update(any())).thenAnswer((_) async {});

      await container
          .read(habitCalendarStateProvider.notifier)
          .scheduleNotificationsForHabitsWithoutNotifications();

      expect(
        container.read(habitCalendarStateProvider).first.habit.notification!.id,
        newNotificationId,
      );
    });
  });
}
