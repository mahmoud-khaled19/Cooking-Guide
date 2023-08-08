import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getRegularStyle({
  required double fontSize,
  required Color color,
}) {
  return GoogleFonts.aBeeZee(
      fontSize: fontSize, fontWeight: FontWeightManager.regular, color: color);
}

TextStyle getMediumStyle({
  required double fontSize,
  required Color color,
}) {
  return GoogleFonts.ptSerif(
      fontSize: fontSize, fontWeight: FontWeightManager.medium, color: color);
}

TextStyle getLightStyle({
  required double fontSize,
  required Color color,
}) {
  return GoogleFonts.ptSerif(
      fontSize: fontSize, fontWeight: FontWeightManager.light, color: color);
}

TextStyle getSemiBoldStyle({
  required double fontSize,
  required Color color,
}) {
  return GoogleFonts.ptSerif(
      fontSize: fontSize, fontWeight: FontWeightManager.semiBold, color: color);
}

TextStyle getBoldStyle({
  required double fontSize,
  required Color color,
}) {
  return GoogleFonts.ptSerif(
      fontSize: fontSize, fontWeight: FontWeightManager.bold, color: color);
}

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
