import 'package:flutter/material.dart';
import 'package:food_app/widgets/default_custom_text.dart';
class ListTileWidget extends StatelessWidget {
  const ListTileWidget(
      {Key? key,
      required this.text,
      required this.function,
      required this.icon})
      : super(key: key);
  final String text;
  final IconData icon;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).splashColor,
      ),
      child: ListTile(
        title: DefaultCustomText(
          text: text,
        ),
        leading: Icon(
          icon,
          color: Theme.of(context).splashColor,
        ),
        onTap: function,
      ),
    );
  }
}
