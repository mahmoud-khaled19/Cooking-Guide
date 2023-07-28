import 'package:flutter/material.dart';

import 'empty_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const EmptyScreen(text: 'start Searching Now 🔎', image: 'assets/images/search.png');
  }
}
