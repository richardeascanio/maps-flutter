import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'my_location_event.dart';
part 'my_location_state.dart';

class MyLocationBloc extends Bloc<MyLocationEvent, MyLocationState> {
  MyLocationBloc() : super(MyLocationState());

  final _geolocator = new Geolocator();
  StreamSubscription<Position> _positionSubscription;

  void initLocationListener() {

    final locationOptions = LocationOptions(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10
    );

    _positionSubscription = this._geolocator.getPositionStream(locationOptions).listen((Position position) {
      print(position);
      final newLocation = new LatLng(position.latitude, position.longitude);
      add(OnLocationChanged(newLocation));
    });
  }

  void cancelLocationListener() {
    _positionSubscription?.cancel();
  }

  @override
  Stream<MyLocationState> mapEventToState(MyLocationEvent event) async* {
    if (event is OnLocationChanged) {
      yield state.copyWith(
        locationExists: true,
        location: event.location
      );
    }
  }
}
