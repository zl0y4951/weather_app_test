// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weather_app_test/core/models/search/coordinates.dart';
import 'package:weather_app_test/core/models/search/search_base.dart';

class GeoCity implements ISearchBase<Coords> {
  final String title;
  final String? state;
  final double lat;
  final double lon;
  GeoCity({
    required this.title,
    required this.state,
    required this.lat,
    required this.lon,
  });

  GeoCity copyWith({
    String? title,
    String? state,
    double? lat,
    double? lon,
  }) {
    return GeoCity(
      title: title ?? this.title,
      state: state ?? this.state,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'state': state,
      'lat': lat,
      'lon': lon,
    };
  }

  factory GeoCity.fromMap(Map<String, dynamic> map) {
    return GeoCity(
      title: map['local_names']?['ru'] ?? map['name'] as String,
      state: map['state'] as String?,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
    );
  }

  @override
  String toString() {
    return 'GeoCity(title: $title, state: $state, lat: $lat, lon: $lon)';
  }

  @override
  bool operator ==(covariant GeoCity other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.state == state &&
        other.lat == lat &&
        other.lon == lon;
  }

  @override
  int get hashCode {
    return title.hashCode ^ state.hashCode ^ lat.hashCode ^ lon.hashCode;
  }

  @override
  String get text => title;

  @override
  String? get addText => state;

  @override
  Coords get value => Coords(lat: lat, lon: lon);
}
