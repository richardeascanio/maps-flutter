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
      body: Stack(
        children: [
          BlocBuilder<MyLocationBloc, MyLocationState>(
            builder: (_, state) => createMap(state),
          ),

          Positioned(
            top: 10.0,
            child: SearchBar()
          ),
          
          ManualMarker()
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CenterLocationButton(),
          FollowLocationButton(),
          RouteButton(),
        ],
      ),
    );
  }

  Widget createMap(MyLocationState state) {

    if (!state.locationExists) return Center(child: Text('Locating...'));

    final mapBloc = BlocProvider.of<MapaBloc>(context);

    mapBloc.add(OnNewLocation(state.location));

    CameraPosition _cameraPosition = CameraPosition(
      target: state.location,
      zoom: 14.4746
    );

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, _) {
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _cameraPosition,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          onMapCreated: mapBloc.initMap,
          polylines: mapBloc.state.polylines.values.toSet(),
          onCameraMove: (position) {
            mapBloc.add(OnMapMoved(position.target));
          },
        );
      },
    );

    

  }
}