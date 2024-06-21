import 'package:flutter/material.dart';
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

enum Page {
  startPage,
  waterSettingsPage,
}

class _CurrentPageState extends State<CurrentPage> {
  
  var selectedIndex = Page.waterSettingsPage;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch(selectedIndex) {
      case Page.startPage:
        page = const Placeholder();
        break;
      case Page.waterSettingsPage:
        page = const WaterSettingsPage(); break;
      default:
        throw UnimplementedError("Invalid Page");

    }
    return page;
  }
}

