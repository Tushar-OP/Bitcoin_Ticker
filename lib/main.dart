import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color.fromRGBO(16, 24, 32, 1),
        scaffoldBackgroundColor: Color.fromRGBO(254, 231, 21, 1),
      ),
      home: PriceScreen(),
    );
  }
}
