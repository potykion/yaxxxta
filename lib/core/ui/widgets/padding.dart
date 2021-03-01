import 'package:flutter/material.dart';

/// Маленький отступ
class SmallPadding extends StatelessWidget {
  /// Куда вешать отсут
  final Widget child;

  /// Маленький отступ
  const SmallPadding({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 10,
        ),
        child: child,
      );
}
