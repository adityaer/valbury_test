import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:valbury_test/environment/environment.dart';
import 'package:valbury_test/util/exception.dart';

class BaseRemoteDataSource {
  final Dio client;
  //final BASE_URL = dotenv.env['BASE_URL'];

  final BASE_URL = Platform.environment.containsKey('FLUTTER_TEST')
      ? 'https://my-json-server.typicode.com/adityaer/demo'
      : Environment.baseUrl;

  BaseRemoteDataSource({required this.client});

  Future<T> handleResponse<T>(
    Future<Response> responseFuture,
    T Function(dynamic) parser,
  ) async {
    try {
      final response = await responseFuture;

      if (response.statusCode == 200) {
        return parser(jsonDecode(response.data));
      } else {
        throw ServerException(response.statusMessage!);
      }
    } on FormatException catch (exception) {
      throw ParsingException(exception.toString());
    } on TimeoutException catch (exception) {
      throw ConnectionException(exception.toString());
    } on HttpException catch (exception) {
      throw ServerException(exception.toString());
    } catch (exception) {
      if (exception is DioError && exception.response?.statusCode == 401) {
        throw Exception();
      }

      throw ServerException(exception.toString());
    }
  }
}
