import 'package:dio/dio.dart';

// website url =
//     "https://newsapi.org/v2/top-headlines?country=eg&category=business&apikey=433ad5d1116d4a5c96ab281b992d04e0";

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getdata(
      {required String url, required Map<String, dynamic> query}) async {
    return await dio!.get(url, queryParameters: query);
  }
}
