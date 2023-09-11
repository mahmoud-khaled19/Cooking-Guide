import 'package:flutter/material.dart';
import 'package:food_app/utils/colors_manager.dart';
import 'package:food_app/widgets/default_custom_text.dart';

import '../utils/values_manager.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.function,
    required this.context,
    this.width,
    this.color,
  }) : super(key: key);
  final Function() function;
  final String text;
  final double? width;
  final Color? color;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? AppSize.s120,
      height: AppSize.s45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color ?? ColorsManager.lightSecondColor,
      ),
      child: TextButton(
        onPressed: function,
        child: DefaultCustomText(
          alignment: Alignment.center,
          text: text,
          color: Colors.white,
          fontSize: AppSize.s16,
        ),
      ),
    );
  }
}
