import 'package:dio/dio.dart';

class DioClient {
   Dio dio;

  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://rickandmortyapi.com/api',
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            responseType: ResponseType.json,
          ),
        );
}