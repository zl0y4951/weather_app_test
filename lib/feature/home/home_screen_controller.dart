import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_test/core/api/geocoding/geocoding_service.dart';
import 'package:weather_app_test/core/api/weather/weather_service.dart';
import 'package:weather_app_test/core/db/idatabase.dart';
import 'package:weather_app_test/core/models/daily_weather_model.dart';
import 'package:weather_app_test/core/models/search/coordinates.dart';
import 'package:weather_app_test/core/models/search/geo_city.dart';
import 'package:weather_app_test/core/services/database_provider.dart';
import 'package:weather_app_test/core/services/shared_provider.dart';

final homeScreenController =
    StateNotifierProvider<HomeScreenNotifier, AsyncValue<DailyWeatherModel>>(
  (ref) {
    final sharedPrefs = ref.read(sharedPreferencesProvider);
    final weatherRep = ref.read(weatherServiceProvider);
    final geocodingRep = ref.read(geocodingServiceProvider);
    final database = ref.read(databaseProvider);
    return HomeScreenNotifier(sharedPrefs, weatherRep, geocodingRep, database)
      ..init();
  },
);

class HomeScreenNotifier extends StateNotifier<AsyncValue<DailyWeatherModel>> {
  HomeScreenNotifier(this._prefs, this._weatherRepository,
      this._geocodingRepository, this.database)
      : super(const AsyncLoading());
  final IDatabase database;
  final SharedPreferences _prefs;
  final WeatherRepository _weatherRepository;
  final GeocodingRepository _geocodingRepository;

  Future<void> init() async {
    final Coords coords;
    //cache
    if (_prefs.containsKey('weather.mainCity')) {
      coords = Coords.fromJson(_prefs.getString('weather.mainCity')!);
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

    final result = await _weatherRepository.daily(coords.lat, coords.lon);

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
      final resp = await _geocodingRepository.search(query, count: 5);
      return resp;
    }
    return null;
  }

  Future<void> choose(Coords coords, [bool save = false]) async {
    final result = await _weatherRepository.daily(coords.lat, coords.lon);

    if (result != null) {
      if (save) {
        _prefs.setString('weather.mainCity', coords.toJson());
      }

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
}
