import 'package:flutter/material.dart';

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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color ?? Theme.of(context).splashColor,
      ),

      width: width ?? AppSize.s70,
      child: TextButton(
        onPressed: function,
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
