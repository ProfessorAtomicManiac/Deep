import 'package:flutter/material.dart';
import 'package:productivity_gacha_app/pages/water.dart';
import 'package:productivity_gacha_app/pages/writing.dart';
import 'package:productivity_gacha_app/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        initialRoute: RouteManager.homePage.route,
        onGenerateRoute: RouteManager.generateRoute //const WaterSettingsPage(),
        );
  }
}



