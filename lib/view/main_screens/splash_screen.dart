import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_app/utils/colors_manager.dart';
import 'package:food_app/utils/global_methods.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view/auth_screens/user_login_states_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<TextStyle> animation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    animationController.repeat();
    animation = TextStyleTween(
      begin: TextStyle(color: Colors.blue, fontSize: AppSize.s16),
      end: TextStyle(
          color: ColorsManager.lightSecondColor, fontSize: AppSize.s16),
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    Timer(Duration(seconds: 3), () {
      GlobalMethods.navigateAndFinish(context, UserLoginStates());
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.2,
            ),
            Image.asset(
              'assets/images/Chef-rafiki.png',
              height: screenHeight * 0.4,
              width: screenWidth * 0.85,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Center(
              child: DefaultTextStyleTransition(
                style: animation,
                child: Text(
                  'Cooking Guide,',
                ),
              ),
            ),
            SizedBox(
              height: AppSize.s8,
            ),
            DefaultTextStyleTransition(
              style: animation,
              child: Text(
                ' A Choice Will Never Regret 👌🏻',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
