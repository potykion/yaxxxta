import 'package:flutter/material.dart';

import '../../../theme.dart';

class RegularAppBar extends PreferredSize {
  final Widget child;

  const RegularAppBar({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Container(
          color: CustomColors.yellow,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: kToolbarHeight),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: child,
              ),
            ],
          ),
        ),
      );
}
