import 'package:flutter/material.dart';
import 'package:techcity/screen/calculator_screen.dart';
import 'package:techcity/screen/twitter_auth_screen.dart';

import 'note/counter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TechCity",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const CartScreen(),
    );
  }
}
