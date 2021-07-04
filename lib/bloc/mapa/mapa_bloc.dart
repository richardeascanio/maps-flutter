import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/themes/uber_map_theme.dart';


part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  GoogleMapController _mapController;

  void initMap(GoogleMapController controller) {
    if (!state.mapaListo) {
      this._mapController = controller;
      this._mapController.setMapStyle(jsonEncode(uberMapTheme));

      add(OnMapLoaded());
    }
  }

  void moveCamera(LatLng dest) {
    final cameraUpdate = CameraUpdate.newLatLng(dest);
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapaState> mapEventToState(MapaEvent event,) async* {
    if (event is OnMapLoaded) {
      yield state.copyWith(mapaListo: true);
    }
  }
}
