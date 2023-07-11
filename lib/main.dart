import 'package:flutter/material.dart';
import 'package:food_app/utils/strings_manager.dart';
import 'package:food_app/utils/theme_manager.dart';
import 'package:food_app/view/random_meal_screen.dart';
import 'package:food_app/view/splash_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appTitle,
          theme: getLightApplicationTheme(),
          home: const SplashScreen(),
        );
      },
    );
  }
}
