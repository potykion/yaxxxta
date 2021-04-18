import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yaxxxta/logic/habit/controllers.dart';
import 'package:yaxxxta/widgets/bottom_nav.dart';

import '../routes.dart';

class ListHabitPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var vms = useProvider(habitVMsProvider);

    return Scaffold(
      body: ListView.builder(
        itemCount: vms.length,
        itemBuilder: (_, index) => ListTile(
          title: Text(vms[index].habit.title),
          onTap: () => Navigator.pushReplacementNamed(
            context,
            Routes.calendar,
            arguments: index,
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNav(),
    );
  }
}
