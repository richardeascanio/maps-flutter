import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:maps_app/pages/access_gps_page.dart';
import 'package:maps_app/pages/map_page.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {

  @override
  void initState() { 
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator().isLocationServiceEnabled()) {
        Navigator.pushReplacement(context, navigateMapFadeIn(context, MapPage()));
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(strokeWidth: 2,),
            );
          }
        },
      ),
    );
  }

  Future checkGpsLocation(BuildContext context) async {

    final permisosGPS = await Permission.location.isGranted;
    final gpsActivo = await Geolocator().isLocationServiceEnabled();

    if (permisosGPS && gpsActivo) {
      Navigator.pushReplacement(context, navigateMapFadeIn(context, MapPage()));
      return '';
    } else if (!permisosGPS) {
      Navigator.pushReplacement(context, navigateMapFadeIn(context, AccessGpsPage()));
      return 'Otorga el permiso del GPS';
    } else {
      return 'Active el GPS';
    }

  }
}