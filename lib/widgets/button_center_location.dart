part of 'widgets.dart';

class CenterLocationButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapaBloc>(context);
    final locationBloc = BlocProvider.of<MyLocationBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          onPressed: () {
            final dest = locationBloc.state.location;
            mapBloc.moveCamera(dest);
          }, 
          icon: Icon(Icons.my_location, color: Colors.black87,)
        ),
      ),
    );
  }
}