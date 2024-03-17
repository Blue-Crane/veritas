import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
        create: (context) => CommentsCubit(),
        child: Scaffold(
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
            ),
            bottomSheet: BottomSheet(
              onClosing: () => context.read<CommentsCubit>().set(null),
              builder: (context) {
                return BlocBuilder<CommentsCubit, String?>(
                    builder: ((context, state) {
                  print("context state: ${state}");
                  if (state == null) {
                    return const SizedBox(height: 0);
                  }
                  return SizedBox(
                    height: 50,
                    child: Text(state),
                  );
                }));
              },
            )));
  }
}
