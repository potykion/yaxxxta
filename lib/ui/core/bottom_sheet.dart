import 'package:flutter/material.dart';
import 'package:yaxxxta/ui/core/card.dart';

Future<T?> showCoreBottomSheet<T>(
  BuildContext context,
  Widget child, {
  double height = 250,
}) =>
    showModalBottomSheet<T>(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _CoreBottomSheet(
        child: CoreCard(
          roundOnlyTop: true,
          margin: EdgeInsets.zero,
          child: child,
        ),
        height: height,
      ),
    );

class _CoreBottomSheet extends StatelessWidget {
  final Widget child;
  final double? height;

  const _CoreBottomSheet({
    Key? key,
    required this.child,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          height: height,
          child: child,
        ),
      );
}
