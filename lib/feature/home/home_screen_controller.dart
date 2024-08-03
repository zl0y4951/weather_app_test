import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_test/core/api/geocoding/geocoding_service.dart';
import 'package:weather_app_test/core/api/weather/weather_service.dart';
import 'package:weather_app_test/core/models/daily_weather_model.dart';
import 'package:weather_app_test/core/models/search/coordinates.dart';
import 'package:weather_app_test/core/models/search/geo_city.dart';
import 'package:weather_app_test/core/services/database_provider.dart';
import 'package:weather_app_test/core/services/shared_provider.dart';

final homeScreenController =
    StateNotifierProvider<HomeScreenNotifier, AsyncValue<DailyWeatherModel>>(
  (ref) {
    return HomeScreenNotifier(ref)..init();
  },
);

class HomeScreenNotifier extends StateNotifier<AsyncValue<DailyWeatherModel>> {
  HomeScreenNotifier(this._ref) : super(const AsyncLoading());
  final StateNotifierProviderRef _ref;

  Future<void> init() async {
    final database = _ref.read(databaseProvider);
    final Coords coords;
    //cache
    if (_ref.read(sharedPreferencesProvider).containsKey('weather.mainCity')) {
      coords = Coords.fromJson(
          _ref.read(sharedPreferencesProvider).getString('weather.mainCity')!);
      final dbResult = await database.getWeatherForCurrentTime(coords);
      if (dbResult != null) {
        state = AsyncData(dbResult);
        return;
      }
    } else {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      coords = Coords(lat: position.latitude, lon: position.longitude);
    }

    final result =
        await _ref.read(weatherServiceProvider).daily(coords.lat, coords.lon);

    if (result != null) {
      await database.insertWeatherDataBatch(
        result.daily,
        result.city.copyWith(
          coords: coords.toJson(),
        ),
      );
      state = AsyncData(
          result.copyWith(city: result.city.copyWith(coords: coords.toJson())));
    }
  }

  Future<Iterable<GeoCity>?> search(String query) async {
    if (query.isNotEmpty) {
      final resp =
          await _ref.read(geocodingServiceProvider).search(query, count: 5);
      return resp;
    }
    return null;
  }

  Future<void> choose(Coords coords, [bool save = false]) async {
    final result =
        await _ref.read(weatherServiceProvider).daily(coords.lat, coords.lon);

    if (result != null) {
      if (save) {
        _ref
            .read(sharedPreferencesProvider)
            .setString('weather.mainCity', coords.toJson());
      }

      await _ref.read(databaseProvider).insertWeatherDataBatch(
            result.daily,
            result.city.copyWith(
              coords: coords.toJson(),
            ),
          );
      state = AsyncData(
          result.copyWith(city: result.city.copyWith(coords: coords.toJson())));
    }
  }
}
