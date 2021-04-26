import 'package:flutter/material.dart';
import 'package:yaxxxta/widgets/bottom_nav.dart';
import 'package:yaxxxta/widgets/web_padding.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebPadding(
      child: Scaffold(
        body: Center(
          child: Text("SettingsPage"),
        ),
        bottomNavigationBar: MyBottomNav(),

      ),
    );
  }
}
