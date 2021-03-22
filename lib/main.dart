import 'package:flutter/material.dart';
import 'package:maps_app/pages/access_gps_page.dart';
import 'package:maps_app/pages/loading_page.dart';
import 'package:maps_app/pages/map_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
      routes: {
        'map': (_) => MapPage(),
        'loading': (_) => LoadingPage(),
        'access_gps': (_) => AccessGpsPage(),
      },
    );
  }
}