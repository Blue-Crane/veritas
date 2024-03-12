import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:veritas/components/wineCard.dart';
import 'package:veritas/types/product.dart';

class WineGrid extends StatefulWidget {
  const WineGrid({super.key, required this.query});

  final String query;

  @override
  State<WineGrid> createState() => _WineGridState();
}

class _WineGridState extends State<WineGrid> {
  late Future<List<Product>> items;

  @override
  void initState() {
    super.initState();
    items = fetchItems();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    items = fetchItems();
  }

  Future<List<Product>> fetchItems() async {
    final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products?search=${widget.query}'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      return List.from(jsonData.map((item) => Product.fromJson(item)));
    } else {
      throw Exception("Network Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: items,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final items = snapshot.data!
              .map((item) => GridTile(child: WineCard(item: item)))
              .toList();
          return GridView.count(
            // shrinkWrap: true,

            childAspectRatio: 3 / 4,
            crossAxisSpacing: 20,
            mainAxisSpacing: 30,
            crossAxisCount: 2,
            children: items,
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
