import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_library/core/configs/configs.dart';

class MovieCard extends StatelessWidget {
  final String posterPath, title;
  final Function onClick;
  const MovieCard(
      {super.key,
      required this.onClick,
      required this.posterPath,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: Configs.imageBaseUrl + posterPath,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 2.5,
            ),
            Flexible(
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: Text(title,
                          style: Theme.of(context).textTheme.bodySmall),
                    )))
          ],
        ),
      ),
    );
  }
}
