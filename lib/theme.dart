import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class CustomColors {
  static Color red = Color(0xffFFADAD);
  static Color orange = Color(0xffFFD6A5);
  static Color yellow = Color(0xffFDFFB6);
  static Color green = Color(0xffCAFFBF);
  static Color cyan = Color(0xff9BF6FF);
  static Color blue = Color(0xffA0C4FF);
  static Color purple = Color(0xffBDB2FF);
  static Color pink = Color(0xffFFC6FF);
  static Color almostBlack = Color(0xff3D3A4B);
  static Color lightGrey = Color(0xffFAFAFA);
  static Color grey = Color(0xffBCBCBC);
}

buildTheme(context) => ThemeData(
  textTheme: GoogleFonts.montserratTextTheme(
    Theme.of(context).textTheme,
  ),
);
