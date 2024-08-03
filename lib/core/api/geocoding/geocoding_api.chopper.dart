// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoding_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$GeocodingApiService extends GeocodingApiService {
  _$GeocodingApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = GeocodingApiService;

  @override
  Future<Response<List<Map<String, dynamic>>>> search(
    String query, {
    int limit = 1,
  }) {
    final Uri $url = Uri.parse('geo/1.0/direct');
    final Map<String, dynamic> $params = <String, dynamic>{
      'q': query,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<Map<String, dynamic>>, Map<String, dynamic>>($request);
  }
}
