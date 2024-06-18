import 'package:flutter/material.dart';

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
      home: const WaterSettingsPage()//const WaterSettingsPage(),
    );
  }
}

class WaterSettingsPage extends StatelessWidget {
  const WaterSettingsPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Periodically, how many minutes do you want to be reminded to drink water?"),
            SizedBox(
              width: 50,
              child: TextField()
            ),
          ],
        ),
      ),
    );
  }
  
}