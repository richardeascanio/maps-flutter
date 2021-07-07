part of 'widgets.dart';

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.manualSelection 
        ? Container()
        : FadeInDown(
          duration: Duration(milliseconds: 300),
          child: _BuildSearchBar()
        );
      },
    );
  }
}

class _BuildSearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        width: size.width,
        child: GestureDetector(
          onTap: () async {
            final proximity = BlocProvider.of<MyLocationBloc>(context).state.location;
            final result = await showSearch(
              context: context, 
              delegate: SearchDestination(proximity)
            );
            this.returnSearch(context, result);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
            width: double.infinity,
            child: Text(
              'Where do you want to go?',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 5)
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  Future returnSearch(BuildContext context, SearchResult result) async {

    print('cancelled: ${result.cancelled}');
    print('manual: ${result.manual}');

    if (result.cancelled) return;

    if (result.manual) {
      final searchBloc = BlocProvider.of<SearchBloc>(context);
      searchBloc.add(OnActivateManualMarker());
      return;
    }
    
    calculatingAlert(context);

    final _service = TrafficService();
    final mapBloc = BlocProvider.of<MapaBloc>(context);

    final start = BlocProvider.of<MyLocationBloc>(context).state.location;
    final dest = result.position;

    final drivingResponse = await _service.getInitialAndFinalCoords(start, dest);
    final geometry = drivingResponse.routes[0].geometry;
    final duration = drivingResponse.routes[0].duration;
    final distance = drivingResponse.routes[0].distance;

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

  }
}