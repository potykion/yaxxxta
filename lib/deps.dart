import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'db.dart';

Future<void> initDeps() async {
  await Get.putAsync(() async => await Hive.openBox('habits'), tag: 'habits');
  Get.put(HabitRepo(Get.find(tag: 'habits')));
}
