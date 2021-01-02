import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/all.dart';

/// Регает индекс выбранной странички
StateProvider<int> pageIndexProvider = StateProvider((_) => 0);

/// Плагин для отправки локальных пушей
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Регает плагин для отправки локальных пушей
Provider<FlutterLocalNotificationsPlugin>
    flutterLocalNotificationsPluginProvider =
    Provider((_) => flutterLocalNotificationsPlugin);

var navigatorKey = GlobalKey<NavigatorState>();
