import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/core/provider/list_provider.dart';
import 'package:to_do/home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String routeName = "splash_screen";

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<ListProvider>(context);
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Image.asset(
        appProvider.splashScreen(),
        width: mediaQuery.width,
        height: mediaQuery.height,
        fit: BoxFit.cover,
      ),
    );
  }
}
