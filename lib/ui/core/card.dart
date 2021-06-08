import 'package:flutter/material.dart';

class CoreCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsets? margin;
  final bool roundOnlyTop;

  const CoreCard({
    Key? key,
    required this.child,
    this.color,
    this.margin = const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    this.roundOnlyTop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: roundOnlyTop
            ? BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              )
            : BorderRadius.circular(32),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: child,
      ),
    );
  }
}
