import 'package:movie_library/features/movie_details/models/cast_details_response.dart';
import 'package:movie_library/features/movie_details/repositories/movie_details_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'cast_details_provider.g.dart';

@riverpod
class CastDetails extends _$CastDetails {
  @override
  Future<CastDetailsResponse> build(int movieId) async {
    return await ref
        .read(movieDetailsRepositoryProvider)
        .getCastDetails(movieId: movieId);
  }
}
