import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:veritas/types/product.dart';

class WineCard extends StatelessWidget {
  const WineCard({super.key, required this.item});

  final Product item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FadeInImage.memoryNetwork(
                height: 100, placeholder: kTransparentImage, image: item.image),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.red,
                    size: 15,
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.pink,
                    size: 15,
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.black54,
                    size: 15,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Text(
                "${item.price} Руб",
                textScaler: const TextScaler.linear(1.2),
              )
            ])
          ],
        ));
  }
}
