import 'package:flutter/material.dart';
import '../../utils/values_manager.dart';
import '../../widgets/default_custom_text.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({
    Key? key,
    required this.function,
    required this.text,
    required this.length,
  }) : super(key: key);
  final Function() function;
  final String text;
  final int length;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: AppSize.s100,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.only(right: 10),
        child: DefaultCustomText(
          alignment: Alignment.center,
          text: text,
        ),
      ),
    );
  }
}
