import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yaxxxta/stubs.dart';
import 'package:yaxxxta/widgets.dart';

class HabitListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: kToolbarHeight),
              DateScroll(),
            ],
          ),
        ),
        body: ListView(
          children: [
            for (var vm in vms)
              SizedBox(
                height: 130,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) =>
                      HabitCard(vm: vm, repeatIndex: index),
                  itemCount: vm.repeats.length,
                ),
              )
          ],
        ),
      );
}
