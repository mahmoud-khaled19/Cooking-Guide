import 'package:flutter/material.dart';
import 'package:food_app/view/main_screens/userInfo_screen.dart';
import '../view/main_screens/favourites_screen.dart';
import '../view/main_screens/home_screen.dart';
import '../view/main_screens/search_screen.dart';

class HomeLayoutViewModel {
  static List<Widget> screens = [
    const HomeScreen(),
    SearchScreen(),
    const FavouritesScreen(),
    const UserInfoScreen(),
  ];
   static List<String> screensTitle = [
    'Home Screen',
    'Search Screen',
    'Favourite Screen',
    'User Info Screen',
  ];
}
