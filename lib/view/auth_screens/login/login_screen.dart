import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_app/view/auth_screens/login/login_body.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var animatePath = "assets/images/bear.riv";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<double>? lookAtNumber;
  Artboard? artBoard;
  late StateMachineController? controller;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    log('rebuild animation Screen');

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * 0.2,
              width: screenWidth * 0.85,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: RiveAnimation.asset(
                animatePath,
                fit: BoxFit.cover,
                onInit: (artBoard) {
                  controller = StateMachineController.fromArtboard(
                    artBoard,
                    "Login Machine",
                  );
                  if (controller == null) return;
                  artBoard.addController(controller!);
                  isChecking = controller?.findInput("isChecking");
                  lookAtNumber = controller?.findInput("numLook");
                  isHandsUp = controller?.findInput("isHandsUp");
                  trigFail = controller?.findInput("trigFail");
                  trigSuccess = controller?.findInput("trigSuccess");
                },
              ),
            ),
            LoginBody(
              emailChangedFunction: (value) => lookAtNumber?.change(
                value!.length.toDouble(),
              ),
              emailController: emailController,
              passwordController: passwordController,
              passFocusNode: passwordFocusNode,
              emailFocusNode: emailFocusNode,
            )
          ],
        ),
      ),
    );
  }
}
