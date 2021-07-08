part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent{}

class OnMapLoaded extends MapaEvent {}

class OnDrawRoute extends MapaEvent {}

class OnFollowLocation extends MapaEvent {}

class OnCreateRouteInitDestination extends MapaEvent {
  final List<LatLng> coordRoutes;
  final double distance;
  final double duration;
  final String destinationName;

  OnCreateRouteInitDestination(this.destinationName, this.coordRoutes, this.distance, this.duration);
}

class OnMapMoved extends MapaEvent {
  final LatLng centralLocation;

  OnMapMoved(this.centralLocation);
}

class OnNewLocation extends MapaEvent {
  final LatLng ubicacion;

  OnNewLocation(this.ubicacion);
}
