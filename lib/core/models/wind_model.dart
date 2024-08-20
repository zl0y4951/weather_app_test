// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WindModel {
  final num speed;
  final num deg;
  final num? gust;
  WindModel({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  WindModel copyWith({
    num? speed,
    num? deg,
    double? gust,
  }) {
    return WindModel(
      speed: speed ?? this.speed,
      deg: deg ?? this.deg,
      gust: gust ?? this.gust,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }

  factory WindModel.fromMap(Map<String, dynamic> map) {
    return WindModel(
      speed: map['speed'],
      deg: map['deg'],
      gust: map['gust'] != null ? map['gust'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WindModel.fromJson(String source) =>
      WindModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WindModel(speed: $speed, deg: $deg, gust: $gust)';

  @override
  bool operator ==(covariant WindModel other) {
    if (identical(this, other)) return true;

    return other.speed == speed && other.deg == deg && other.gust == gust;
  }

  @override
  int get hashCode => speed.hashCode ^ deg.hashCode ^ gust.hashCode;
}
