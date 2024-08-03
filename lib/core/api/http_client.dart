import 'package:chopper/chopper.dart';
import 'package:weather_app_test/core/api/additional_params_interceptor.dart';
import 'package:weather_app_test/core/api/geocoding/geocoding_api.dart';
import 'package:weather_app_test/core/api/weather/weather_api.dart';
import 'package:weather_app_test/core/constants/storage_keys.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final chopperProvider = Provider<ChopperClient>(
  (ref) {
    return ChopperClient(
      converter: const JsonConverter(),
      baseUrl: Uri.parse(Constants.baseUrl),
      services: [
        WeatherApiService.create(),
        GeocodingApiService.create(),
      ],
      interceptors: [
        AdditionalParamsInterceptor(),
        HttpLoggingInterceptor(),
        // const HeadersInterceptor({
        //   'accept': 'application/json',
        //   'content-type': 'application/json',
        //   'platform': 'Mobile',
        // }),
      ],
    );
  },
  name: 'dio',
);
