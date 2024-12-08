import 'package:farm_app/models/database_service.dart';
import 'package:farm_app/screens/chicks.dart';
import 'package:farm_app/screens/flock.dart';
import 'package:farm_app/screens/home.dart';
import 'package:farm_app/screens/profile.dart';
import 'package:farm_app/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:farm_app/screens/login.dart';
import 'package:farm_app/screens/register.dart';
import 'package:flutter/services.dart';
import "package:go_router/go_router.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  var title = "My Farm";
  var version = "1.0.0";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    /*
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
      /*
      routes: <String, WidgetBuilder>{
        "userProfile": (BuildContext context) => const UserProfile(),
        "chicks": (BuildContext context) => const FarmChicks(),
        "flock": (BuildContext context) => const FarmFlock(),
        "settings": (BuildContext context) => const FarmSettings(),
      },
      */
    );
    */
    final routes = GoRouter(
        initialLocation: "/",
        routes: [
          GoRoute(
            path: "/",
            builder: (context,state)=> FarmHome(title:title, version: version,),
          ),
          GoRoute(
              path: "/settings",
              builder: (context,state)=> const FarmSettings()
          ),
          GoRoute(
              path: "/flock",
              builder: (context,state)=> const FarmFlock()
          ),
          GoRoute(
              path: "/userprofile",
              builder: (context,state)=> const UserProfile()
          ),
          GoRoute(
              path: "/chicks",
              builder: (context,state)=> const FarmChicks()
          )
        ]
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: const Color.fromRGBO(137, 81, 41, 1.0),
        useMaterial3: true,
      ),
      routerConfig: routes,
    );
  }
}
