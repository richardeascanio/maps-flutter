part of 'widgets.dart';

class RouteButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapaBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          onPressed: () {
            mapBloc.add(OnDrawRoute());
          },
          icon: Icon(Icons.more_horiz, color: Colors.black87,)
        ),
      ),
    );
  }
}