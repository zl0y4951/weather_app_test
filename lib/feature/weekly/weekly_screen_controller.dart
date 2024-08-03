import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_test/core/api/weather/weather_service.dart';
import 'package:weather_app_test/core/models/weather_model.dart';

final weeklyScreenController = StateNotifierProvider.family<
    WeeklyScreenNotifier, AsyncValue<List<WeatherModel>>, (double, double)>(
  (ref, coords) {
    return WeeklyScreenNotifier(ref, coords)..init();
  },
);

class WeeklyScreenNotifier
    extends StateNotifier<AsyncValue<List<WeatherModel>>> {
  WeeklyScreenNotifier(this._ref, this.coords) : super(const AsyncLoading());
  final (double lat, double lon) coords;
  final StateNotifierProviderRef _ref;

  Future<void> init() async {
    final weatherList =
        await _ref.read(weatherServiceProvider).weekly(coords.$1, coords.$2);
    state = AsyncData(weatherList);
  }
}
