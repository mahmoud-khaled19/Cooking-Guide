import 'package:flutter/material.dart';
import 'package:food_app/utils/style_manager.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors_manager.dart';

ThemeData getLightApplicationTheme() {
  return ThemeData(
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
        ColorsManager.lightSecondColor,
      ))),
      listTileTheme: ListTileThemeData(
        iconColor: ColorsManager.darkScaffoldColor,
      ),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: GoogleFonts.alegreya(
              color: Colors.black,
              fontSize: AppSize.s16,
              letterSpacing: 0.6,
              fontWeight: FontWeightManager.bold),
          backgroundColor: ColorsManager.lightScaffoldColor,
          elevation: 0,
          iconTheme: IconThemeData(
              color: ColorsManager.darkScaffoldColor, size: AppSize.s18)),
      iconTheme: IconThemeData(
          color: ColorsManager.lightIconsColor, size: AppSize.s24),
      scaffoldBackgroundColor: ColorsManager.lightScaffoldColor,
      primarySwatch: Colors.grey,
      splashColor: ColorsManager.lightSecondColor,
      primaryColor: ColorsManager.lightCardColor,
      disabledColor: ColorsManager.grey,
      cardColor: ColorsManager.lightCardColor,
      textTheme: TextTheme(
          titleLarge: getSemiBoldStyle(
              fontSize: AppSize.s16, color: ColorsManager.black),
          titleMedium:
              getMediumStyle(fontSize: AppSize.s14, color: ColorsManager.black),
          titleSmall: getRegularStyle(
              fontSize: AppSize.s12, color: ColorsManager.black)),
      brightness: Brightness.light);
}

ThemeData getDarkApplicationTheme() {
  return ThemeData(
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
        ColorsManager.darkIconsColor,
      ))),
      listTileTheme: ListTileThemeData(
        iconColor: ColorsManager.lightScaffoldColor,
      ),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: ColorsManager.darkScaffoldColor,
          titleTextStyle: GoogleFonts.alegreya(
              color: Colors.white,
              fontSize: AppSize.s16,
              letterSpacing: 0.6,
              fontWeight: FontWeightManager.bold)),
      iconTheme: IconThemeData(
          color: ColorsManager.lightScaffoldColor, size: AppSize.s24),
      scaffoldBackgroundColor: ColorsManager.darkScaffoldColor,
      primarySwatch: Colors.grey,
      splashColor: ColorsManager.darkIconsColor,
      primaryColor: ColorsManager.darkCardColor,
      disabledColor: ColorsManager.grey,
      cardColor: ColorsManager.darkCardColor,
      textTheme: TextTheme(
          titleLarge:
              getSemiBoldStyle(fontSize: AppSize.s16, color: Colors.white),
          titleMedium:
              getMediumStyle(fontSize: AppSize.s14, color: Colors.white),
          titleSmall:
              getRegularStyle(fontSize: AppSize.s12, color: Colors.white)),
      brightness: Brightness.dark);
}
