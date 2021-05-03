import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../routes.gr.dart';

AppBar buildCalendarAppBar(
  BuildContext context, {
  List<Widget> extraActions = const [],
}) {
  return AppBar(
    leading: kIsWeb ? Logo() : null,
    actions: [
      UserAvatar(),
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () => AutoRouter.of(context).push(HabitFormRoute()),
      ),
      ...extraActions,
    ].reversed.toList(),
    // titleSpacing: 0,
  );
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Image(image: AssetImage("assets/icon/app_icon.png")),
      );
}

class UserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: FirebaseAuth.instance.currentUser?.photoURL != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(
                FirebaseAuth.instance.currentUser!.photoURL!,
              ),
            )
          : Icon(Icons.account_circle),
    );
  }
}
