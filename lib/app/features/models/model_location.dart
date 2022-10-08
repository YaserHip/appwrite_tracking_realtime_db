// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ModelLocation {
  const ModelLocation({
    required this.lat,
    required this.lon,
  });
  final String lat;
  final String lon;

  ModelLocation copyWith({
    String? lat,
    String? lon,
  }) {
    return ModelLocation(
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

  factory ModelLocation.fromMap(Map<String, dynamic> map) {
    return ModelLocation(
      lat: map['lat'] as String,
      lon: map['lon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelLocation.fromJson(String source) =>
      ModelLocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ModelLocation(lat: $lat, lon: $lon)';

  @override
  bool operator ==(covariant ModelLocation other) {
    if (identical(this, other)) return true;

    return other.lat == lat && other.lon == lon;
  }

  @override
  int get hashCode => lat.hashCode ^ lon.hashCode;
}
