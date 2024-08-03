import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:weather_app_test/core/models/city_model.dart';
import 'package:weather_app_test/core/models/daily_weather_model.dart';
import 'package:weather_app_test/core/models/search/coordinates.dart';
import 'package:weather_app_test/core/models/weather_model.dart';

part 'database.g.dart';

@DataClassName('Weather')
class WeatherTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get temp => real()();
  IntColumn get humidity => integer().nullable()();
  IntColumn get pressure => integer().nullable()();
  TextColumn get weather => text()();
  IntColumn get city => integer().references(CityTable, #id)();
  DateTimeColumn get sunrise => dateTime().nullable()();
  DateTimeColumn get sunset => dateTime().nullable()();
  DateTimeColumn get datetime => dateTime()();
  @override
  List<Set<Column>> get uniqueKeys => [
        {datetime, city}
      ];
}

@DataClassName('City')
class CityTable extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get coords => text()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DriftDatabase(tables: [CityTable, WeatherTable])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> getOrAddCity(CityModel cityModel) async {
    final city = await (select(cityTable)
          ..where((tbl) => tbl.id.equals(cityModel.id)))
        .getSingleOrNull();

    if (city != null) {
      return city.id;
    } else {
      return await into(cityTable).insert(
        CityTableCompanion(
            id: Value(cityModel.id),
            name: Value(cityModel.name),
            coords: Value(cityModel.coords)),
      );
    }
  }

  Future<DailyWeatherModel?> getWeatherForCurrentTime(Coords coords) async {
    final now = DateTime.now();

    final nearestHour = ((now.hour ~/ 3) * 3) + 3;
    final roundedTime = DateTime(now.year, now.month, now.day, nearestHour);
    final city = await (select(cityTable)
          ..where((tbl) => tbl.coords.equals(coords.toJson())))
        .getSingleOrNull();

    if (city == null) {
      print('City with coordinates $coords not found.');
      return null;
    }

    final weather = await (select(weatherTable)
          ..where((tbl) =>
              tbl.datetime.equals(roundedTime) & tbl.city.equals(city.id)))
        .getSingleOrNull();
    final daily = await (select(weatherTable)
          ..where((tbl) =>
              tbl.datetime.isBiggerOrEqualValue(roundedTime) &
              tbl.city.equals(city.id)))
        .get();
    if (weather != null) {
      return DailyWeatherModel(
          city: CityModel(
            id: city.id,
            name: city.name,
            sunrise: weather.sunrise,
            sunset: weather.sunset,
            coords: city.coords,
          ),
          weather: WeatherModel.fromEntry(weather),
          daily: daily
              .map(
                (e) => WeatherModel.fromEntry(e),
              )
              .toList());
    }
    return null;
  }

  Future<List<WeatherModel>> getWeatherHistory(int cityId) async {
    final weatherHistory = await (select(weatherTable)
          ..where((tbl) => tbl.city.equals(cityId))
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.datetime, mode: OrderingMode.asc)
          ]))
        .get();

    return weatherHistory.map((e) => WeatherModel.fromEntry(e)).toList();
  }

  Future<void> insertWeatherDataBatch(
      List<WeatherModel> weatherModels, CityModel cityModel) async {
    final cityId = await getOrAddCity(cityModel);

    await transaction(() async {
      for (var weatherModel in weatherModels) {
        final existingWeather = await (select(weatherTable)
              ..where((tbl) =>
                  tbl.datetime.equals(weatherModel.dt) &
                  tbl.city.equals(cityId)))
            .getSingleOrNull();

        if (existingWeather == null) {
          final weatherCompanion = WeatherTableCompanion(
            temp: Value(weatherModel.temp),
            humidity: Value(weatherModel.humidity),
            pressure: Value(weatherModel.pressure),
            datetime: Value(weatherModel.dt),
            sunrise: Value(cityModel.sunrise),
            sunset: Value(cityModel.sunset),
            weather: Value(weatherModel.weather),
            city: Value(cityId),
          );

          await into(weatherTable).insert(
            weatherCompanion,
            mode: InsertMode.insertOrIgnore,
          );
        } else {
          print('Weather data for ${weatherModel.dt} already exists.');
        }
      }
    });
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'my_database');
  }
}
