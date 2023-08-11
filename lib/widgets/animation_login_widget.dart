import 'package:flutter/material.dart';

class LoginAnimationWidget extends StatefulWidget {
  const LoginAnimationWidget({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  State<LoginAnimationWidget> createState() => _LoginAnimationWidget();
}

class _LoginAnimationWidget extends State<LoginAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              animationController.reset();
              animationController.forward();
            }
          });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image(
        image: AssetImage(widget.image,),
        fit: BoxFit.cover,
        height: MediaQuery.sizeOf(context).height *0.7,
        alignment: FractionalOffset(animation.value, 0),
      ),
    );
  }
}
