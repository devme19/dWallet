import 'package:dio/dio.dart';
import 'package:dwallet/app/core/config.dart';
import 'package:dwallet/app/data/interceptors/refresh_token_interceptor.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../web3/web3dart.dart';


class Client {
  static final Client _client = Client._internal();
  factory Client() {
    return _client;
  }
  Client._internal();
  Dio dio = Dio();
  GetStorage? box;

  http.Client httpClient = http.Client();
  Web3Client web3(String url){
    return Web3Client(url, httpClient);
  }
  init() {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 50000;
    dio.options.receiveTimeout = 30000;
    dio.options.headers['content-Type'] = 'application/json';
    // String token = box.read("authToken");
    // if(token !=null)
    //   dio.options.headers['token']='$token';
    _initializeInterceptors();
  }

  _initializeInterceptors() {
    dio.interceptors.add(RefreshTokenInterceptor());
    // dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    //     String token = box!.read("authToken");
    //     if (token != null) options.headers['token'] = '$token';
    //     return handler.next(options);
    //   },
    // ));
    // dio.interceptors.add(RefreshTokenInterceptor());
    // dio.interceptors.add(RetryOnConnectionChangeInterceptor(
    //     requestRetrier: DioConnectivityRequestRetrier(
    //         connectivity: Connectivity(),
    //         dio: dio
    //     )
    // ));
  }
}
