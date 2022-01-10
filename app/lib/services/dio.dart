import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../models/movie_data.dart';
import './log.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        "api_key": "5feaedeaa3c34db3bee6897410d01e8d",
        "language": "pt-BR"
      },
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  )..interceptors.add(Logging());

  Future<MovieData?> getTopMovies({required int page}) async {
    MovieData? movies;

    try {
      Response movieData = await _dio
          .get('/trending/movie/week?', queryParameters: {"page": page});

      debugPrint('Movies Data: ${movieData.data}');

      movies = MovieData.fromJson(movieData.data);
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    }

    return movies;
  }
}
