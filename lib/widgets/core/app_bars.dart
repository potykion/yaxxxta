import 'package:flutter/material.dart';

import '../../theme.dart';

/// Создает апп бар
PreferredSize buildAppBar({
  required BuildContext context,
  required List<Widget> children,
}) {
  var appBarHeight = 130.0;
  var statusBarHeight = MediaQuery.of(context).padding.top;

  return PreferredSize(
    preferredSize: Size.fromHeight(appBarHeight),
    child: Container(
      color: CustomColors.yellow ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: statusBarHeight),
          SizedBox(
            height: 60,
            child: Row(children: children),
          ),
        ],
      ),
    ),
  );
}
