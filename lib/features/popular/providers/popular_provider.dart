import 'dart:async';

import 'package:movie_library/features/popular/models/popular_response.dart';
import 'package:movie_library/features/popular/repositories/popular_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'popular_provider.g.dart';

@riverpod
class Popular extends _$Popular {
  @override
  Future<PopularResponse> build() {
    return ref
        .read(popularRepositoryProvider)
        .getPopularMovies()
        .onError((error, stackTrace) {
      Zone.current.handleUncaughtError(error!, stackTrace);
      throw error;
    });
  }
}
