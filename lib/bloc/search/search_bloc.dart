import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:maps_app/models/search_result.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event,) async* {
    if (event is OnActivateManualMarker) {
      yield state.copyWith(manualSelection: true);
    } else if (event is OnDeactivateManualMarker) {
      yield state.copyWith(manualSelection: false);
    } else if (event is OnAddHistorial) {
      final exists = state.historial.where(
        (result) => result.locationName == event.searchResult.locationName
      ).length;

      if (exists == 0) {
        final newHistorial = [...state.historial, event.searchResult];
      yield state.copyWith(historial: newHistorial);
      }
    }
  }
}
