import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:veritas/components/feedCard.dart';
import 'package:veritas/types/product.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
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
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

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
          final items =
              snapshot.data!.map((item) => FeedCard(item: item)).toList();
          return ListView(
            // padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
            padding: const EdgeInsets.symmetric(horizontal: 15),
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
