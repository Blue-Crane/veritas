import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:veritas/pages/feed.dart';
import 'package:veritas/pages/home.dart';
import 'package:veritas/pages/messages.dart';
import 'package:veritas/pages/notifications.dart';
import 'package:line_icons/line_icons.dart' show LineIcons;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Veritas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF5099)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Veritas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            selectedIndex: currentPageIndex,
            destinations: <Widget>[
              const NavigationDestination(
                icon: Icon(LineIcons.glassCheers),
                label: 'Feed',
              ),
              const NavigationDestination(
                icon: Badge(child: Icon(LineIcons.star)),
                label: 'Favorite',
              ),
              NavigationDestination(
                icon: Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.red,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(LineIcons.plus),
                    iconSize: 30,
                    color: Colors.black,
                    onPressed: () {},
                  ),
                ),
                label: '',
              ),
              const NavigationDestination(
                icon: Icon(LineIcons.alternateWineGlass),
                label: 'Catalogue',
              ),
              const NavigationDestination(
                icon: Badge(child: Icon(LineIcons.userTie)),
                label: 'Profile',
              ),
            ]),
        body: Container(
          padding: const EdgeInsets.only(top: 5),
          child: const [
            Feed(),
            Notifications(),
            Messages(),
            Home(),
            Messages(),
          ][currentPageIndex],
        ));
  }
}
