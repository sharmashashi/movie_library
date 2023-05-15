import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_library/core/services/http/http_service_impl.dart';
import 'package:movie_library/features/movie_details/models/cast_details_response.dart';
import 'package:movie_library/features/movie_details/models/movie_details_response.dart';
import 'package:movie_library/features/movie_details/models/similar_movies_response.dart';
import 'package:movie_library/features/movie_details/repositories/movie_details_repository_impl.dart';

final movieDetailsRepositoryProvider = Provider<MovieDetailsRepository>(
    (ref) => MovieDetailsRepositoryImpl(ref.read(httpServiceProvider)));

abstract class MovieDetailsRepository {
  String path(int movieId);
  String castDetailsPath(int movieId);
  String similarMoviesPath(int movieId);

  Future<MovieDetailsResponse> getMovieDetails({required int movieId});
  Future<CastDetailsResponse> getCastDetails({required int movieId});
  Future<SimilarMoviesResponse> getSimilarMovies({required int movieId});
}
