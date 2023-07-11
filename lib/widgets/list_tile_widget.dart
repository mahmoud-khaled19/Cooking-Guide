import 'package:flutter/material.dart';
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
    return ListTile(
      title: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      leading: Icon(
        icon,
        color: Theme.of(context).splashColor,
      ),
      onTap: function,
    );
  }
}
