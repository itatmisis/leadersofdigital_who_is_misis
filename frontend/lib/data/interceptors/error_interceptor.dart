import 'package:dio/dio.dart';
import 'package:frontend/data/exceptions/exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '[${options.method}] ${options.baseUrl}${options.path}';
    final dioException = DioException.fromDioError(err).toString();
    final errorMessage =
        'Error: $dioException\nRequest: $requestPath\nMessage: ${err.message}';

    return super.onError(err, handler);
  }
}
