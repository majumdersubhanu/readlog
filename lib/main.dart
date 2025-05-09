import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      theme: ThemeData.light(useMaterial3: true).copyWith(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      routes: {'/': (context) => const HomeScreen()},
    );
  }
}
