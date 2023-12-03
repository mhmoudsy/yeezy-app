import 'package:dio/dio.dart';
import 'package:yeezy_store/shared/constants.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        validateStatus: (status) => true,

      ),
    );
  }

  static Future<Response> postData({
    required String url,
    required Object? data,
    Map<String, dynamic>? query,
    String? token,
    String lang = 'en',
  }) {

    dio!.options.headers = {
      "accept" : "*/*",
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': "Bearer $token",
    };
    return dio!.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
    String lang = 'en',
  }) {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': "Bearer $token",
    };
    return dio!.put(
      url,
      data: data,
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,

    String lang = 'en',

  }) {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': "Bearer $token",

    };
    return dio!.get(
      url,
    );
  }
}
