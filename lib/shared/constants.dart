import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kWhite = Color(0XFFfafafa);
Color kLightWhite = Color(0XFFffffff);
Color kDarkWhite = Color(0XFFc7c7c7);
Color kRed = Color(0XFFc62828);
Color kLightRed = Color(0XFFff5f52);
Color kDarkRed = Color(0XFF8e0000);

final myTextTheme = TextTheme(
  headline1: GoogleFonts.rubik(
      fontSize: 98, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.rubik(
      fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.rubik(fontSize: 49, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.rubik(
      fontSize: 35, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.rubik(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.rubik(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.rubik(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.rubik(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.poppins(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
