part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent{}

class OnMapLoaded extends MapaEvent {}

class OnDrawRoute extends MapaEvent {}

class OnFollowLocation extends MapaEvent {}

class OnMapMoved extends MapaEvent {
  final LatLng centralLocation;

  OnMapMoved(this.centralLocation);
}

class OnNewLocation extends MapaEvent {
  final LatLng ubicacion;

  OnNewLocation(this.ubicacion);
}
