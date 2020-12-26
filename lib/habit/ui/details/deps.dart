import 'package:get/get.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../deps.dart';
import 'controllers.dart';

var habitDetailsController = StateNotifierProvider((ref) {
  var controller = HabitDetailsController(
    habitRepo: ref.watch(habitRepoProvider),
    habitPerformingRepo: ref.watch(habitPerformingRepoProvider),
    createPerforming: ref.watch(createPerforming),
  );
  controller.load(Get.arguments as int);
  return controller;
});

ScopedProvider<int> repeatIndexProvider = ScopedProvider<int>(null);
