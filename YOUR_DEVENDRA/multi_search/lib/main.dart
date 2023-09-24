import 'package:flutter/material.dart';

import 'components/home_page.dart';


void main() {
  runApp(SearchSortApp());
}

class SearchSortApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.orangeAccent)),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

