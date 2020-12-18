import 'package:flutter/material.dart';
import 'Splash.dart';
import 'file:///D:/FlutterProject/To%20Do%20App/lib/ui/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),);
      }

    }
    
