import 'package:flutter/material.dart';
import 'package:productivity_gacha_app/nav_drawer.dart';
import 'package:productivity_gacha_app/water.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          title: 'drink',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: const CurrentPage() //const WaterSettingsPage(),
          );
  }
}

class CurrentPage extends StatefulWidget {
  const CurrentPage({super.key});

  @override
  State<CurrentPage> createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  
  final pages = [
    const WaterSettingsPage(),
  ];
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page = pages[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text("My App"),
      ),
      body: page,
      drawer: NavDrawer(),
    );
  }
}

