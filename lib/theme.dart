import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class CustomColors {
  static const Color red = const Color(0xffFFADAD);
  static const Color orange = const Color(0xffFFD6A5);
  static const Color yellow = const Color(0xffFDFFB6);
  static const Color green = const Color(0xffCAFFBF);
  static const Color cyan = const Color(0xff9BF6FF);
  static const Color blue = const Color(0xffA0C4FF);
  static const Color purple = const Color(0xffBDB2FF);
  static const Color pink = const Color(0xffFFC6FF);
  static const Color almostBlack = const Color(0xff3D3A4B);
  static const Color lightGrey = const Color(0xffFAFAFA);
  static const Color grey = const Color(0xffBCBCBC);
}

ThemeData buildTheme(BuildContext context) => ThemeData(
      textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme,
      ),
    );
