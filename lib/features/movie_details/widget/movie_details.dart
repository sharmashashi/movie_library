import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:movie_library/core/configs/configs.dart';
import 'package:movie_library/core/utils/extensions.dart';
import 'package:movie_library/features/movie_details/models/movie_details_response.dart';
import 'package:movie_library/features/movie_details/providers/movie_details_provider.dart';
import 'package:movie_library/features/movie_details/widget/cast_details.dart';
import 'package:movie_library/features/movie_details/widget/similar_movies.dart';

class MovieDetails extends ConsumerWidget {
  final int movieId;
  const MovieDetails({required this.movieId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetails = ref.watch(movieDetailsProvider(movieId));
    return movieDetails.when(
        data: (data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackDrop(Configs.imageBaseUrl + data.backdropPath),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Info(data),
                  ],
                ),
              )
            ],
          );
        },
        error: (e, s) => const Center(child: Text('Error loading details!')),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}

class Info extends StatelessWidget {
  final MovieDetailsResponse movie;
  const Info(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          style: Theme.of(context).textTheme.titleLarge!,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          movie.overview,
        ),
        const SizedBox(
          height: 5,
        ),
        Wrap(
          spacing: 2.5,
          runSpacing: 5.0,
          children: [for (var each in movie.genres) GenreWidget(each)],
        ),
        const SizedBox(
          height: 5,
        ),
        DefaultTextStyle(
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.normal),
          child: Wrap(
            spacing: 10,
            children: [
              Text(movie.status),
              Text(movie.releaseDate.year.toString()),
              Text(movie.runtime.formattedDuration),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 2.5,
                  ),
                  Text(movie.voteAverage.toStringAsFixed(1))
                ],
              ),
            ],
          ),
        ),
        const Divider(),
        Production(movie.productionCompanies),
        const Divider(),
        CastDetails(movie.id),
        const Divider(),
        SimilarMovies(movie.id)
      ],
    );
  }
}

class Production extends StatelessWidget {
  final List<ProductionCompany> productionCompanies;
  const Production(this.productionCompanies, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Production',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (var each in productionCompanies)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ProducerWidget(each),
                )
            ],
          ),
        ),
      ],
    );
  }
}

class ProducerWidget extends StatelessWidget {
  final ProductionCompany productionCompany;
  const ProducerWidget(this.productionCompany, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        productionCompany.logoPath == null
            ? Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Text(
                  productionCompany.name[0].toUpperCase(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              )
            : Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(Configs.imageBaseUrl +
                            productionCompany.logoPath!))),
              ),
        Text(
          productionCompany.name,
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}

class GenreWidget extends StatelessWidget {
  final Genre genre;
  const GenreWidget(this.genre, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Theme.of(context).primaryColor.withOpacity(0.3)),
      child: Text(
        genre.name.toUpperCase(),
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

class BackDrop extends StatelessWidget {
  final String imageUrl;
  const BackDrop(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 16 / 9, child: CachedNetworkImage(imageUrl: imageUrl));
  }
}
