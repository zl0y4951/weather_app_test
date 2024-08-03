import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_test/core/models/utils/chart_data.dart';
import 'package:weather_app_test/core/models/weather_model.dart';
import 'package:weather_app_test/core/services/database_provider.dart';

final historyScreenController = StateNotifierProvider.family<
    HistoryScreenNotifier, AsyncValue<List<WeatherModel>>, int>(
  (ref, id) {
    return HistoryScreenNotifier(ref, id)..init();
  },
);

class HistoryScreenNotifier
    extends StateNotifier<AsyncValue<List<WeatherModel>>> {
  HistoryScreenNotifier(this._ref, this.id) : super(const AsyncLoading());
  final int id;
  final StateNotifierProviderRef _ref;

  ({
    ChartData<DateTime, double> temp,
    ChartData<DateTime, int> humidity,
    ChartData<DateTime, int> pressure
  }) getChartData() {
    if (!mounted || state.value == null) {
      return const (
        temp: ChartData(max: 0, min: 0),
        humidity: ChartData(max: 0, min: 0),
        pressure: ChartData(max: 0, min: 0)
      );
    }
    final data = state.value!;
    final Map<DateTime, double> temp = {};
    final Map<DateTime, int> humidity = {};
    final Map<DateTime, int> pressure = {};
    double tempMax = 0;
    double tempMin = double.maxFinite;
    int humidityMin = -1 >>> 1;
    int humidityMax = 0;
    int pressureMin = -1 >>> 1;
    int pressureMax = 0;

    for (var weather in data) {
      temp.addAll({weather.dt: weather.temp});
      if (weather.temp > tempMax) {
        tempMax = weather.temp;
      }
      if (weather.temp < tempMin) {
        tempMin = weather.temp;
      }
      if (weather.humidity != null) {
        humidity.addAll({weather.dt: weather.humidity!});
        if (weather.humidity! > humidityMax) {
          humidityMax = weather.humidity!;
        }
        if (weather.humidity! < humidityMin) {
          humidityMin = weather.humidity!;
        }
      }
      if (weather.pressure != null) {
        pressure.addAll({weather.dt: weather.pressure!});
        if (weather.pressure! > pressureMax) {
          pressureMax = weather.pressure!;
        }
        if (weather.pressure! < pressureMin) {
          pressureMin = weather.pressure!;
        }
      }
    }
    return (
      temp: ChartData(values: temp, min: tempMin, max: tempMax),
      humidity: ChartData(values: humidity, min: humidityMin, max: humidityMax),
      pressure: ChartData(values: pressure, min: pressureMin, max: pressureMax)
    );
  }

  Future<void> init() async {
    final db = _ref.read(databaseProvider);
    final list = await db.getWeatherHistory(id);
    state = AsyncData(list);
  }
}
