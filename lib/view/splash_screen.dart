import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/assets_manager.dart';
import '../utils/values_manager.dart';
import '../widgets/default_custom_text.dart';
import 'auth_screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 800,
      splash: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
                image: AssetImage(
              ImagesManager.splashScreen,
            )),
            SizedBox(
              height: AppSize.s20,
            ),
            const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultCustomText(text: 'Developed By : Mahmoud Khaled')
                ]),
          ],
        ),
      ),
      nextScreen:  LoginScreen(),
      splashTransition: SplashTransition.slideTransition,
      backgroundColor: Theme.of(context).cardColor,
    );
  }
}
