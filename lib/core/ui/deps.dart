import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/all.dart';
import '../infra/push.dart';

/// Регает индекс выбранной странички
StateProvider<int> pageIndexProvider = StateProvider((_) => 0);

/// Плагин для отправки локальных пушей
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Регает плагин для отправки локальных пушей
Provider<FlutterLocalNotificationsPlugin>
    flutterLocalNotificationsPluginProvider =
    Provider((_) => flutterLocalNotificationsPlugin);

/// Провайдер отправщика уведомлений
Provider<NotificationSender> notificationSender = Provider(
  (ref) =>
      NotificationSender(ref.watch(flutterLocalNotificationsPluginProvider)),
);

/// АЙдишник открытой странички
/// Используется для получения контекста страницы, после вызова Navigator.pop
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
