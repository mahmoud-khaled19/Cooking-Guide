import 'package:flutter/material.dart';
import '../../widgets/default_custom_text.dart';

class MealItemComponents extends StatelessWidget {
  const MealItemComponents(
      {Key? key, required this.item1, required this.quantity1})
      : super(key: key);
  final String item1;
  final String quantity1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).cardColor,
            Theme.of(context).splashColor,
            Theme.of(context).scaffoldBackgroundColor,
          ],
        ),
      ),
      child: Row(
        children: [
          DefaultCustomText(
            text: item1,
          ),
          const Spacer(),
          DefaultCustomText(
            text: quantity1,
          ),
        ],
      ),
    );
  }
}
