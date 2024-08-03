import 'package:flutter/material.dart';
import 'package:weather_app_test/core/constants/colors.dart';
import 'package:weather_app_test/core/extensions/time_format.dart';
import 'package:weather_app_test/core/models/weather_model.dart';

class HourCard extends StatelessWidget {
  const HourCard({super.key, required this.weather});
  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 78,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: CustomColors.light,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Column(
          children: [
            Text(weather.dt.hhmm),
            Icon(weather.icon),
            Text(
              '${weather.temp}°',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
