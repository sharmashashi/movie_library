import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_library/core/widgets/movie_card.dart';
import 'package:movie_library/features/movie_details/providers/similar_movies_provider.dart';
import 'package:movie_library/screens/details_page.dart';

class SimilarMovies extends ConsumerWidget {
  final int movieId;
  const SimilarMovies(this.movieId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarMovies = ref.watch(similarMoviesProvider(movieId));
    return similarMovies.when(
        data: (data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Similar Movies',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              GridView.builder(
                shrinkWrap: true,
                primary: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    childAspectRatio: 9 / 16,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3),
                itemCount: data.results.length,
                itemBuilder: (context, index) {
                  final movie = data.results[index];
                  return MovieCard(
                      onClick: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => DetailsPage(movieId: movie.id)));
                      },
                      posterPath: movie.posterPath,
                      title: movie.title);
                },
              ),
            ],
          );
        },
        error: (e, s) => const Center(
              child: Text('Could not load similar movies!'),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
