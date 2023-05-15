import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_library/core/configs/configs.dart';
import 'package:movie_library/features/movie_details/models/cast_details_response.dart';
import 'package:movie_library/features/movie_details/providers/cast_details_provider.dart';

class CastDetails extends ConsumerWidget {
  final int movieId;
  const CastDetails(this.movieId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final castDetails = ref.watch(castDetailsProvider(movieId));
    return castDetails.when(
        data: (data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Casting',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 120,

                child: ListView.builder(
                  itemCount: data.cast.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: CastWidget(data.cast[index]),
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (e, s) => const Center(
              child: Text('Could not load cast!'),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}

class CastWidget extends StatelessWidget {
  final Cast cast;
  const CastWidget(this.cast, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: cast.profilePath == null
              ? Text(
                  cast.name[0].toUpperCase(),
                  style: Theme.of(context).textTheme.headlineMedium,
                )
              : CachedNetworkImage(
                  fit: BoxFit.fill,
                  height: 50,
                  errorWidget: (context, url, error) {
                    return Text(
                      cast.name[0].toUpperCase(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  },
                  imageUrl: Configs.imageBaseUrl + cast.profilePath!),
        ),
        Text(cast.name),
        cast.character == null ? const SizedBox() : const Text('As'),
        cast.character == null
            ? const SizedBox()
            : Text(
                cast.character!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontStyle: FontStyle.italic),
              ),
      ],
    );
  }
}
