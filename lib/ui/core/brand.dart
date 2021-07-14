import 'package:flutter/material.dart';
import 'package:yaxxxta/theme.dart';
import 'package:yaxxxta/ui/core/text.dart';

/// Логотип
class Brand extends StatelessWidget {
  /// Логотип
  const Brand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Headline5(
      "Яхта",
      style: TextStyle(
        color: CoreColors.white,
        fontFamily: "mr_DopestyleG",
        fontWeight: FontWeight.normal,
      ),
      center: true,
    );
  }
}
