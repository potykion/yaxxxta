import 'package:flutter/material.dart';

import '../../../theme.dart';

/// Круглый прогресс в центре
class CenteredCircularProgress extends StatelessWidget {
  /// Круглый прогресс в центре
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(CustomColors.almostBlack),
        ),
      );
}
