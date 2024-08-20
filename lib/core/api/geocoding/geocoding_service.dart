import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_test/core/api/geocoding/geocoding_api.dart';
import 'package:weather_app_test/core/api/geocoding/geocoding_interface.dart';
import 'package:weather_app_test/core/api/http_client.dart';
import 'package:weather_app_test/core/models/search/geo_city.dart';

final geocodingServiceProvider = Provider.autoDispose<GeocodingRepository>(
  name: 'auth_service',
  (ref) {
    final api = ref.watch(chopperProvider);
    return GeocodingRepository(api);
  },
);

///!!!!
class GeocodingRepository implements IGeocodingRepository {
  const GeocodingRepository(this._client);
  final ChopperClient _client;

  @override
  Future<Iterable<GeoCity>> search(String query, {int count = 1}) async {
    try {
      final GeocodingApiService service =
          _client.getService<GeocodingApiService>();
      final response = await service.search(query, limit: count);
      final List<Map<String, dynamic>>? list = response.body;

      if (response.isSuccessful && list != null) {
        return list.map((e) => GeoCity.fromMap(e));
      } else {
        return [];
      }
    } on Object catch (e) {
      print(e);
      rethrow;
    }
  }
}
