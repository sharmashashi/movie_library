import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:movie_library/core/utils/utils.dart';
import 'package:movie_library/core/widgets/movie_card.dart';
import 'package:movie_library/features/popular/providers/popular_provider.dart';
import 'package:movie_library/screens/details_page.dart';

class Popular extends ConsumerWidget {
  const Popular({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularMovies = ref.watch(popularProvider);
    return LayoutBuilder(builder: (_, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Now',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 5,
          ),
          popularMovies.when(
              data: (data) {
                return GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: data.results.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 9 / 16,
                        crossAxisCount: isMobile(context)
                            ? 3
                            : isTablet(context)
                                ? 6
                                : 9),
                    itemBuilder: (ctx, index) {
                      final movie = data.results[index];

                      return MovieCard(
                          onClick: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) =>
                                    DetailsPage(movieId: movie.id)));
                          },
                          posterPath: movie.posterPath,
                          title: movie.title);
                    });
              },
              error: (e, s) => const Center(
                    child: Text("Error loading popular movies list!"),
                  ),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ))
        ],
      );
    });
  }
}
