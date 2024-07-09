import 'package:flutter/material.dart';
import 'package:productivity_gacha_app/water.dart';
import 'package:productivity_gacha_app/writing.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
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
  final pages = const [
    (Icons.home_outlined, Icons.home, "Dashboard", Placeholder()),
    (Icons.abc_outlined, Icons.abc, "Writing", WritingPage()),
    (Icons.water_drop_outlined, Icons.water_drop, "Water", WaterSettingsPage()),
  ];
  var selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    var title = pages[selectedIndex].$3;
    Widget page = pages[selectedIndex].$4;
    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onSurface,
      fontSize: 30,
    );
    final navTextStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
      fontSize: 15,
    );

    return LayoutBuilder(builder: (context, constraints) {
      var useIndicator = constraints.maxWidth >= 600;
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              leading: new SizedBox(
                height: 50,
              ),
              groupAlignment: -1,
              useIndicator: true,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              extended: useIndicator,
              indicatorColor: Theme.of(context).colorScheme.primaryContainer,
              indicatorShape: useIndicator ? StadiumBorder(
                side: BorderSide(
                  width: 600,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  style: BorderStyle.solid,
                ),
              ) : const StadiumBorder(),
              selectedLabelTextStyle: navTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelTextStyle: navTextStyle,
              destinations: [
                for (var p in pages)
                  NavigationRailDestination(
                    icon: Icon(
                      p.$1,
                    ),
                    selectedIcon: Icon(p.$2),
                    label: Text(
                      p.$3,
                    ),
                  ),
              ],
              selectedIndex: selectedIndex,
              onDestinationSelected: (value) {
                setState(() => selectedIndex = value);
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                ),
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25,
                          bottom: 25,
                        ),
                        child: Text(
                          title,
                          style: titleTextStyle,
                        ),
                      ),
                      Expanded(
                        child: page,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
