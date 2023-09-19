import 'package:flutter/material.dart';
import 'package:food_app/view/auth_screens/register/register_body.dart';
import 'package:rive/rive.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var animatePath = "assets/images/bear.riv";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<double>? lookAtNumber;
  Artboard? artBoard;
  late StateMachineController? controller;
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();

  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    nameFocusNode.addListener(nameFocus);
    confirmPasswordFocusNode.addListener(confirmPasswordFocus);
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    nameFocusNode.removeListener(nameFocus);
    confirmPasswordFocusNode.removeListener(confirmPasswordFocus);
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void nameFocus() {
    isChecking?.change(nameFocusNode.hasFocus);
  }

  void passwordFocus() {
    isHandsUp?.change(passwordFocusNode.hasFocus);
  }

  void confirmPasswordFocus() {
    isHandsUp?.change(confirmPasswordFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.06,
            ),
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
            RegisterBody(
              textChangedFunction: (value) => lookAtNumber?.change(
                value!.length.toDouble(),
              ),
              nameController: nameController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              emailController: emailController,
              nameFocusNode: nameFocusNode,
              emailFocusNode: emailFocusNode,
              passwordFocusNode: passwordFocusNode,
              confirmPasswordFocusNode: confirmPasswordFocusNode,
            )
          ],
        ),
      ),
    );
  }
}
