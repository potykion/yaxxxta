import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:package_info/package_info.dart';
import '../../auth/services.dart';
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
Provider<NotificationSender> notificationSenderProvider = Provider(
  (ref) =>
      NotificationSender(ref.watch(flutterLocalNotificationsPluginProvider)),
);

/// АЙдишник открытой странички
/// Используется для получения контекста страницы, после вызова Navigator.pop
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Инфа о приложении
PackageInfo packageInfo;

/// Инфа о девайсе
AndroidDeviceInfo androidInfo;

/// Провайдер версии
Provider<String> versionProvider =
    Provider((ref) => "${packageInfo.version}+${packageInfo.buildNumber}");

/// Провайдер входа через гугл
Provider<SignInWithGoogle> signInWithGoogleProvider =
    Provider((_) => SignInWithGoogle());

/// Провайдер ссылки на фаер-стор коллекцию с привычками
Provider<CollectionReference> habitCollectionRefProvider = Provider(
  (_) => FirebaseFirestore.instance.collection("habits"),
);

/// Провайдер ссылки на фаер-стор коллекцию с выполнениями привычек
Provider<CollectionReference> habitPerformingCollectionRefProvider = Provider(
  (_) => FirebaseFirestore.instance.collection("habit_performings"),
);
