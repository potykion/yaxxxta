import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../theme.dart';

/// Создает апп бар
PreferredSize buildAppBar({
  @required BuildContext context,
  @required List<Widget> children,
  bool transparent = false,
  bool big = false,
}) {
  var appBarHeight = 130.0;
  var statusBarHeight = MediaQuery.of(context).padding.top;

  return PreferredSize(
    preferredSize: Size.fromHeight(appBarHeight),
    child: Container(
      color: transparent ? Colors.transparent : CustomColors.yellow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: statusBarHeight),
          SizedBox(
            height: big ? null : 60,
            child: Row(children: children),
          ),
        ],
      ),
    ),
  );
}
