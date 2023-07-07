import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fonts_manager.dart';


TextStyle getRegularStyle({
  required double fontSize,
  required Color color,
}) {
  return GoogleFonts.akshar(
      fontSize: fontSize, fontWeight: FontWeightManager.regular, color: color);
}

TextStyle getMediumStyle({
  required double fontSize,
  required Color color,
}) {
  return GoogleFonts.akshar(
      fontSize: fontSize, fontWeight: FontWeightManager.medium, color: color);
}

TextStyle getLightStyle({
  required double fontSize,
  required Color color,
}) {
  return GoogleFonts.akshar(
      fontSize: fontSize, fontWeight: FontWeightManager.light, color: color);
}

TextStyle getSemiBoldStyle({
  required double fontSize,
  required Color color,
}) {
  return GoogleFonts.akshar(
      fontSize: fontSize, fontWeight: FontWeightManager.semiBold, color: color);
}

TextStyle getBoldStyle({
  required double fontSize,
  required Color color,
}) {
  return GoogleFonts.akshar(
      fontSize: fontSize, fontWeight: FontWeightManager.bold, color: color);
}
