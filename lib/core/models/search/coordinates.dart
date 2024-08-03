// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Coords {
  final double lat;
  final double lon;
  Coords({
    required this.lat,
    required this.lon,
  });

  Coords copyWith({
    double? lat,
    double? lon,
  }) {
    return Coords(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lon': lon,
    };
  }

  factory Coords.fromMap(Map<String, dynamic> map) {
    return Coords(
      lat: map['lat'] as double,
      lon: map['lon'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coords.fromJson(String source) =>
      Coords.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Coords(lat: $lat, lon: $lon)';

  @override
  bool operator ==(covariant Coords other) {
    if (identical(this, other)) return true;

    return other.lat == lat && other.lon == lon;
  }

  @override
  int get hashCode => lat.hashCode ^ lon.hashCode;
}
