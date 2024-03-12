import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:veritas/components/wineGrid.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        SearchBar(
          onChanged: (value) => setState(() {
            query = value;
          }),
        ),
        Flexible(child: WineGrid(query: query)),
      ],
    );
  }
}
