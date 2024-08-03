import 'package:chopper/chopper.dart';

part 'geocoding_api.chopper.dart';

@ChopperApi(baseUrl: 'geo/1.0')
abstract class GeocodingApiService extends ChopperService {
  @Get(path: '/direct')
  Future<Response<List<Map<String, dynamic>>>> search(@Query('q') String query,
      {@Query('limit') int limit = 1});

  static GeocodingApiService create([ChopperClient? client]) =>
      _$GeocodingApiService(client);
}
