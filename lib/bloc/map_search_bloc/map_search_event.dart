part of 'map_search_bloc.dart';

abstract class MapSearchEvent extends Equatable {
  const MapSearchEvent();

  @override
  List<Object> get props => [];
}

class MapsearchTextChange extends MapSearchEvent {
  String input;
  MapSearch mapSearch;
  final BuildContext context;
  Position? deviceLocation;
  GoogleMapValueHandler googleMapService;

  MapsearchTextChange(this.input, this.mapSearch, this.context,
      this.googleMapService, this.deviceLocation);
}

class SetCurrentBranch extends MapSearchEvent {
  final BranchDetail branchDetail;
  const SetCurrentBranch(this.branchDetail);
}

class MapSearchNearby extends MapSearchEvent {
  final LatLng latLng;
  final MapSearch mapSearch;
  final BuildContext context;
  final LatLng deviceCenter;
  const MapSearchNearby(
    this.latLng,
    this.mapSearch,
    this.context,
    this.deviceCenter,
  );
}

class MapStoreSearchHistory extends MapSearchEvent {
  final String searchInput;

  const MapStoreSearchHistory(this.searchInput);
}

class MapSetStateInit extends MapSearchEvent {}

class MapFetchFromHistory extends MapSearchEvent {
  String input;
  MapSearch mapSearch;
  final BuildContext context;
  Position? deviceLocation;
  GoogleMapValueHandler googleMapService;
  MapFetchFromHistory(this.input, this.mapSearch, this.context,
      this.googleMapService, this.deviceLocation);
}

class SetShouldShowSuggestionPage extends MapSearchEvent {
  bool isShouldShowSuggestionPage;
  String stateRuntimeType;

  SetShouldShowSuggestionPage(
      {required this.isShouldShowSuggestionPage,
      required this.stateRuntimeType});
}

class SetIsShowBrnachList extends MapSearchEvent {
  bool isShowBrnachList;

  SetIsShowBrnachList({required this.isShowBrnachList});
}
