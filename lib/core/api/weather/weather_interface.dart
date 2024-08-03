import 'package:weather_app_test/core/models/daily_weather_model.dart';
import 'package:weather_app_test/core/models/weather_model.dart';

abstract interface class IWeatherRepository {
  Future<DailyWeatherModel?> daily(double lat, double lon);
  Future<List<WeatherModel>?> weekly(double lat, double lon);
}
