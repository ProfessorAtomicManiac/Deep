import 'package:flutter/material.dart';
import 'package:productivity_gacha_app/routes/routes.dart';

class Nav extends StatefulWidget {
  Nav({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  final pages = [
    {
      "unselected_icon": Icons.home_outlined,
      "selected_icon": Icons.home,
      "name": "Dashboard",
      "path": RouteManager.homePage.route,
    },
    {
      "unselected_icon": Icons.create_outlined,
      "selected_icon": Icons.create,
      "name": "Writing",
      "path": RouteManager.writingPage.route,
    },
    {
      "unselected_icon": Icons.water_drop_outlined,
      "selected_icon": Icons.water_drop,
      "name": "Water",
      "path": RouteManager.waterPage.route,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navTextStyle = theme.textTheme.labelLarge!.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return LayoutBuilder(builder: (context, constraints) {
      var useIndicator = constraints.maxWidth >= 600;
      return NavigationRail(
        leading: const SizedBox(
          height: 50,
        ),
        groupAlignment: -1,
        useIndicator: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        extended: useIndicator,
        indicatorColor: Theme.of(context).colorScheme.primaryContainer,
        indicatorShape: useIndicator
            ? StadiumBorder(
                side: BorderSide(
                  width: 600,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  style: BorderStyle.solid,
                ),
              )
            : const StadiumBorder(),
        selectedLabelTextStyle: navTextStyle.copyWith(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelTextStyle: navTextStyle,
        destinations: [
          for (var p in pages)
            NavigationRailDestination(
              icon: Icon(
                p["unselected_icon"] as IconData,
              ),
              selectedIcon: Icon(
                p["selected_icon"] as IconData,
              ),
              label: Text(
                p["name"] as String,
              ),
            ),
        ],
        selectedIndex: widget.selectedIndex,
        onDestinationSelected: (value) {
          var newRoute = pages[value]["path"] as String;
          Navigator.of(context).pushNamed(newRoute);
        },
      );
    });
  }
}
