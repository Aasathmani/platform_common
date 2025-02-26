import 'package:dio/dio.dart';

class NetworkUsageInterceptor extends InterceptorsWrapper {
  static final _singleton = NetworkUsageInterceptor._internal();

  factory NetworkUsageInterceptor() => _singleton;

  NetworkUsageInterceptor._internal();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.onSendProgress = (sent, total) {
      options.extra['sent_bytes'] = sent;
    };
    options.onReceiveProgress = (received, total) {
      options.extra['received_bytes'] = received;
    };
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logNetworkUsage(response.requestOptions);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logNetworkUsage(err.requestOptions);
    super.onError(err, handler);
  }

  void _logNetworkUsage(RequestOptions options) {
    /*  provideNetworkUsageRepository().log(
      sentBytes: options.extra['sent_bytes'] ?? 0,
      receivedBytes: options.extra['received_bytes'] ?? 0,
    );*/
  }
}
