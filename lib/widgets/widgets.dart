import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bloc/mapa/mapa_bloc.dart';
import 'package:maps_app/bloc/my_location/my_location_bloc.dart';
import 'package:maps_app/bloc/search/search_bloc.dart';
import 'package:maps_app/helpers/helpers.dart';
import 'package:polyline/polyline.dart' as Poly;

import 'package:maps_app/models/search_result.dart';
import 'package:maps_app/search/search_destination.dart';

import 'package:maps_app/services/traffic_service.dart';

part 'button_center_location.dart';
part 'button_follow_location.dart';
part 'button_route.dart';
part 'manual_marker.dart';
part 'search_bar.dart';