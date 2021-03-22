import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AccessGpsPage extends StatefulWidget {

  @override
  _AccessGpsPageState createState() => _AccessGpsPageState();
}

class _AccessGpsPageState extends State<AccessGpsPage> with WidgetsBindingObserver {

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
      if (await Permission.location.isGranted) {
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Es necesario el GPS para usar esta app'),

            MaterialButton(
              child: Text('Solicitar Acceso', style: TextStyle(color: Colors.white),),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () async {
                final status = await Permission.location.request();
                print(status);
                this.accessGps(status);
              },
            )
          ],
        ),
      ),
    );
  }

  void accessGps(PermissionStatus status) {

    switch (status) {
      case PermissionStatus.granted:
      case PermissionStatus.limited:
        Navigator.pushReplacementNamed(context, 'map');
        break;
      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }

  }
}