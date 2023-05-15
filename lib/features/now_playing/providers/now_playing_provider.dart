import 'package:movie_library/features/now_playing/models/now_playing_response.dart';
import 'package:movie_library/features/now_playing/repositories/now_playing_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'now_playing_provider.g.dart';


@riverpod
class NowPlaying extends _$NowPlaying{
  @override
  Future<NowPlayingResponse> build()async{
    return ref.read(nowPlayingRepositoryProvider).getNowPlaying();
  }
}
