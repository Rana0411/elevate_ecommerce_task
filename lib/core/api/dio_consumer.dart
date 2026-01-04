import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../error/error_model.dart';
import 'Endpoints.dart';
import 'api_consumer.dart';
import 'api_interceptors.dart';

class DioConsumer extends ApiConsumer {
  Dio dio;

  DioConsumer(this.dio) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 60);
    dio.options.receiveTimeout = const Duration(seconds: 60);
    dio.options.receiveDataWhenStatusError = true;
    dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        responseHeader: true,
        responseBody: true,
        requestBody: true,
        error: true,
        request: true,
      ),
    );
    dio.interceptors.add(ApiInterceptors());
  }

  @override
  Future<dynamic> get(String path) async {
    try {
      final Response response = await dio.get(path);

      if (response.data == null) {
        throw FormatException('Response data is null');
      }
      return response.data;
    } on DioException catch (e) {
      _handleDioException(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  void _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw Exception("Connection timeout with the server");
      case DioExceptionType.sendTimeout:
        throw Exception("Send timeout in association with the server");
      case DioExceptionType.receiveTimeout:
        throw Exception("Receive timeout in connection with the server");

      case DioExceptionType.badResponse:
        if (e.response?.data != null) {
          // هنا بنحاول نحول الـ response اللي جاي لـ ErrorModel
          final errorData = ErrorModel.fromJson(e.response!.data);
          throw Exception(errorData.errorMessage);
        } else {
          throw Exception("Server error: ${e.response?.statusCode}");
        }
      case DioExceptionType.cancel:
        throw Exception("Request to the server was cancelled");
      case DioExceptionType.connectionError:
        throw Exception("No internet connection or server is unreachable");
      default:
        throw Exception("Something went wrong, please try again later");
    }
  }
}
