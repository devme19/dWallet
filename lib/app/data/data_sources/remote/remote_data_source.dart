import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:dwallet/app/core/exception.dart';
import 'package:dwallet/app/data/data_sources/remote/client.dart';

abstract class AppRemoteDataSource {
  Future<Response> get({String url, Map<String, dynamic> queryParameters});
  Future<Response> post({String url, Map<String, dynamic> body});
  Future<bool> delete({String url});
  Future<bool> requestMultiPart(
      {String url, FormData formData, ValueChanged<double> uploadedAmount});

}

class AppRemoteDataSourceImpl implements AppRemoteDataSource {
  @override
  Future<bool> delete({String? url}) async {
    try {
      Response response = await Client().dio.delete(url!);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw ServerException(
            errorCode: 101, errorMessage: "خطا در برقراری ارتباط");
      } else {
        throw ServerException(
            errorCode: e.response!.statusCode,
            errorMessage: e.response!.statusMessage);
      }
    }
  }

  @override
  Future<Response> get(
      {String? url, Map<String, dynamic>? queryParameters}) async {
    try {
      Response response =
          await Client().dio.get(url!, queryParameters: queryParameters!);
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw ServerException(
            errorCode: 101, errorMessage: "خطا در برقراری ارتباط");
      } else {
        throw ServerException(
            errorCode: e.response!.statusCode,
            errorMessage: e.response!.statusMessage);
      }
    }
  }

  @override
  Future<Response> post({String? url, Map<String, dynamic>? body}) async {
    try {
      Response response = await Client().dio.post(url!, data: body!);
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw ServerException(
            errorCode: 101, errorMessage: "خطا در برقراری ارتباط");
      } else {
        throw ServerException(
            errorCode: e.response!.statusCode,
            errorMessage: e.response!.statusMessage);
      }
    }
  }

  @override
  Future<bool> requestMultiPart(
      {String? url,
      FormData? formData,
      ValueChanged<double>? uploadedAmount}) async {
    try {
      Response response = await Client().dio.post(url!, data: formData!,
          onSendProgress: (int sent, int total) {
        uploadedAmount!(sent / total);
        print("uploaded : ${sent / total}");
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.other) {
        throw ServerException(
            errorCode: 101, errorMessage: "خطا در برقراری ارتباط");
      } else {
        throw ServerException(
            errorCode: e.response!.statusCode,
            errorMessage: e.response!.statusMessage);
      }
    }
  }
}
