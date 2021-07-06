import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/routes_response.dart';

class TrafficService {

  // Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService() {
    return _instance;
  }

  final _dio = Dio();
  final _baseUrl = 'api.mapbox.com';
  final _apiKey = 'pk.eyJ1IjoicmljaGFyZGVhc2NhbmlvIiwiYSI6ImNrcXI0d2swZTA1b3AyeW5xbWc5YWsyM2cifQ.1a6gJr3C0iclKk43MHOsYA';

  Future<RoutesResponse> getInitialAndFinalCoords(LatLng from, LatLng to) async {
    final stringCoords = '${from.longitude},${from.latitude};${to.longitude},${to.latitude}';
    final endpoint = '/directions/v5/mapbox/driving/$stringCoords';

    final url = Uri.https(_baseUrl, endpoint, {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': this._apiKey,
      'language': 'es',
    });

    final response = await http.get(url);
    final jsonData = response.body;

    final routesResponse = RoutesResponse.fromJson(jsonData);

    return routesResponse;
  }

}