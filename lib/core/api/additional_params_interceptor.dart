import 'dart:async';

import 'package:chopper/chopper.dart';

final class AdditionalParamsInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    Request request = chain.request;
    if (request.parameters.containsKey('appid')) {
      chain.proceed(request);
    }
    if (request.parameters.containsKey('units')) {
      chain.proceed(request);
    }
    if (request.parameters.containsKey('lang')) {
      chain.proceed(request);
    }
    request = request.copyWith(parameters: {
      ...request.parameters,
      'appid': const String.fromEnvironment('apiToken', defaultValue: 'notoken')
    });
    request = request.copyWith(parameters: {
      ...request.parameters,
      'units': 'metric',
    });
    request = request.copyWith(parameters: {
      ...request.parameters,
      'lang': 'ru',
    });
    return chain.proceed(request);
  }
}
