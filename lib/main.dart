import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/bloc/mapa/mapa_bloc.dart';
import 'package:maps_app/bloc/my_location/my_location_bloc.dart';
import 'package:maps_app/bloc/search/search_bloc.dart';

import 'package:maps_app/pages/access_gps_page.dart';
import 'package:maps_app/pages/loading_page.dart';
import 'package:maps_app/pages/map_page.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MyLocationBloc()),
        BlocProvider(create: (_) => MapaBloc()),
        BlocProvider(create: (_) => SearchBloc()),
      ],
      child: MaterialApp(
        title: 'Map App',
        debugShowCheckedModeBanner: false,
        home: LoadingPage(),
        routes: {
          'map': (_) => MapPage(),
          'loading': (_) => LoadingPage(),
          'access_gps': (_) => AccessGpsPage(),
        },
      ),
    );
  }
}