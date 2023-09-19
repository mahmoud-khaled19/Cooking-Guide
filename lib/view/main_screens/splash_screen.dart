import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_app/utils/global_methods.dart';
import 'package:food_app/utils/strings_manager.dart';
import 'package:food_app/utils/style_manager.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/view/auth_screens/user_login_states_screen.dart';
import 'package:food_app/widgets/default_custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      GlobalMethods.navigateAndFinish(context, UserLoginStates());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
       body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/Chef-rafiki.png',
                height: screenHeight * 0.4,
                width: screenWidth * 0.85,
              ),
            ),
            DefaultCustomText(
              text: 'Cooking Guide,',
              alignment: Alignment.center,
              fontSize: AppSize.s14,
              fontWeight: FontWeightManager.medium,
            ),
            DefaultCustomText(
              text: ' A Choice Will Never Regret 👌🏻',
              alignment: Alignment.center,
              fontSize: AppSize.s14,
              fontWeight: FontWeightManager.medium,
            ),
          ],
        ),
      ),
    );
  }
}
