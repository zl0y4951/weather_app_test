import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_test/core/api/weather/weather_service.dart';
import 'package:weather_app_test/core/models/weather_model.dart';

final weeklyScreenController = StateNotifierProvider.family<
    WeeklyScreenNotifier, AsyncValue<List<WeatherModel>>, (double, double)>(
  (ref, coords) {
    final weatherRep = ref.read(weatherServiceProvider);
    return WeeklyScreenNotifier(coords, weatherRep)..init();
  },
);

class WeeklyScreenNotifier
    extends StateNotifier<AsyncValue<List<WeatherModel>>> {
  WeeklyScreenNotifier(this.coords, this._weatherRepository)
      : super(const AsyncLoading());
  final (double lat, double lon) coords;

  final WeatherRepository _weatherRepository;

  Future<void> init() async {
    final weatherList = await _weatherRepository.weekly(coords.$1, coords.$2);
    state = AsyncData(weatherList);
  }
}
