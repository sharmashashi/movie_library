import 'dart:async';

import 'package:movie_library/features/movie_details/models/similar_movies_response.dart';
import 'package:movie_library/features/movie_details/repositories/movie_details_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'similar_movies_provider.g.dart';

@riverpod
class SimilarMovies extends _$SimilarMovies {
  @override
  Future<SimilarMoviesResponse> build(int movieId) async {
    return await ref
        .read(movieDetailsRepositoryProvider)
        .getSimilarMovies(movieId: movieId)
        .onError((error, stackTrace) {
      Zone.current.handleUncaughtError(error!, stackTrace);
      throw error;
    });
  }
}
