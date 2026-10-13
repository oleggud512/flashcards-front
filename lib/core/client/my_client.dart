import 'dart:convert';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flashcards/core/errors/action_executor.dart';
import 'package:flashcards/core/utils/logger.dart';
import 'package:flutter/foundation.dart';

import '../errors/result.dart';

enum MyClientMethod {
  get("GET"),
  post("POST"),
  put("PUT"),
  patch("PATCH"),
  delete("DELETE");

  final String methodStr;
  const MyClientMethod(this.methodStr);
}

enum NetworkExceptionType {
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  badCertificate,
  badResponse,
  cancel,
  connectionError,
  unknown,
  transformTimeout,
}

typedef ResponseFromJson<T> = T Function(dynamic data);

sealed class MyClientError {}

class MyClientNetworkError extends MyClientError {
  final NetworkExceptionType type;

  MyClientNetworkError({required this.type});
}

class MyClientGenericError extends MyClientError {
  final Object exception;

  MyClientGenericError(this.exception);
}

class MyClient with ActionExecutor {
  final String baseUrl;

  late final Dio _defaultClient;

  MyClient({required this.baseUrl}) {
    _defaultClient = _createDio();
  }

  Dio _createDio() {
    return Dio(
      BaseOptions(
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );
  }

  void close() {
    _defaultClient.close();
  }

  Future<Result<MyClientError, T>> request<T>({
    required MyClientMethod method,
    required String url,
    required ResponseFromJson<T> fromJson,
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool createNewDioInstance = false,
    bool isFullUrl = false,
  }) {
    final client = createNewDioInstance ? _createDio() : _defaultClient;
    final urlToUse = isFullUrl ? url : "$baseUrl$url";
    final baseOptions = Options(
      method: method.methodStr,
      responseType: ResponseType.plain,
    );

    glog.i("""Request: ${method.methodStr} $urlToUse
createNewDioInstance: $createNewDioInstance""");

    return execute(
      () async {
        final response = await client.request(
          urlToUse,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          options: baseOptions,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );

        final dataStr = response.data as String;

        final parsedData = await _isolateParse(dataStr, fromJson);

        if (kDebugMode) {
          final pretty = JsonEncoder.withIndent('  ')
              .convert(jsonDecode(dataStr));
          glog.i(pretty);
        }

        return Success(parsedData);
      },
      onError: (e, log) {
        if (e is DioException) {
          log("Dio Exception");
          return Failure(
            MyClientNetworkError(type: e.type.toNetworkExceptionType()),
          );
        }
        return null;
      },
      createDefault: (e) => Failure(MyClientGenericError(e)),
    );
  }
}

Future<T> _isolateParse<T>(String data, ResponseFromJson<T> fromJson) {
  return Isolate.run(() {
    final parsed = jsonDecode(data);
    return fromJson(parsed);
  });
}

extension DioErrorTypeExt on DioExceptionType {
  NetworkExceptionType toNetworkExceptionType() => switch (this) {
    DioExceptionType.connectionTimeout =>
      NetworkExceptionType.connectionTimeout,
    DioExceptionType.sendTimeout => NetworkExceptionType.sendTimeout,
    DioExceptionType.receiveTimeout => NetworkExceptionType.receiveTimeout,
    DioExceptionType.badCertificate => NetworkExceptionType.badCertificate,
    DioExceptionType.badResponse => NetworkExceptionType.badResponse,
    DioExceptionType.cancel => NetworkExceptionType.cancel,
    DioExceptionType.connectionError => NetworkExceptionType.connectionError,
    DioExceptionType.unknown => NetworkExceptionType.unknown,
    DioExceptionType.transformTimeout => NetworkExceptionType.transformTimeout,
  };
}
