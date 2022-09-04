import 'package:dio/dio.dart';
import 'package:test1/core/util/network/remote/end_points.dart';

class DioHelper {
  static final DioHelper _instance = DioHelper._internal();

  factory DioHelper() {
    return _instance;
  }

  DioHelper._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: '$baseApiUrl$version',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Dio? dio;

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
}