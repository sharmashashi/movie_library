import 'package:movie_library/core/configs/configs.dart';
import 'package:movie_library/core/services/http/http_service.dart';
import 'package:movie_library/features/movie_details/models/cast_details_response.dart';
import 'package:movie_library/features/movie_details/models/movie_details_response.dart';
import 'package:movie_library/features/movie_details/models/similar_movies_response.dart';
import 'package:movie_library/features/movie_details/repositories/movie_details_repository.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final HttpService httpService;
  MovieDetailsRepositoryImpl(this.httpService);
  @override
  String path(int movieId) => '/movie/$movieId';

  @override
  Future<MovieDetailsResponse> getMovieDetails({required int movieId}) async {
    final responseData = await httpService.get(Configs.baseUrl + path(movieId));
    return MovieDetailsResponse.fromJson(responseData);
  }

  @override
  Future<CastDetailsResponse> getCastDetails({required int movieId}) async {
    final responseData =
        await httpService.get(Configs.baseUrl + castDetailsPath(movieId));
    return CastDetailsResponse.fromJson(responseData);
  }

  @override
  String castDetailsPath(int movieId) => '/movie/$movieId/credits';

  @override
  Future<SimilarMoviesResponse> getSimilarMovies({required int movieId}) async {
    final responseData =
        await httpService.get(Configs.baseUrl + similarMoviesPath(movieId));
    return SimilarMoviesResponse.fromJson(responseData);
  }

  @override
  String similarMoviesPath(int movieId) => '/movie/$movieId/similar';
}
