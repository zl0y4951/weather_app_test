// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$WeatherApiService extends WeatherApiService {
  _$WeatherApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = WeatherApiService;

  @override
  Future<Response<Map<String, dynamic>>> forecast(
    double lat,
    double lon, {
    int? count = 9,
  }) {
    final Uri $url = Uri.parse('data/2.5/forecast');
    final Map<String, dynamic> $params = <String, dynamic>{
      'lat': lat,
      'lon': lon,
      'cnt': count,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> weather(
    double lat,
    double lon,
  ) {
    final Uri $url = Uri.parse('data/2.5/weather');
    final Map<String, dynamic> $params = <String, dynamic>{
      'lat': lat,
      'lon': lon,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
