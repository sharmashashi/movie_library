import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_library/core/services/http/http_service_impl.dart';
import 'package:movie_library/features/now_playing/models/now_playing_response.dart';
import 'package:movie_library/features/now_playing/repositories/now_playing_repository_impl.dart';

final nowPlayingRepositoryProvider = Provider<NowPlayingRepository>((ref) {
  return NowPlayingRepositoryImpl(ref.read(httpServiceProvider));
});

abstract class NowPlayingRepository {
  String get path;
  Future<NowPlayingResponse> getNowPlaying();
}
