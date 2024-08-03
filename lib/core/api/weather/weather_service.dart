import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_test/core/api/http_client.dart';
import 'package:weather_app_test/core/api/weather/weather_api.dart';
import 'package:weather_app_test/core/api/weather/weather_interface.dart';
import 'package:weather_app_test/core/models/city_model.dart';
import 'package:weather_app_test/core/models/daily_weather_model.dart';
import 'package:weather_app_test/core/models/weather_model.dart';

final weatherServiceProvider = Provider.autoDispose<WeatherRepository>(
  name: 'auth_service',
  (ref) {
    final api = ref.watch(chopperProvider);
    return WeatherRepository(api);
  },
);

///!!!!
class WeatherRepository implements IWeatherRepository {
  const WeatherRepository(this._client);
  final ChopperClient _client;

  @override
  Future<DailyWeatherModel?> daily(double lat, double lon) async {
    try {
      final WeatherApiService service = _client.getService<WeatherApiService>();
      final weather = await service.weather(lat, lon);
      final forecast = await service.forecast(lat, lon);
      final Map<String, dynamic>? map = weather.body;
      final Map<String, dynamic>? forecastMap = forecast.body;

      if (forecast.isSuccessful &&
          weather.isSuccessful &&
          map != null &&
          forecastMap != null) {
        return DailyWeatherModel(
            city: CityModel.fromMap(map),
            daily: List<WeatherModel>.from(
                forecastMap['list'].map((e) => WeatherModel.fromMap(e))),
            weather: WeatherModel.fromMap(map));
      } else {
        return null;
      }
    } on Object {
      rethrow;
    }
  }

  @override
  Future<List<WeatherModel>> weekly(double lat, double lon) async {
    try {
      final WeatherApiService service = _client.getService<WeatherApiService>();
      final forecast = await service.forecast(lat, lon, count: null);
      final Map<String, dynamic>? forecastMap = forecast.body;

      if (forecast.isSuccessful && forecastMap != null) {
        return List<WeatherModel>.from(
            forecastMap['list'].map((e) => WeatherModel.fromMap(e)));
      } else {
        return [];
      }
    } on Object {
      rethrow;
    }
  }
}
