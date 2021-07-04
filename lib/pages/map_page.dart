import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app/bloc/my_location/my_location_bloc.dart';
import 'package:maps_app/bloc/mapa/mapa_bloc.dart';
import 'package:maps_app/widgets/widgets.dart';

class MapPage extends StatefulWidget {

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  @override
  void initState() { 
    super.initState();
    context.read<MyLocationBloc>().initLocationListener();
  }

  @override
    void dispose() {
      context.read<MyLocationBloc>().cancelLocationListener();
      super.dispose();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyLocationBloc, MyLocationState>(
        builder: (_, state) => createMap(state),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CenterLocationButton()
        ],
      ),
    );
  }

  Widget createMap(MyLocationState state) {

    if (!state.locationExists) return Center(child: Text('Locating...'));

    final mapBloc = BlocProvider.of<MapaBloc>(context);

    CameraPosition _cameraPosition = CameraPosition(
      target: state.location,
      zoom: 14.4746
    );

    return GoogleMap(
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      initialCameraPosition: _cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      onMapCreated: mapBloc.initMap,
    );

  }
}