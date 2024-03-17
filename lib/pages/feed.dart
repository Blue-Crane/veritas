import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:veritas/components/feedCard.dart';
import 'package:veritas/types/comment.dart';
import 'package:veritas/types/product.dart';

/// {@template counter_cubit}
/// A [Cubit] which manages an [int] as its state.
/// {@endtemplate}
class CommentsCubit extends Cubit<String?> {
  /// {@macro counter_cubit}
  CommentsCubit() : super(null);

  List<Comment> _data = <Comment>[];

  Future<void> _fetch() async {
    // TODO: fetch
    print("state: ${state}");
    _data = <Comment>[
      Comment(id: 123, author: state ?? "jk", text: "text", burns: 10)
    ];
  }

  Stream<String?> set(String? spec) async* {
    emit(spec);
    await _fetch();
    yield spec;
  }

  // Stream<List<Comment>> get() async* {
  //   if (_data == []) {
  //     yield [];
  //   } else {
  //     print("_data: ${_data}");

  //     yield _data;
  //   }
  // }
}

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
    return BlocProvider(
        create: (context) => CommentsCubit(),
        child: FutureBuilder(
          future: items,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final items =
                  snapshot.data!.map((item) => FeedCard(item: item)).toList();

              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: const Text("Veritas!",
                                style: TextStyle(
                                  fontSize: 40,
                                ))),
                        items[index],
                      ],
                    );
                  } else {
                    return items[index];
                  }
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
