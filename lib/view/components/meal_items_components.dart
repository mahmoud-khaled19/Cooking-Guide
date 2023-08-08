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
      padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white60
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
