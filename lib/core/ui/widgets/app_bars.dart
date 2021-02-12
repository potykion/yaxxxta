import 'package:flutter/material.dart';

import '../../../theme.dart';

/// Создает апп бар
PreferredSize buildAppBar({Widget child}) => PreferredSize(
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
