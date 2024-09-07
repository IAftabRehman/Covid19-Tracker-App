import 'package:flutter/material.dart';
import 'package:tracker_app/View/Splash_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Center(child: Text("Covid 19", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),)),
        ),
        body: splashScreen(),
      ),
    );
  }
}
