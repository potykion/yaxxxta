import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yaxxxta/logic/habit/db.dart';
import 'package:yaxxxta/logic/habit/models.dart';
import 'package:yaxxxta/logic/habit/state/calendar.dart';
import 'package:yaxxxta/logic/habit/vms.dart';
import 'package:yaxxxta/logic/notifications/daily.dart';
import 'package:yaxxxta/logic/notifications/models.dart';

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
        ),
      ),
    );
  });

  group("Тестируем скедулинг уведомлений", () {
    test("Ежедневная привычка без заскедуленых уведомлений", () async {
      var notifications = <HabitNotification>[];
      HabitPerformNotificationService habitPerformNotificationService =
          FakeHabitPerformNotificationService();
      FirebaseHabitRepo habitRepo = FakeHabitRepo();
      FirebaseHabitPerformingRepo habitPerformingRepo =
          FakeHabitPerformingRepo();

      var habit = Habit(
        id: "1",
        title: '',
        order: 1,
        userId: '',
        notification: HabitNotificationSettings(
          time: DateTime(2020, 1, 1, 13),
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


      when(() => habitPerformNotificationService.remove(any()))
          .thenAnswer((_) async {});
      when(() => habitPerformNotificationService.removeByHabitId(any()))
          .thenAnswer((_) async {});
      when(() => habitPerformNotificationService
          .removeNotificationsWithoutHabitId()).thenAnswer((_) async {});
      var newNotificationId = 2;
      when(() => habitPerformNotificationService.create(habit, any()))
          .thenAnswer((_) async {
        notifications
            .add(HabitNotification(id: newNotificationId, habitId: habit.id!));
        return newNotificationId;
      });
      when(() => habitPerformNotificationService.getPending())
          .thenAnswer((_) async => notifications);
      when(() => habitPerformNotificationService.getPendingWithHabitId())
          .thenAnswer((_) async => notifications);
      when(() => habitRepo.update(any())).thenAnswer((_) async {});

      await container
          .read(habitCalendarStateProvider.notifier)
          .scheduleNotificationsForHabitsWithoutNotifications();

      var pending = await container
          .read(habitCalendarStateProvider.notifier)
          .habitPerformNotificationService
          .getPending();

      expect(
        pending.where((n) => n.habitId == habit.id).isNotEmpty,
        true,
      );
    });
  });
}
