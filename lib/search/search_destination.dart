import 'package:flutter/material.dart';
import 'package:maps_app/models/search_result.dart';

class SearchDestination extends SearchDelegate<SearchResult> {

  @override
  String get searchFieldLabel => 'Search places...';

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
    return Text('results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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

}