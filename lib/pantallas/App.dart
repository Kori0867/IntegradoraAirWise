// lib/app.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../config/Config.dart';
import 'HomePage.dart';



class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      theme: ThemeData(
        primarySwatch: AppConfig.primaryColor,
        hintColor: AppConfig.accentColor,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


