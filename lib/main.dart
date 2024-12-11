import 'package:farm_app/models/database_service.dart';
import 'package:farm_app/screens/chicks.dart';
import 'package:farm_app/screens/flock.dart';
import 'package:farm_app/screens/home.dart';
import 'package:farm_app/screens/profile.dart';
import 'package:farm_app/screens/sales_summary.dart';
import 'package:farm_app/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:farm_app/screens/login.dart';
import 'package:farm_app/screens/register.dart';
import 'package:flutter/services.dart';
import "package:go_router/go_router.dart";

void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  static const title = "Chicken Farm";
  static const version = "1.0.0";
  var userActive = "0";
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      _databaseService.logoutUserAuth();
      userActive = "0";
    } else if (state == AppLifecycleState.paused) {
    } else if (state == AppLifecycleState.resumed) {
      userActive = "0";
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _databaseService.getUserProfile().then((onValue) {
      if (onValue.isNotEmpty) {
        int active = onValue[0]["active"];
        userActive = active.toString() == "" ? "0" : active.toString();
      } else {
        //User not existing
        userActive = 0.toString();
      }
    });

    final routes =
    GoRouter(
        //initialLocation: userActive == "0" ? "/login" : "/",
        initialLocation: "/sales",
        routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const FarmHome(
          title: title,
          version: version,
        ),
      ),
      GoRoute(
          path: "/settings", builder: (context, state) => const FarmSettings()),
      GoRoute(path: "/flock", builder: (context, state) => const FarmFlock()),
      GoRoute(
          path: "/userprofile",
          builder: (context, state) => const UserProfile()),
      GoRoute(path: "/chicks", builder: (context, state) => const FarmChicks()),
      GoRoute(
          path: "/sales",
          builder: (context, state) => const FarmSalesSummary()),
      GoRoute(
          path: "/login",
          builder: (context, state) => const UserLogin(
                title: title,
              )),
      GoRoute(
          path: "/register",
          builder: (context, state) => const UserRegistration(
                title: title,
              ))
    ]);

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
