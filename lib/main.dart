import 'package:farm_app/models/database_service.dart';
import 'package:farm_app/screens/chicks.dart';
import 'package:farm_app/screens/flock.dart';
import 'package:farm_app/screens/home.dart';
import 'package:farm_app/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:farm_app/screens/login.dart';
import 'package:farm_app/screens/register.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import "package:farm_app/models/database_service.dart";

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final DatabaseService _databaseService = DatabaseService.instance;
    _databaseService.getDatabase();

    var title = "My Farm";
    var version = "1.0.0";

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          primaryColor: const Color.fromRGBO(137, 81, 41, 1.0),
          useMaterial3: true,
        ),
        //home: FarmHome(title: title, version: version,),
        home: FarmHome(title: title, version: version),
      routes: <String, WidgetBuilder>{
          "userProfile":(BuildContext context) => const UserProfile(),
          "chicks":(BuildContext context) => const FarmChicks(),
        "flock":(BuildContext context) => const FarmFlock(),
      },
    );
  }
}
