import 'package:flutter/material.dart';
import '../view/favourites_screen.dart';
import '../view/home_screen.dart';
import '../view/search_screen.dart';
import '../view/settings_screen.dart';

class HomeLayoutViewModel {
  static List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
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
