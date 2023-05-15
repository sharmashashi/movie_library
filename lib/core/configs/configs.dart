import 'package:flutter_dotenv/flutter_dotenv.dart';

class Configs {
  static String authToken = dotenv.get('movie_db_auth_token');
  static String baseUrl = 'https://api.themoviedb.org/3';
  static String imageBaseUrl = 'https://image.tmdb.org/t/p/original';
}
