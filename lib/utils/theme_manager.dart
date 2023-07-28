import 'package:flutter/material.dart';
import 'package:food_app/utils/style_manager.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors_manager.dart';

ThemeData getLightApplicationTheme() {
  return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
        ColorsManager.lightIconsColor,
      ))),
      appBarTheme: AppBarTheme(
        centerTitle: true,
          titleTextStyle: GoogleFonts.alegreya(
              color: Colors.white, fontSize: AppSize.s16, letterSpacing: 0.6),
          backgroundColor: ColorsManager.lightScaffoldColor,
          elevation: 0,
          iconTheme: IconThemeData(color: ColorsManager.black,size: AppSize.s18)),
      drawerTheme:
          DrawerThemeData(backgroundColor: ColorsManager.lightScaffoldColor),
      iconTheme: IconThemeData(
          color: ColorsManager.lightIconsColor, size: AppSize.s24),
      scaffoldBackgroundColor: ColorsManager.lightScaffoldColor,
      primarySwatch: Colors.grey,
      splashColor: ColorsManager.lightIconsColor,
      primaryColor: ColorsManager.lightCardColor,
      disabledColor: ColorsManager.grey,
      cardColor: ColorsManager.lightCardColor,

      textTheme: TextTheme(
          titleLarge: getSemiBoldStyle(
              fontSize: AppSize.s16, color: ColorsManager.black),
          ///titles
          titleMedium:
              getMediumStyle(fontSize: AppSize.s14, color: ColorsManager.black),
          /// buttons
          titleSmall: getRegularStyle(
              fontSize: AppSize.s12, color: ColorsManager.black)),
      brightness: Brightness.light);
}

ThemeData getDarkApplicationTheme() {
  return ThemeData(
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
        ColorsManager.darkIconsColor,
      ))),
      appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: ColorsManager.darkScaffoldColor,
          elevation: 0,
          titleTextStyle: GoogleFonts.alegreya(
              color: Colors.white, fontSize: AppSize.s16, letterSpacing: 0.6)),
      drawerTheme:
          DrawerThemeData(backgroundColor: ColorsManager.darkScaffoldColor),
      colorScheme:
          ColorScheme.dark(background: ColorsManager.lightBackgroundColor),
      iconTheme:
          IconThemeData(color: ColorsManager.darkIconsColor, size: AppSize.s24),
      scaffoldBackgroundColor: ColorsManager.darkScaffoldColor,
      primarySwatch: Colors.grey,
      splashColor: ColorsManager.darkIconsColor,
      primaryColor: ColorsManager.darkCardColor,
      disabledColor: ColorsManager.grey,
      cardColor: ColorsManager.darkCardColor,
      textTheme: TextTheme(
          titleLarge: getSemiBoldStyle(
              fontSize: AppSize.s16, color: ColorsManager.lightScaffoldColor),
          titleMedium: getMediumStyle(
              fontSize: AppSize.s14, color: ColorsManager.lightScaffoldColor),
          titleSmall: getRegularStyle(
              fontSize: AppSize.s12, color: ColorsManager.lightScaffoldColor)),
      brightness: Brightness.dark);
}
