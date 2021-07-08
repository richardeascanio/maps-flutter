import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/helpers/debouncer.dart';
import 'package:maps_app/models/reverse_query_response.dart';
import 'package:maps_app/models/routes_response.dart';
import 'package:maps_app/models/search_response.dart';

class TrafficService {

  // Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService() {
    return _instance;
  }

  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 500));
  final _baseUrl = 'api.mapbox.com';
  final _apiKey = 'pk.eyJ1IjoicmljaGFyZGVhc2NhbmlvIiwiYSI6ImNrcXI0d2swZTA1b3AyeW5xbWc5YWsyM2cifQ.1a6gJr3C0iclKk43MHOsYA';

  // ignore: close_sinks
  final StreamController<SearchResponse> _suggestionsStreamController = StreamController.broadcast();
  Stream<SearchResponse> get suggestionsStream  => this._suggestionsStreamController.stream;

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

  Future<SearchResponse> getSearchResults(String query, LatLng proximity) async {
    final endpoint = '/geocoding/v5/mapbox.places/$query.json';

    try {
      final url = Uri.https(_baseUrl, endpoint, {
        'access_token': this._apiKey,
        'autocomplete': 'true',
        'proximity': '${proximity.longitude},${proximity.latitude}',
        'language': 'es',
      });

      final response = await http.get(url);
      final jsonData = response.body;

      final searchResponse = SearchResponse.fromJson(jsonData);
      print(searchResponse);

      return searchResponse;
    } catch (e) {
      return SearchResponse(features: []);
    }
    
  }

  Future<ReverseQueryResponse> getLocationDescription(LatLng location) async {
    final endpoint = '/geocoding/v5/mapbox.places/${location.longitude},${location.latitude}.json';

    final url = Uri.https(_baseUrl, endpoint, {
      'access_token': this._apiKey,
      'language': 'es',
    });

    final response = await http.get(url);
    final jsonData = response.body;

    final reverseQueryResponse = ReverseQueryResponse.fromJson(jsonData);
    return reverseQueryResponse;
  }

  void getSuggestionsByQuery(String query, LatLng proximity) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await this.getSearchResults(query, proximity);
      _suggestionsStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }

}