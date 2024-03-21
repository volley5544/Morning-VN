part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class NewMapSearchNearby extends MapEvent {
  final MapSearch mapSearch;
  final BuildContext context;
  final LatLng screenCenter;
  final LatLng deviceCenter;
  final Set<Marker> markers;
  final int selectedIndex;
  final Function setState;
  final MapWidgetController mapWidgetController;
  final CarouselController carouselController;
  const NewMapSearchNearby({
    required this.mapSearch,
    required this.context,
    required this.screenCenter,
    required this.markers,
    required this.selectedIndex,
    required this.setState,
    required this.mapWidgetController,
    required this.deviceCenter,
    required this.carouselController,
  });
}

class SetIsShowNewBrnachList extends MapEvent {
  bool isShowBrnachList;

  SetIsShowNewBrnachList({required this.isShowBrnachList});
}

class OnCurrentCardChange extends MapEvent {
  final MapSearch mapSearch;
  final BuildContext context;
  final LatLng deviceCenter;
  final Set<Marker> markers;
  final int selectedIndex;
  final Function setState;
  final MapWidgetController mapWidgetController;
  final GoogleMapController mapController;
  final CarouselController carouselController;
  OnCurrentCardChange({
    required this.mapSearch,
    required this.context,
    required this.deviceCenter,
    required this.markers,
    required this.selectedIndex,
    required this.setState,
    required this.mapWidgetController,
    required this.mapController,
    required this.carouselController,
  });
}

// searchInput, mapSearchRepo, context, googleMapValueHandler, position
class NewMapSearch extends MapEvent {
  final String query;
  final BuildContext context;
  final MapSearch mapSearchRepo;
  final MapWidgetController mapWidgetController;
  final GoogleMapValueHandler googleMapValueHandler;
  final LatLng deviceCenter;
  final String searchInput;
  final bool isIconSelected;
  final MapSearch mapSearch;
  final Set<Marker> markers;
  final int selectedIndex;
  final Function setState;
  GoogleMapController mapController;
  final CarouselController carouselController;
  NewMapSearch({
    required this.query,
    required this.context,
    required this.mapSearchRepo,
    required this.mapWidgetController,
    required this.searchInput,
    required this.googleMapValueHandler,
    required this.deviceCenter,
    required this.isIconSelected,
    required this.mapSearch,
    required this.markers,
    required this.selectedIndex,
    required this.setState,
    required this.carouselController,
    required this.mapController,
  });
}

class NewMapOnTextChange extends MapEvent {
  final String query;
  final BuildContext context;
  final MapSearch mapSearchRepo;
  final MapWidgetController mapWidgetController;
  final GoogleMapValueHandler googleMapValueHandler;
  final LatLng deviceCenter;
  final String searchInput;
  final bool isIconSelected;
  final MapSearch mapSearch;
  final Set<Marker> markers;
  final int selectedIndex;
  final Function setState;
  NewMapOnTextChange({
    required this.query,
    required this.context,
    required this.mapSearchRepo,
    required this.mapWidgetController,
    required this.searchInput,
    required this.googleMapValueHandler,
    required this.deviceCenter,
    required this.isIconSelected,
    required this.mapSearch,
    required this.markers,
    required this.selectedIndex,
    required this.setState,
  });
}

// NewMapSearch(query, mapSearchRepo, context,
//     googleMapValueHandler, deviceLatLng));

class SetNewMapInit extends MapEvent {
  SetNewMapInit();
}

class SetNewComplete extends MapEvent {
  SetNewComplete();
}

class OnSearchFromExistingBranchList extends MapEvent {
  late List<BranchDetail> branchOptions = <BranchDetail>[];
  final MapSearch mapSearch;
  final BuildContext context;
  final LatLng deviceCenter;
  final Set<Marker> markers;
  final int selectedIndex;
  final Function setState;
  final MapWidgetController mapWidgetController;
  final CarouselController carouselController;
  final GoogleMapController googleMapController;
  OnSearchFromExistingBranchList({
    required this.branchOptions,
    required this.mapSearch,
    required this.context,
    required this.deviceCenter,
    required this.markers,
    required this.selectedIndex,
    required this.setState,
    required this.mapWidgetController,
    required this.carouselController,
    required this.googleMapController,
  });
}
