import 'package:farm_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:farm_app/screens/login.dart';
import 'package:farm_app/screens/register.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async{
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var title = "My Farm";
    var version = "1.0.0";

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: const Color.fromRGBO(137,81,41,1.0),
        useMaterial3: true,
      ),
      //home: FarmHome(title: title, version: version,),
      home: FarmHome(title: title,version: version)
    );
  }
}
