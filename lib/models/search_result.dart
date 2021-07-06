import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {

  final bool cancelled;
  final bool manual;
  final LatLng position;
  final String locationName;
  final String description;

  SearchResult({
    this.cancelled, 
    this.manual, 
    this.position, 
    this.locationName, 
    this.description
  });

}