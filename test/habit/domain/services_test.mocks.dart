// Mocks generated by Mockito 5.0.1 from annotations
// in yaxxxta/test/habit/domain/services_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:flutter_local_notifications/src/platform_specifics/android/notification_details.dart'
    as _i2;
import 'package:flutter_local_notifications_platform_interface/src/types.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:yaxxxta/core/infra/push.dart' as _i3;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeAndroidNotificationDetails extends _i1.Fake
    implements _i2.AndroidNotificationDetails {}

/// A class which mocks [NotificationSender].
///
/// See the documentation for Mockito's code generation for more information.
class MockNotificationSender extends _i1.Mock
    implements _i3.NotificationSender {
  MockNotificationSender() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AndroidNotificationDetails get timeProgressNotification =>
      (super.noSuchMethod(Invocation.getter(#timeProgressNotification),
              returnValue: _FakeAndroidNotificationDetails())
          as _i2.AndroidNotificationDetails);
  @override
  _i4.Future<int> schedule(
          {String? title,
          String? body,
          int? sendAfterSeconds,
          _i2.AndroidNotificationDetails? androidChannel,
          bool? repeatDaily = false,
          bool? repeatWeekly = false,
          String? payload}) =>
      (super.noSuchMethod(
          Invocation.method(#schedule, [], {
            #title: title,
            #body: body,
            #sendAfterSeconds: sendAfterSeconds,
            #androidChannel: androidChannel,
            #repeatDaily: repeatDaily,
            #repeatWeekly: repeatWeekly,
            #payload: payload
          }),
          returnValue: Future.value(0)) as _i4.Future<int>);
  @override
  _i4.Future<void> cancel(int? id) =>
      (super.noSuchMethod(Invocation.method(#cancel, [id]),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<List<_i5.PendingNotificationRequest>> getAllPending() =>
      (super.noSuchMethod(Invocation.method(#getAllPending, []),
              returnValue: Future.value(<_i5.PendingNotificationRequest>[]))
          as _i4.Future<List<_i5.PendingNotificationRequest>>);
}