// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app_test/core/db/database.dart';
import 'package:weather_app_test/core/models/wind_model.dart';

class WeatherModel {
  final DateTime dt;
  final num temp;
  final num? pressure;
  final num? humidity;
  final String weather;
  final WindModel? wind;
  const WeatherModel({
    required this.dt,
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.weather,
    this.wind,
  });

  WeatherModel copyWith({
    DateTime? dt,
    num? temp,
    num? pressure,
    num? humidity,
    String? weather,
    WindModel? wind,
  }) {
    return WeatherModel(
      dt: dt ?? this.dt,
      temp: temp ?? this.temp,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      wind: wind ?? this.wind,
      weather: weather ?? this.weather,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dt': dt.millisecondsSinceEpoch,
      'temp': temp,
      'pressure': pressure,
      'humidity': humidity,
      'wind': wind?.toMap(),
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      dt: DateTime.fromMillisecondsSinceEpoch((map['dt'] as int) * 1000),
      temp: map['main']['temp'],
      pressure: map['main']['pressure'],
      humidity: map['main']['humidity'],
      weather: (map['weather']?.first['main'] ?? 'clear') as String,
      wind: map['wind'] != null
          ? WindModel.fromMap(map['wind'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(dt: $dt, temp: $temp, pressure: $pressure, humidity: $humidity, wind: $wind)';
  }

  IconData? get icon {
    switch (weather.toLowerCase()) {
      case 'rain':
        return Icons.umbrella;
      case 'clear':
        return Icons.sunny;
      case 'snow':
        return Icons.snowing;
      case 'mist':
        return Icons.foggy;
      case 'thunderstorm':
        return Icons.thunderstorm;
      default:
        return Icons.cloud;
    }
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.dt == dt &&
        other.temp == temp &&
        other.pressure == pressure &&
        other.humidity == humidity &&
        other.wind == wind;
  }

  @override
  int get hashCode {
    return dt.hashCode ^
        temp.hashCode ^
        pressure.hashCode ^
        humidity.hashCode ^
        wind.hashCode;
  }

  factory WeatherModel.fromEntry(Weather table) {
    return WeatherModel(
      dt: table.datetime,
      temp: table.temp,
      pressure: table.pressure,
      humidity: table.humidity,
      weather: table.weather,
    );
  }
}
