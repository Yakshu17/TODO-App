import 'dart:async';
import 'package:flutter/material.dart';
import 'package:todoapp/Screens/HomeScreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>const HomeScreen(),
          ));
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image.asset("assets/images/to-do-list.png", fit: BoxFit.cover,height: 250,width: 250,)),
    );
  }
}
