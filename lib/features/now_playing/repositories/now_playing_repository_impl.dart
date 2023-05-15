import 'package:movie_library/core/configs/configs.dart';
import 'package:movie_library/core/services/http/http_service.dart';
import 'package:movie_library/features/now_playing/models/now_playing_response.dart';
import 'package:movie_library/features/now_playing/repositories/now_playing_repository.dart';

class NowPlayingRepositoryImpl implements NowPlayingRepository{
  HttpService httpService;

  NowPlayingRepositoryImpl(this.httpService);
  @override
  Future<NowPlayingResponse> getNowPlaying()async {
    final responseData =  await httpService.get(Configs.baseUrl+path);
    return NowPlayingResponse.fromJson(responseData);
  }

  @override
  String get path=>'/movie/now_playing';

}