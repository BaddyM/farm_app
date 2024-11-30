import 'package:farm_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:farm_app/screens/login.dart';
import 'package:farm_app/screens/register.dart';
import 'package:flutter/services.dart';

void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var title = "My Farm";
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: Colors.lightGreenAccent,
        useMaterial3: true,
      ),
      home: FarmHome(title: title,),
    );
  }
}
