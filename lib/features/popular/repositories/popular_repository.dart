import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_library/core/services/http/http_service_impl.dart';
import 'package:movie_library/features/popular/models/popular_response.dart';
import 'package:movie_library/features/popular/repositories/popular_repository_impl.dart';

final popularRepositoryProvider = Provider<PopularRepository>(
    (ref) => PopularRepositoryImpl(ref.read(httpServiceProvider)));

abstract class PopularRepository {
  String get path;
  Future<PopularResponse> getPopularMovies();
}
