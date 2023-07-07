import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:payment_application/utils/strings_manager.dart';
import 'package:payment_application/utils/theme_manager.dart';
import 'package:payment_application/view/splash_screen.dart';
import 'package:payment_application/view_model/boxes.dart';
import 'package:payment_application/view_model/person.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  personBox = await Hive.openBox<Person>('personBox');
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
          theme: getDarkApplicationTheme(),
          home: const SplashScreen(),
        );
      },
    );
  }
}
