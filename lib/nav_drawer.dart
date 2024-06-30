import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Drawer(
        //children: [],
      );
    });
  }
}
