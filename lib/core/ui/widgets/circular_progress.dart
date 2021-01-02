import 'package:flutter/material.dart';

import '../../../theme.dart';

class CenteredCircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(CustomColors.almostBlack),
        ),
      );
}
