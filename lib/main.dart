import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculatrice Scientifique',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      icon: Image.asset('assets/l.png'), 
      home: SplashScreen(),
    );
  }
}