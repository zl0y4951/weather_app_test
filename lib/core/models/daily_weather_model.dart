// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

import 'package:weather_app_test/core/models/city_model.dart';
import 'package:weather_app_test/core/models/weather_model.dart';

class DailyWeatherModel {
  final CityModel city;
  final List<WeatherModel> daily;
  final WeatherModel weather;
  DailyWeatherModel({
    required this.city,
    this.daily = const [],
    required this.weather,
  });

  DailyWeatherModel copyWith({
    CityModel? city,
    List<WeatherModel>? daily,
    WeatherModel? weather,
  }) {
    return DailyWeatherModel(
      city: city ?? this.city,
      daily: daily ?? this.daily,
      weather: weather ?? this.weather,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': city.toMap(),
      'daily': daily.map((x) => x.toMap()).toList(),
      'weather': weather.toMap(),
    };
  }

  factory DailyWeatherModel.fromMap(Map<String, dynamic> map) {
    return DailyWeatherModel(
      city: CityModel.fromMap(map['city'] as Map<String, dynamic>),
      daily: List<WeatherModel>.from(
        (map['daily'] as List<int>).map<WeatherModel>(
          (x) => WeatherModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      weather: WeatherModel.fromMap(map['weather'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() =>
      'DailyWeatherModel(city: $city, daily: $daily, weather: $weather)';

  @override
  bool operator ==(covariant DailyWeatherModel other) {
    if (identical(this, other)) return true;

    return other.city == city &&
        listEquals(other.daily, daily) &&
        other.weather == weather;
  }

  @override
  int get hashCode => city.hashCode ^ daily.hashCode ^ weather.hashCode;
}
