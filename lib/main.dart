
import 'package:airwisesystems/firebase_options.dart';
import 'package:airwisesystems/pantallas/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';




void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airwise-Systems',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

