import 'package:flutter/material.dart';

class SmallPadding extends StatelessWidget {
  final Widget child;

  const SmallPadding({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 5), child: child);
}
