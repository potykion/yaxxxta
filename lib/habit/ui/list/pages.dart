import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../core/ui/widgets/bottom_nav.dart';

/// Страница со списком привычек
class HabitListPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("heyyy")),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}
