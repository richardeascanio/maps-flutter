part of 'widgets.dart';

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.manualSelection 
        ? Container()
        : FadeInDown(
          duration: Duration(milliseconds: 300),
          child: _BuildSearchBar()
        );
      },
    );
  }
}

class _BuildSearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        width: size.width,
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
              context: context, 
              delegate: SearchDestination()
            );
            this.returnSearch(context, result);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 13.0),
            width: double.infinity,
            child: Text(
              'Where do you want to go?',
              style: TextStyle(
                color: Colors.black87,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 5)
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  void returnSearch(BuildContext context, SearchResult result) {

    print('cancelled: ${result.cancelled}');
    print('manual: ${result.manual}');

    if (result.cancelled) return;

    if (result.manual) {
      final searchBloc = BlocProvider.of<SearchBloc>(context);
      searchBloc.add(OnActivateManualMarker());
    }
  }
}