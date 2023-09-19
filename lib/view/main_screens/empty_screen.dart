import 'package:flutter/material.dart';
import 'package:food_app/utils/values_manager.dart';
import 'package:food_app/widgets/default_custom_text.dart';

class EmptyScreen extends StatelessWidget {
  final String text;
  final String image;

  const EmptyScreen({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: size * 0.4,
            width: size * 0.8,
          ),
          SizedBox(
            height: AppSize.s30,
          ),
          Center(
            child: DefaultCustomText(
              text: text,
              alignment: Alignment.center,
              fontSize: AppSize.s20,
              color: Theme.of(context).splashColor,
            ),
          )
        ],
      ),
    );
  }
}
