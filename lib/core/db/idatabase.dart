import 'package:weather_app_test/core/models/city_model.dart';
import 'package:weather_app_test/core/models/daily_weather_model.dart';
import 'package:weather_app_test/core/models/search/coordinates.dart';
import 'package:weather_app_test/core/models/weather_model.dart';

abstract interface class IDatabase {
  Future<int> getOrAddCity(CityModel cityModel);
  Future<DailyWeatherModel?> getWeatherForCurrentTime(Coords coords);
  Future<List<WeatherModel>> getWeatherHistory(int cityId);
  Future<void> insertWeatherDataBatch(
      List<WeatherModel> weatherModels, CityModel cityModel);
}
