import 'package:flutter/material.dart' show Colors, Offset;

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

  // Map Controller
  GoogleMapController _mapController;

  // Polylines
  Polyline _myRoute = Polyline(
    polylineId: PolylineId('my_route'),
    width: 4,
    color: Colors.transparent
  );

  Polyline _myDestRoute = Polyline(
    polylineId: PolylineId('my_dest_route'),
    width: 4,
    color: Colors.black54
  );

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
    } else if (event is OnNewLocation) {
      yield* this._onNewLocation(event);
    } else if (event is OnDrawRoute) {
      yield* this._onDrawRoute(event);
    } else if (event is OnFollowLocation) {
      yield* this._onFollowLocation(event);
    } else if (event is OnMapMoved) {
      yield state.copyWith(centralLocation: event.centralLocation);
    } else if (event is OnCreateRouteInitDestination) {
      yield* this._onCreateRouteInitDestination(event);
    }
  }

  Stream<MapaState> _onNewLocation(OnNewLocation event) async* {
    if (state.followLocation) {
      final location = event.ubicacion;
      this.moveCamera(location);
    }
    final points = [...this._myRoute.points, event.ubicacion];
    this._myRoute = this._myRoute.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = this._myRoute;

    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapaState> _onDrawRoute(OnDrawRoute event) async* {
    if (!state.drawRoute) {
        this._myRoute = this._myRoute.copyWith(colorParam: Colors.blueAccent);
      } else {
        this._myRoute = this._myRoute.copyWith(colorParam: Colors.transparent);
      }

      final currentPolylines = state.polylines;
      currentPolylines['my_route'] = this._myRoute;

      yield state.copyWith(
        drawRoute: !state.drawRoute,
        polylines: currentPolylines
      );
  }

  Stream<MapaState> _onFollowLocation(OnFollowLocation event) async* {
    if (!state.followLocation) {
      this.moveCamera(this._myRoute.points[this._myRoute.points.length - 1]);
    }
    yield state.copyWith(followLocation: !state.followLocation);
  }

  Stream<MapaState> _onCreateRouteInitDestination(OnCreateRouteInitDestination event) async* {
    this._myDestRoute = this._myDestRoute.copyWith(
      pointsParam: event.coordRoutes,
    );

    final currentPolylines = state.polylines;
    currentPolylines['my_dest_route'] = this._myDestRoute;

    // Markers
    final initialMarker = Marker(
      markerId: MarkerId('begining'),
      position: event.coordRoutes[0],
      infoWindow: InfoWindow(
        title: 'Start',
        snippet: 'Duration: ${(event.duration/60).floor()} min',
      )
    );
    double km = event.distance/1000;
    km = (km*100).floorToDouble();
    km = km/100;
    final endMarker = Marker(
      markerId: MarkerId('end'),
      position: event.coordRoutes[event.coordRoutes.length-1],
      infoWindow: InfoWindow(
        title: event.destinationName,
        snippet: 'Distance: $km Km',
      )
    );

    final markers = {...state.markers};
    markers['begining'] = initialMarker;
    markers['end'] = endMarker;

    Future.delayed(Duration(milliseconds: 300)).then(
      (value) {
        _mapController.showMarkerInfoWindow(MarkerId('end'));
      }
    );

    yield state.copyWith(
      polylines: currentPolylines,
      markers: markers
    );
  }
}
