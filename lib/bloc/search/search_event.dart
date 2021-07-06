part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OnActivateManualMarker extends SearchEvent {}

class OnDeactivateManualMarker extends SearchEvent {}