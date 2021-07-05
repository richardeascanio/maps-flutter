part of 'widgets.dart';

class FollowLocationButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapaBloc>(context);

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (_, state) {
        return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              onPressed: () {
                mapBloc.add(OnFollowLocation());
              }, 
              icon: Icon(
                mapBloc.state.followLocation 
                ? Icons.directions_run 
                : Icons.accessibility_new, 
                color: Colors.black87,
              )
            ),
          ),
        );
      } 
    );
  }
}