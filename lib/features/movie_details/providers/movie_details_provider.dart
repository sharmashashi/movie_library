import 'dart:async';

import 'package:movie_library/features/movie_details/models/movie_details_response.dart';
import 'package:movie_library/features/movie_details/repositories/movie_details_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'movie_details_provider.g.dart';

@riverpod
class MovieDetails extends _$MovieDetails {
  @override
  Future<MovieDetailsResponse> build(int movieId) async {
    return ref
        .read(movieDetailsRepositoryProvider)
        .getMovieDetails(movieId: movieId)
        .onError((error, stackTrace) {
      Zone.current.handleUncaughtError(error!, stackTrace);
      throw error;
    });
  }
}
