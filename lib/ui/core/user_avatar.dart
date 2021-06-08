import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser?.photoURL != null
        ? CircleAvatar(
      backgroundImage: NetworkImage(
        FirebaseAuth.instance.currentUser!.photoURL!,
      ),
    )
        : Icon(Icons.account_circle);
  }
}
