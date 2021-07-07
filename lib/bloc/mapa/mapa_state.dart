part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool drawRoute;
  final bool followLocation;
  final LatLng centralLocation;

  // Polylines
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  MapaState({
    this.mapaListo = false,
    this.drawRoute = false,
    this.followLocation = false,
    this.centralLocation,
    Map<String, Polyline> polylines,
    Map<String, Marker> markers
  }): this.polylines = polylines ?? new Map(),
      this.markers = markers ?? new Map();

  MapaState copyWith({
    bool mapaListo,
    bool drawRoute,
    bool followLocation,
    LatLng centralLocation,
    Map<String, Polyline> polylines,
    Map<String, Marker> markers
  }) => MapaState(
    mapaListo: mapaListo ?? this.mapaListo,
    drawRoute: drawRoute ?? this.drawRoute,
    polylines: polylines ?? this.polylines,
    markers: markers ?? this.markers,
    followLocation: followLocation ?? this.followLocation,
    centralLocation: centralLocation ?? this.centralLocation
  );
}
