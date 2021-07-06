part of 'widgets.dart';

class ManualMarker extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.manualSelection 
        ? _BuildManualMarker() 
        : Container();
      },
    );
  }
}

class _BuildManualMarker extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final searchBloc = BlocProvider.of<SearchBloc>(context);

    return Stack(
      children: [
        Positioned(
          top: 70.0,
          left: 20.0,
          child: FadeInLeft(
            duration: Duration(milliseconds: 250),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
                onPressed: () {
                  searchBloc.add(OnDeactivateManualMarker());
                },
              ),
            ),
          )
        ),

        Center(
          child: Transform.translate(
            offset: Offset(0, -20),
            child: BounceInDown(
              from: 200,
              child: Icon(
                Icons.location_on,
                size: 50,
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            child: MaterialButton(
              minWidth: size.width - 120,
              child: Text(
                'Confirm location',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
                )
              ),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () {
                this.getDestination(context);
              }
            ),
          )
        )

      ],
    );
  }

  void getDestination(BuildContext context) async {

    calculatingAlert(context);
    final trafficService = TrafficService();
    final mapBloc = BlocProvider.of<MapaBloc>(context);
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    final beginning = BlocProvider.of<MyLocationBloc>(context).state.location;
    final destination = mapBloc.state.centralLocation;

    final routesResponse = await trafficService.getInitialAndFinalCoords(beginning, destination);
    final geometry = routesResponse.routes[0].geometry;
    final duration = routesResponse.routes[0].duration;
    final distance = routesResponse.routes[0].distance;
    
    // Decode geometry points
    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6).decodedCoords;
    final List<LatLng> coordList = points.map(
      (point) => LatLng(point[0], point[1])
    ).toList();

    mapBloc.add(OnCreateRouteInitDestination(
      coordRoutes: coordList, 
      distance: distance, 
      duration: duration)
    );

    Navigator.of(context).pop();

    searchBloc.add(OnDeactivateManualMarker());
  }
}