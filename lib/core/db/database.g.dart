// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CityTableTable extends CityTable with TableInfo<$CityTableTable, City> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CityTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _coordsMeta = const VerificationMeta('coords');
  @override
  late final GeneratedColumn<String> coords = GeneratedColumn<String>(
      'coords', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, coords];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'city_table';
  @override
  VerificationContext validateIntegrity(Insertable<City> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('coords')) {
      context.handle(_coordsMeta,
          coords.isAcceptableOrUnknown(data['coords']!, _coordsMeta));
    } else if (isInserting) {
      context.missing(_coordsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  City map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return City(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      coords: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}coords'])!,
    );
  }

  @override
  $CityTableTable createAlias(String alias) {
    return $CityTableTable(attachedDatabase, alias);
  }
}

class City extends DataClass implements Insertable<City> {
  final int id;
  final String name;
  final String coords;
  const City({required this.id, required this.name, required this.coords});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['coords'] = Variable<String>(coords);
    return map;
  }

  CityTableCompanion toCompanion(bool nullToAbsent) {
    return CityTableCompanion(
      id: Value(id),
      name: Value(name),
      coords: Value(coords),
    );
  }

  factory City.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return City(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      coords: serializer.fromJson<String>(json['coords']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'coords': serializer.toJson<String>(coords),
    };
  }

  City copyWith({int? id, String? name, String? coords}) => City(
        id: id ?? this.id,
        name: name ?? this.name,
        coords: coords ?? this.coords,
      );
  City copyWithCompanion(CityTableCompanion data) {
    return City(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      coords: data.coords.present ? data.coords.value : this.coords,
    );
  }

  @override
  String toString() {
    return (StringBuffer('City(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('coords: $coords')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, coords);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is City &&
          other.id == this.id &&
          other.name == this.name &&
          other.coords == this.coords);
}

class CityTableCompanion extends UpdateCompanion<City> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> coords;
  const CityTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.coords = const Value.absent(),
  });
  CityTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String coords,
  })  : name = Value(name),
        coords = Value(coords);
  static Insertable<City> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? coords,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (coords != null) 'coords': coords,
    });
  }

  CityTableCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? coords}) {
    return CityTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      coords: coords ?? this.coords,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (coords.present) {
      map['coords'] = Variable<String>(coords.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CityTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('coords: $coords')
          ..write(')'))
        .toString();
  }
}

class $WeatherTableTable extends WeatherTable
    with TableInfo<$WeatherTableTable, Weather> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeatherTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tempMeta = const VerificationMeta('temp');
  @override
  late final GeneratedColumn<double> temp = GeneratedColumn<double>(
      'temp', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _humidityMeta =
      const VerificationMeta('humidity');
  @override
  late final GeneratedColumn<int> humidity = GeneratedColumn<int>(
      'humidity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _pressureMeta =
      const VerificationMeta('pressure');
  @override
  late final GeneratedColumn<int> pressure = GeneratedColumn<int>(
      'pressure', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _weatherMeta =
      const VerificationMeta('weather');
  @override
  late final GeneratedColumn<String> weather = GeneratedColumn<String>(
      'weather', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<int> city = GeneratedColumn<int>(
      'city', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES city_table (id)'));
  static const VerificationMeta _sunriseMeta =
      const VerificationMeta('sunrise');
  @override
  late final GeneratedColumn<DateTime> sunrise = GeneratedColumn<DateTime>(
      'sunrise', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _sunsetMeta = const VerificationMeta('sunset');
  @override
  late final GeneratedColumn<DateTime> sunset = GeneratedColumn<DateTime>(
      'sunset', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _datetimeMeta =
      const VerificationMeta('datetime');
  @override
  late final GeneratedColumn<DateTime> datetime = GeneratedColumn<DateTime>(
      'datetime', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, temp, humidity, pressure, weather, city, sunrise, sunset, datetime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weather_table';
  @override
  VerificationContext validateIntegrity(Insertable<Weather> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('temp')) {
      context.handle(
          _tempMeta, temp.isAcceptableOrUnknown(data['temp']!, _tempMeta));
    } else if (isInserting) {
      context.missing(_tempMeta);
    }
    if (data.containsKey('humidity')) {
      context.handle(_humidityMeta,
          humidity.isAcceptableOrUnknown(data['humidity']!, _humidityMeta));
    }
    if (data.containsKey('pressure')) {
      context.handle(_pressureMeta,
          pressure.isAcceptableOrUnknown(data['pressure']!, _pressureMeta));
    }
    if (data.containsKey('weather')) {
      context.handle(_weatherMeta,
          weather.isAcceptableOrUnknown(data['weather']!, _weatherMeta));
    } else if (isInserting) {
      context.missing(_weatherMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('sunrise')) {
      context.handle(_sunriseMeta,
          sunrise.isAcceptableOrUnknown(data['sunrise']!, _sunriseMeta));
    }
    if (data.containsKey('sunset')) {
      context.handle(_sunsetMeta,
          sunset.isAcceptableOrUnknown(data['sunset']!, _sunsetMeta));
    }
    if (data.containsKey('datetime')) {
      context.handle(_datetimeMeta,
          datetime.isAcceptableOrUnknown(data['datetime']!, _datetimeMeta));
    } else if (isInserting) {
      context.missing(_datetimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {datetime, city},
      ];
  @override
  Weather map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Weather(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      temp: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}temp'])!,
      humidity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}humidity']),
      pressure: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pressure']),
      weather: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}weather'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}city'])!,
      sunrise: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}sunrise']),
      sunset: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}sunset']),
      datetime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}datetime'])!,
    );
  }

  @override
  $WeatherTableTable createAlias(String alias) {
    return $WeatherTableTable(attachedDatabase, alias);
  }
}

class Weather extends DataClass implements Insertable<Weather> {
  final int id;
  final double temp;
  final int? humidity;
  final int? pressure;
  final String weather;
  final int city;
  final DateTime? sunrise;
  final DateTime? sunset;
  final DateTime datetime;
  const Weather(
      {required this.id,
      required this.temp,
      this.humidity,
      this.pressure,
      required this.weather,
      required this.city,
      this.sunrise,
      this.sunset,
      required this.datetime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['temp'] = Variable<double>(temp);
    if (!nullToAbsent || humidity != null) {
      map['humidity'] = Variable<int>(humidity);
    }
    if (!nullToAbsent || pressure != null) {
      map['pressure'] = Variable<int>(pressure);
    }
    map['weather'] = Variable<String>(weather);
    map['city'] = Variable<int>(city);
    if (!nullToAbsent || sunrise != null) {
      map['sunrise'] = Variable<DateTime>(sunrise);
    }
    if (!nullToAbsent || sunset != null) {
      map['sunset'] = Variable<DateTime>(sunset);
    }
    map['datetime'] = Variable<DateTime>(datetime);
    return map;
  }

  WeatherTableCompanion toCompanion(bool nullToAbsent) {
    return WeatherTableCompanion(
      id: Value(id),
      temp: Value(temp),
      humidity: humidity == null && nullToAbsent
          ? const Value.absent()
          : Value(humidity),
      pressure: pressure == null && nullToAbsent
          ? const Value.absent()
          : Value(pressure),
      weather: Value(weather),
      city: Value(city),
      sunrise: sunrise == null && nullToAbsent
          ? const Value.absent()
          : Value(sunrise),
      sunset:
          sunset == null && nullToAbsent ? const Value.absent() : Value(sunset),
      datetime: Value(datetime),
    );
  }

  factory Weather.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Weather(
      id: serializer.fromJson<int>(json['id']),
      temp: serializer.fromJson<double>(json['temp']),
      humidity: serializer.fromJson<int?>(json['humidity']),
      pressure: serializer.fromJson<int?>(json['pressure']),
      weather: serializer.fromJson<String>(json['weather']),
      city: serializer.fromJson<int>(json['city']),
      sunrise: serializer.fromJson<DateTime?>(json['sunrise']),
      sunset: serializer.fromJson<DateTime?>(json['sunset']),
      datetime: serializer.fromJson<DateTime>(json['datetime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'temp': serializer.toJson<double>(temp),
      'humidity': serializer.toJson<int?>(humidity),
      'pressure': serializer.toJson<int?>(pressure),
      'weather': serializer.toJson<String>(weather),
      'city': serializer.toJson<int>(city),
      'sunrise': serializer.toJson<DateTime?>(sunrise),
      'sunset': serializer.toJson<DateTime?>(sunset),
      'datetime': serializer.toJson<DateTime>(datetime),
    };
  }

  Weather copyWith(
          {int? id,
          double? temp,
          Value<int?> humidity = const Value.absent(),
          Value<int?> pressure = const Value.absent(),
          String? weather,
          int? city,
          Value<DateTime?> sunrise = const Value.absent(),
          Value<DateTime?> sunset = const Value.absent(),
          DateTime? datetime}) =>
      Weather(
        id: id ?? this.id,
        temp: temp ?? this.temp,
        humidity: humidity.present ? humidity.value : this.humidity,
        pressure: pressure.present ? pressure.value : this.pressure,
        weather: weather ?? this.weather,
        city: city ?? this.city,
        sunrise: sunrise.present ? sunrise.value : this.sunrise,
        sunset: sunset.present ? sunset.value : this.sunset,
        datetime: datetime ?? this.datetime,
      );
  Weather copyWithCompanion(WeatherTableCompanion data) {
    return Weather(
      id: data.id.present ? data.id.value : this.id,
      temp: data.temp.present ? data.temp.value : this.temp,
      humidity: data.humidity.present ? data.humidity.value : this.humidity,
      pressure: data.pressure.present ? data.pressure.value : this.pressure,
      weather: data.weather.present ? data.weather.value : this.weather,
      city: data.city.present ? data.city.value : this.city,
      sunrise: data.sunrise.present ? data.sunrise.value : this.sunrise,
      sunset: data.sunset.present ? data.sunset.value : this.sunset,
      datetime: data.datetime.present ? data.datetime.value : this.datetime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Weather(')
          ..write('id: $id, ')
          ..write('temp: $temp, ')
          ..write('humidity: $humidity, ')
          ..write('pressure: $pressure, ')
          ..write('weather: $weather, ')
          ..write('city: $city, ')
          ..write('sunrise: $sunrise, ')
          ..write('sunset: $sunset, ')
          ..write('datetime: $datetime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, temp, humidity, pressure, weather, city, sunrise, sunset, datetime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Weather &&
          other.id == this.id &&
          other.temp == this.temp &&
          other.humidity == this.humidity &&
          other.pressure == this.pressure &&
          other.weather == this.weather &&
          other.city == this.city &&
          other.sunrise == this.sunrise &&
          other.sunset == this.sunset &&
          other.datetime == this.datetime);
}

class WeatherTableCompanion extends UpdateCompanion<Weather> {
  final Value<int> id;
  final Value<double> temp;
  final Value<int?> humidity;
  final Value<int?> pressure;
  final Value<String> weather;
  final Value<int> city;
  final Value<DateTime?> sunrise;
  final Value<DateTime?> sunset;
  final Value<DateTime> datetime;
  const WeatherTableCompanion({
    this.id = const Value.absent(),
    this.temp = const Value.absent(),
    this.humidity = const Value.absent(),
    this.pressure = const Value.absent(),
    this.weather = const Value.absent(),
    this.city = const Value.absent(),
    this.sunrise = const Value.absent(),
    this.sunset = const Value.absent(),
    this.datetime = const Value.absent(),
  });
  WeatherTableCompanion.insert({
    this.id = const Value.absent(),
    required double temp,
    this.humidity = const Value.absent(),
    this.pressure = const Value.absent(),
    required String weather,
    required int city,
    this.sunrise = const Value.absent(),
    this.sunset = const Value.absent(),
    required DateTime datetime,
  })  : temp = Value(temp),
        weather = Value(weather),
        city = Value(city),
        datetime = Value(datetime);
  static Insertable<Weather> custom({
    Expression<int>? id,
    Expression<double>? temp,
    Expression<int>? humidity,
    Expression<int>? pressure,
    Expression<String>? weather,
    Expression<int>? city,
    Expression<DateTime>? sunrise,
    Expression<DateTime>? sunset,
    Expression<DateTime>? datetime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (temp != null) 'temp': temp,
      if (humidity != null) 'humidity': humidity,
      if (pressure != null) 'pressure': pressure,
      if (weather != null) 'weather': weather,
      if (city != null) 'city': city,
      if (sunrise != null) 'sunrise': sunrise,
      if (sunset != null) 'sunset': sunset,
      if (datetime != null) 'datetime': datetime,
    });
  }

  WeatherTableCompanion copyWith(
      {Value<int>? id,
      Value<double>? temp,
      Value<int?>? humidity,
      Value<int?>? pressure,
      Value<String>? weather,
      Value<int>? city,
      Value<DateTime?>? sunrise,
      Value<DateTime?>? sunset,
      Value<DateTime>? datetime}) {
    return WeatherTableCompanion(
      id: id ?? this.id,
      temp: temp ?? this.temp,
      humidity: humidity ?? this.humidity,
      pressure: pressure ?? this.pressure,
      weather: weather ?? this.weather,
      city: city ?? this.city,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      datetime: datetime ?? this.datetime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (temp.present) {
      map['temp'] = Variable<double>(temp.value);
    }
    if (humidity.present) {
      map['humidity'] = Variable<int>(humidity.value);
    }
    if (pressure.present) {
      map['pressure'] = Variable<int>(pressure.value);
    }
    if (weather.present) {
      map['weather'] = Variable<String>(weather.value);
    }
    if (city.present) {
      map['city'] = Variable<int>(city.value);
    }
    if (sunrise.present) {
      map['sunrise'] = Variable<DateTime>(sunrise.value);
    }
    if (sunset.present) {
      map['sunset'] = Variable<DateTime>(sunset.value);
    }
    if (datetime.present) {
      map['datetime'] = Variable<DateTime>(datetime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeatherTableCompanion(')
          ..write('id: $id, ')
          ..write('temp: $temp, ')
          ..write('humidity: $humidity, ')
          ..write('pressure: $pressure, ')
          ..write('weather: $weather, ')
          ..write('city: $city, ')
          ..write('sunrise: $sunrise, ')
          ..write('sunset: $sunset, ')
          ..write('datetime: $datetime')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $CityTableTable cityTable = $CityTableTable(this);
  late final $WeatherTableTable weatherTable = $WeatherTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cityTable, weatherTable];
}

typedef $$CityTableTableCreateCompanionBuilder = CityTableCompanion Function({
  Value<int> id,
  required String name,
  required String coords,
});
typedef $$CityTableTableUpdateCompanionBuilder = CityTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> coords,
});

class $$CityTableTableTableManager extends RootTableManager<
    _$Database,
    $CityTableTable,
    City,
    $$CityTableTableFilterComposer,
    $$CityTableTableOrderingComposer,
    $$CityTableTableCreateCompanionBuilder,
    $$CityTableTableUpdateCompanionBuilder> {
  $$CityTableTableTableManager(_$Database db, $CityTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CityTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CityTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> coords = const Value.absent(),
          }) =>
              CityTableCompanion(
            id: id,
            name: name,
            coords: coords,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String coords,
          }) =>
              CityTableCompanion.insert(
            id: id,
            name: name,
            coords: coords,
          ),
        ));
}

class $$CityTableTableFilterComposer
    extends FilterComposer<_$Database, $CityTableTable> {
  $$CityTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get coords => $state.composableBuilder(
      column: $state.table.coords,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter weatherTableRefs(
      ComposableFilter Function($$WeatherTableTableFilterComposer f) f) {
    final $$WeatherTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.weatherTable,
        getReferencedColumn: (t) => t.city,
        builder: (joinBuilder, parentComposers) =>
            $$WeatherTableTableFilterComposer(ComposerState($state.db,
                $state.db.weatherTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$CityTableTableOrderingComposer
    extends OrderingComposer<_$Database, $CityTableTable> {
  $$CityTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get coords => $state.composableBuilder(
      column: $state.table.coords,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$WeatherTableTableCreateCompanionBuilder = WeatherTableCompanion
    Function({
  Value<int> id,
  required double temp,
  Value<int?> humidity,
  Value<int?> pressure,
  required String weather,
  required int city,
  Value<DateTime?> sunrise,
  Value<DateTime?> sunset,
  required DateTime datetime,
});
typedef $$WeatherTableTableUpdateCompanionBuilder = WeatherTableCompanion
    Function({
  Value<int> id,
  Value<double> temp,
  Value<int?> humidity,
  Value<int?> pressure,
  Value<String> weather,
  Value<int> city,
  Value<DateTime?> sunrise,
  Value<DateTime?> sunset,
  Value<DateTime> datetime,
});

class $$WeatherTableTableTableManager extends RootTableManager<
    _$Database,
    $WeatherTableTable,
    Weather,
    $$WeatherTableTableFilterComposer,
    $$WeatherTableTableOrderingComposer,
    $$WeatherTableTableCreateCompanionBuilder,
    $$WeatherTableTableUpdateCompanionBuilder> {
  $$WeatherTableTableTableManager(_$Database db, $WeatherTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WeatherTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WeatherTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<double> temp = const Value.absent(),
            Value<int?> humidity = const Value.absent(),
            Value<int?> pressure = const Value.absent(),
            Value<String> weather = const Value.absent(),
            Value<int> city = const Value.absent(),
            Value<DateTime?> sunrise = const Value.absent(),
            Value<DateTime?> sunset = const Value.absent(),
            Value<DateTime> datetime = const Value.absent(),
          }) =>
              WeatherTableCompanion(
            id: id,
            temp: temp,
            humidity: humidity,
            pressure: pressure,
            weather: weather,
            city: city,
            sunrise: sunrise,
            sunset: sunset,
            datetime: datetime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required double temp,
            Value<int?> humidity = const Value.absent(),
            Value<int?> pressure = const Value.absent(),
            required String weather,
            required int city,
            Value<DateTime?> sunrise = const Value.absent(),
            Value<DateTime?> sunset = const Value.absent(),
            required DateTime datetime,
          }) =>
              WeatherTableCompanion.insert(
            id: id,
            temp: temp,
            humidity: humidity,
            pressure: pressure,
            weather: weather,
            city: city,
            sunrise: sunrise,
            sunset: sunset,
            datetime: datetime,
          ),
        ));
}

class $$WeatherTableTableFilterComposer
    extends FilterComposer<_$Database, $WeatherTableTable> {
  $$WeatherTableTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get temp => $state.composableBuilder(
      column: $state.table.temp,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get humidity => $state.composableBuilder(
      column: $state.table.humidity,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get pressure => $state.composableBuilder(
      column: $state.table.pressure,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get weather => $state.composableBuilder(
      column: $state.table.weather,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get sunrise => $state.composableBuilder(
      column: $state.table.sunrise,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get sunset => $state.composableBuilder(
      column: $state.table.sunset,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get datetime => $state.composableBuilder(
      column: $state.table.datetime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CityTableTableFilterComposer get city {
    final $$CityTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.city,
        referencedTable: $state.db.cityTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CityTableTableFilterComposer(ComposerState(
                $state.db, $state.db.cityTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$WeatherTableTableOrderingComposer
    extends OrderingComposer<_$Database, $WeatherTableTable> {
  $$WeatherTableTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get temp => $state.composableBuilder(
      column: $state.table.temp,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get humidity => $state.composableBuilder(
      column: $state.table.humidity,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get pressure => $state.composableBuilder(
      column: $state.table.pressure,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get weather => $state.composableBuilder(
      column: $state.table.weather,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get sunrise => $state.composableBuilder(
      column: $state.table.sunrise,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get sunset => $state.composableBuilder(
      column: $state.table.sunset,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get datetime => $state.composableBuilder(
      column: $state.table.datetime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CityTableTableOrderingComposer get city {
    final $$CityTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.city,
        referencedTable: $state.db.cityTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CityTableTableOrderingComposer(ComposerState(
                $state.db, $state.db.cityTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$CityTableTableTableManager get cityTable =>
      $$CityTableTableTableManager(_db, _db.cityTable);
  $$WeatherTableTableTableManager get weatherTable =>
      $$WeatherTableTableTableManager(_db, _db.weatherTable);
}
