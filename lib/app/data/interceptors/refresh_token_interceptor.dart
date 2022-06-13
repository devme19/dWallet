// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dwallet/app/data/data_sources/local/local_data_source.dart';

import '../data_sources/remote/client.dart';

class RefreshTokenInterceptor extends QueuedInterceptorsWrapper
    with AppLocalDateSourceImpl {
  String? token;
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    token = getToken();
    if (token != null && token != '') {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  Future onError(DioError error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401 && token != null) {
      Dio tokenDio = Dio();
      tokenDio.options = Client().dio.options;
      try {
        Response response = await tokenDio.post("https://refresh.api",
            data: jsonEncode({"refresh_token": getRefreshToken()}));
        if (response.statusCode == 200) {
          //get new tokens ...
          String token, refreshToken;
          token = response.data["token"];
          refreshToken = response.data["refreshToken"];
          saveToken(token);
          saveRefreshToken(refreshToken);

          //set bearer
          error.requestOptions.headers["Authorization"] = "Bearer " + token;
          //create request with new access token
          final opts = Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers);
          final cloneReq = await Client().dio.request(error.requestOptions.path,
              options: opts,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters);

          return handler.resolve(cloneReq);
        }

        return Client().dio;
      } catch (e) {}
    }
    return handler.next(error);
  }
}
