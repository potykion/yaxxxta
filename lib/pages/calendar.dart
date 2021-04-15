import 'package:flutter/material.dart';
import 'package:yaxxxta/widgets/bottom_nav.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("CalendarPage")),
      bottomNavigationBar: MyBottomNav(),
    );
  }
}
