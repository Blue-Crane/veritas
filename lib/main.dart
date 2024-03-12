import 'package:flutter/material.dart';
import 'package:veritas/pages/home.dart';
import 'package:veritas/pages/messages.dart';
import 'package:veritas/pages/notifications.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x567565)),
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
            destinations: const <Widget>[
              NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Badge(child: Icon(Icons.notifications_sharp)),
                label: 'Notifications',
              ),
              NavigationDestination(
                icon: Badge(
                  label: Text('2'),
                  child: Icon(Icons.messenger_sharp),
                ),
                label: 'Messages',
              ),
            ]),
        body: const [
          Home(),
          Notifications(),
          Messages(),
        ][currentPageIndex]);
  }
}
