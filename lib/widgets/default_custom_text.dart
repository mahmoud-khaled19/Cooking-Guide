import 'package:flutter/material.dart';
import '../utils/values_manager.dart';

class DefaultCustomText extends StatelessWidget {
  const DefaultCustomText({
    Key? key,
    required this.text,
    this.maxLines,
    this.fontSize,
    this.alignment,
    this.color,
    this.fontWeight,
  }) : super(key: key);
  final String text;
  final int? maxLines;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: alignment ?? Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: fontSize ?? AppSize.s12,
                fontWeight: fontWeight ?? FontWeight.bold,
            color: color
              ),
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
