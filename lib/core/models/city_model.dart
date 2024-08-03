// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CityModel {
  final int id;
  final String name;
  final DateTime? sunrise;
  final DateTime? sunset;
  final String coords;
  CityModel({
    required this.id,
    required this.name,
    this.sunrise,
    this.sunset,
    this.coords = '',
  });

  CityModel copyWith({
    int? id,
    String? name,
    DateTime? sunrise,
    DateTime? sunset,
    String? coords,
  }) {
    return CityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      coords: coords ?? this.coords,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'sunrise': sunrise?.millisecondsSinceEpoch,
      'sunset': sunset?.millisecondsSinceEpoch,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'] as int,
      name: map['name'] as String,
      sunrise: map['sys']['sunrise'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (map['sys']['sunrise'] as int) * 1000)
          : null,
      sunset: map['sys']['sunset'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (map['sys']['sunset'] as int) * 1000)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CityModel(name: $name, sunrise: $sunrise, sunset: $sunset)';

  @override
  bool operator ==(covariant CityModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.sunrise == sunrise &&
        other.sunset == sunset;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ sunrise.hashCode ^ sunset.hashCode;
}
