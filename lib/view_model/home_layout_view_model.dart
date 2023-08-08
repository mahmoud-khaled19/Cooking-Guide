import 'package:flutter/material.dart';
import '../view/main_screens/favourites_screen.dart';
import '../view/main_screens/home_screen.dart';
import '../view/main_screens/settings_screen.dart';
import '../view/main_screens/search_screen.dart';

class HomeLayoutViewModel {
  static List<Widget> screens = [
    const HomeScreen(),
    SearchScreen(),
    const FavouritesScreen(),
    const SettingsScreen(),
  ];
   static List<String> screensTitle = [
    'Home Screen',
    'Search Screen',
    'Favourite Screen',
    'Settings',
  ];
}
