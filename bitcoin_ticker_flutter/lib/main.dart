import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light(
          primary: Colors.lightBlue,
          background: Colors.white,
        ),
      ),
      home: const PriceScreen(),
    );
  }
}
