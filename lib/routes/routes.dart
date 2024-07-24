import 'package:flutter/material.dart';
import 'package:productivity_gacha_app/pages/water.dart';
import 'package:productivity_gacha_app/pages/writing.dart';
import 'package:productivity_gacha_app/templates/content.dart';
import 'package:productivity_gacha_app/templates/nav.dart';

class RouteManager {
  static const homePage = {
    "route": "/",
    "title": "Dashboard",
    "content": Placeholder(),
  };
  static const writingPage = {
    "route": "/writing",
    "title": "Writing",
    "content": WritingPage(),
  };
  static const waterPage = {
    "route": "/water",
    "title": "Water",
    "content": WaterSettingsPage(),
  };
  static const pages = [homePage, writingPage, waterPage];

  static Route<dynamic> generateRoute(RouteSettings settings) {
    late Widget pageContent;
    late String pageTitle;
    late int selectedIndex;
    for (int i = 0; i < pages.length; i++) {
      if (settings.name == pages[i]["route"]) {
        pageContent = pages[i]["content"] as Widget;
        pageTitle = pages[i]["title"] as String;
        selectedIndex = i;
        break;
      }
    }
    return PageRouteBuilder(
      pageBuilder: (context, _, __) => Scaffold(
          body: Row(
            children: [
              Nav(selectedIndex: selectedIndex),
              Content(
                title: pageTitle,
                content: pageContent,
              ),
            ],
          ),
      ),
    );}
}
