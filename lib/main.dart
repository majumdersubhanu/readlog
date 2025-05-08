import 'package:flutter/material.dart';
import 'package:readlog/home_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReadLog',
      initialRoute: '/',
      routes: {'/': (context) => const HomeScreen()},
    );
  }
}
