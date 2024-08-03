import 'package:chopper/chopper.dart';

part 'weather_api.chopper.dart';

@ChopperApi(baseUrl: 'data/2.5')
abstract class WeatherApiService extends ChopperService {
  @Get(path: '/forecast')
  Future<Response<Map<String, dynamic>>> forecast(
      @Query('lat') double lat, @Query('lon') double lon,
      {@Query('cnt') int? count = 9});

  @Get(path: '/weather')
  Future<Response<Map<String, dynamic>>> weather(
      @Query('lat') double lat, @Query('lon') double lon);

  static WeatherApiService create([ChopperClient? client]) =>
      _$WeatherApiService(client);
}
