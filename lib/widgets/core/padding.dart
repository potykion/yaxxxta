import 'package:flutter/material.dart';

/// Маленький отступ
class SmallPadding extends StatelessWidget {
  /// Куда вешать отсут
  final Widget child;

  /// Отступ слева
  final double leftPadding;

  /// Отступ справа
  final double rightPadding;

  /// Отступ снизу
  final double bottomPadding;

  /// Маленький отступ
  const SmallPadding({
    Key? key,
    required this.child,
    this.leftPadding = 15,
    this.rightPadding = 15,
    this.bottomPadding = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          left: leftPadding,
          right: rightPadding,
          bottom: bottomPadding,
        ),
        child: child,
      );

  /// Маленький отступ без отступа внизу
  factory SmallPadding.noBottom({Widget? child}) => SmallPadding(
        child: child ?? Container(),
        bottomPadding: 0,
      );

  /// Маленький отступ только внизу
  factory SmallPadding.onlyBottom({Widget? child}) => SmallPadding(
        child: child ?? Container(),
        leftPadding: 0,
        rightPadding: 0,
      );

  /// Маленький отспуп между виджетами
  factory SmallPadding.between({Widget? child}) => SmallPadding(
        child: child ?? Container(),
        rightPadding: 10,
        leftPadding: 0,
        bottomPadding: 0,
      );
}
