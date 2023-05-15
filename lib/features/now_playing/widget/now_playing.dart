import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:movie_library/core/configs/configs.dart';
import 'package:movie_library/features/now_playing/models/now_playing_response.dart';
import 'package:movie_library/features/now_playing/providers/now_playing_provider.dart';
import 'package:movie_library/screens/details_page.dart';

class NowPlaying extends ConsumerWidget {
  const NowPlaying({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(nowPlayingProvider);

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: [
          movies.when(
              data: (data) {
                return CarouselSlider.builder(
                    itemCount: data.results.length,
                    itemBuilder: (context, index, realIndex) {
                      return _movieInfo(data.results[index], context);
                    },
                    options: CarouselOptions(
                        disableCenter: true,
                        autoPlay: true,
                        viewportFraction: 1));
              },
              error: (e, s) => const Text('Error loading!'),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  )),
        ],
      ),
    );
  }

  _movieInfo(Result movie, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => DetailsPage(
                  movieId: movie.id,
                )));
      },
      child: Stack(
        children: [
          CachedNetworkImage(
              imageUrl: Configs.imageBaseUrl + movie.backdropPath),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0, 0.6])),
          ),
          Positioned(
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${movie.title} (${movie.releaseDate.year.toString()})',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        movie.voteAverage.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    movie.overview,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey.shade300),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
