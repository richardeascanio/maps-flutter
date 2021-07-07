import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:maps_app/models/search_response.dart';
import 'package:maps_app/models/search_result.dart';
import 'package:maps_app/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResult> {

  @override
  String get searchFieldLabel => 'Search places...';

  final LatLng proximity;
  final TrafficService _service;

  SearchDestination(this.proximity)
    : this._service = TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {

    return [
      IconButton(
        onPressed: () => this.query = '', 
        icon: Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {

    final searchResult = SearchResult(cancelled: true);

    return IconButton(
      onPressed: () => this.close(context, searchResult), 
      icon: Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return this._buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length == 0) {
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('set location manually'),
            onTap: () {
              
              this.close(context, SearchResult(cancelled: false, manual: true));
            },
          )
        ],
      );
    }
    return this._buildSearchResults();
    
  }

  Widget _buildSearchResults() {
    if (this.query.length == 0) {
      return Container();
    }

    this._service.getSuggestionsByQuery(this.query.trim(), this.proximity);

    return StreamBuilder(
      stream: this._service.suggestionsStream,
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        print('snapshot $snapshot');
        if (snapshot.hasData) {
          final results = snapshot.data.features;
          if (results != null && results.length != 0) {
            return ListView.separated(
              itemCount: results.length,
              separatorBuilder: (_, i) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                final currentResult = results[index];
                return ListTile(
                  leading: Icon(Icons.place),
                  title: Text(currentResult.placeNameEs),
                  subtitle: Text(currentResult.textEs),
                );
              },
            );
          }
          return Center(
            child: Text('No results'),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          ); 
        }
      },
    );
  }

}