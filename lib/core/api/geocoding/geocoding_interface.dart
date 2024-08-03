import 'package:weather_app_test/core/models/search/geo_city.dart';

abstract interface class IGeocodingRepository {
  Future<Iterable<GeoCity>?> search(String query, {int count});
}
