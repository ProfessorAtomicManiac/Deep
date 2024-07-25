import 'package:flutter/material.dart';
import 'package:productivity_gacha_app/pages/water.dart';
import 'package:productivity_gacha_app/pages/writing.dart';
import 'package:productivity_gacha_app/pages/writing_create.dart';
import 'package:productivity_gacha_app/templates/content.dart';
import 'package:productivity_gacha_app/templates/nav.dart';

class Page {
  final String route;
  final String title;
  final Widget content;
  final Widget? floatingActionButton;

  const Page(
      {required this.route,
      required this.title,
      required this.content,
      this.floatingActionButton});
}

class RouteManager {
  static const homePage = Page(
    route: "/",
    title: "Dashboard",
    content: Placeholder(),
  );
  static const writingPage = Page(
    route: "/writing",
    title: "Writing",
    content: WritingPage(),
    floatingActionButton: WritingFloatingActionButton(),
  );
  static const writingCreatePage = Page(
    route: "/writing/create",
    title: "Writing",
    content: WritingCreate(),
  );
  static const waterPage = Page(
    route: "/water",
    title: "Water",
    content: WaterSettingsPage(),
    floatingActionButton: null,
  );

  static const mainPages = [homePage, writingPage, waterPage];
  static const transitionPages = [writingCreatePage];
  static int selectedIndex = 0;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    for (int i = 0; i < mainPages.length; i++) {
      if (settings.name == mainPages[i].route) {
        Widget pageContent = mainPages[i].content;
        String pageTitle = mainPages[i].title;
        Widget? floatingActionButton = mainPages[i].floatingActionButton;
        selectedIndex = i;
        return PageRouteBuilder(
          pageBuilder: (context, _, __) => Scaffold(
            body: Row(
              children: [
                Nav(selectedIndex: selectedIndex),
                Content(
                  title: pageTitle!,
                  content: pageContent!,
                ),
              ],
            ),
            floatingActionButton: floatingActionButton,
          ),
        );
      }
    }
    for (int i = 0; i < transitionPages.length; i++) {
      if (settings.name == transitionPages[i].route) {
        Widget pageContent = transitionPages[i].content;
        String pageTitle = transitionPages[i].title;
        Widget? floatingActionButton = transitionPages[i].floatingActionButton;
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Row(
                    children: [
                      Nav(selectedIndex: selectedIndex),
                      Content(
                        title: pageTitle,
                        content: pageContent,
                      ),
                    ],
                  ),
                  floatingActionButton: floatingActionButton,
                ));
      }
    }
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
              body: Center(child: Text("Invalid Page")),
            ));
  }
}
