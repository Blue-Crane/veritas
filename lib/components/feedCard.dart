import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:veritas/types/product.dart';
import 'package:line_icons/line_icons.dart' show LineIcons;

class FeedCard extends StatelessWidget {
  const FeedCard({super.key, required this.item});

  final Product item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 15, // Image radius
              backgroundImage: NetworkImage(
                  "https://api.dicebear.com/7.x/avataaars/png?seed=${item.category}"),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(item.category.substring(0, min(25, item.category.length)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 10,
                ))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        FadeInImage.memoryNetwork(
          width: MediaQuery.of(context).size.width,
          placeholder: kTransparentImage,
          image: item.image,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 35,
                    child: IconButton(
                      onPressed: () => print("Burn"),
                      icon: const Icon(
                        LineIcons.burn,
                        color: Colors.black,
                        size: 30,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 35,
                    child: IconButton(
                      onPressed: () => print("Comment"),
                      icon: Badge(
                        label: Text(
                          "${(item.price * 10).round().toString().substring(0, 2)}k",
                          style: const TextStyle(fontSize: 8),
                        ),
                        child: const Icon(
                          LineIcons.alternateComment,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                      padding: EdgeInsets.zero,
                      constraints:
                          const BoxConstraints(minWidth: 35, maxWidth: 35),
                    ),
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 35,
                    child: IconButton(
                      onPressed: () => print("Wine"),
                      icon: const Icon(
                        LineIcons.wineBottle,
                        color: Colors.black,
                        size: 30,
                      ),
                      padding: EdgeInsets.zero,
                      constraints:
                          const BoxConstraints(minWidth: 35, maxWidth: 35),
                    ),
                  ),
                ]),
            const Spacer(),
            IconButton(
              onPressed: () => print("Favorite"),
              icon: const Icon(
                LineIcons.star,
                size: 30,
                color: Colors.amber,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Burns: ${(item.price * 314.1592).round().toString()}",
          style: const TextStyle(
              fontSize: 14, color: Color.fromARGB(220, 95, 95, 95)),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          item.description,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 13),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          DateTime.now().toString().substring(0, 16),
          style: const TextStyle(
            color: Colors.blueGrey,
            fontSize: 10,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
