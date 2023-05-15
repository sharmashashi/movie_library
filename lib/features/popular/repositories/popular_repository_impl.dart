import 'package:movie_library/core/configs/configs.dart';
import 'package:movie_library/core/services/http/http_service.dart';
import 'package:movie_library/features/popular/models/popular_response.dart';
import 'package:movie_library/features/popular/repositories/popular_repository.dart';

class PopularRepositoryImpl implements PopularRepository{
  final HttpService httpService;
  PopularRepositoryImpl(this.httpService);
  @override
  Future<PopularResponse> getPopularMovies() async{
    final responseData = await httpService.get(Configs.baseUrl+path);
    return PopularResponse.fromJson(responseData);
  }

  @override
  String get path => '/movie/popular';


}