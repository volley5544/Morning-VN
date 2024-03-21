// import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_application_srisawad/models/branch_detail.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

import '../../modules/mapSearch/index.dart';
import '../../pages/map/google_map_value_handler.dart';
import '../../pages/map/map_controller/map_controller.dart';
import '../../pages/map/map_page.dart';
import '../../pages/map_assets/map_detail.dart';
import '../../util/custom_exception.dart';
import '../../widgets/dialog/server_suspended_dialog.dart';
import '../../widgets/flash/server_suspended.dart';
import '../page_result/page_result_bloc.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc()
      : super(MapInitial(
            prevBranchList: [],
            branchOptions: [],
            historyInputList: [],
            isShowBrnachList: false,
            shouldShowSuggestionPage: false,
            latestSearch: '',
            selectedIndex: 999,
            searchText: '')) {
    on<NewMapSearchNearby>((event, emit) async {
      try {
        emit(MapInitial(
          prevBranchList: [],
          branchOptions: state.branchOptions,
          currentBranch: state.currentBranch,
          historyInputList: state.historyInputList,
          isShowBrnachList: state.isShowBrnachList,
          shouldShowSuggestionPage: state.shouldShowSuggestionPage,
          latestSearch: state.latestSearch,
          selectedIndex: state.selectedIndex,
          searchText: state.searchText,
        ));
        emit(MapSearchLoading(
          prevBranchList: [],
          branchOptions: state.branchOptions,
          currentBranch: state.currentBranch,
          historyInputList: state.historyInputList,
          isShowBrnachList: state.isShowBrnachList,
          shouldShowSuggestionPage: state.shouldShowSuggestionPage,
          latestSearch: state.latestSearch,
          selectedIndex: state.selectedIndex,
          searchText: state.searchText,
        ));
        // await Future.delayed(Duration(seconds: 1));
        setDefaultvalue(state, event);
        late List<BranchDetail> brancgOptionsList;
        brancgOptionsList = await getNearbyBranchList(event);
        state.prevBranchList = brancgOptionsList;
        print(
            'cehck state.prevBranchList in nearby: ${state.prevBranchList.length}');
        state.branchOptions = brancgOptionsList;
        event.mapWidgetController.isShowCard = false;
        event.mapWidgetController.initCard = 999;
        await updateMarker(
            event.markers,
            event.selectedIndex,
            event.context,
            state,
            event.setState,
            event.mapWidgetController,
            event.carouselController);
        emit(MapComplete(
          prevBranchList: state.prevBranchList,
          branchOptions: brancgOptionsList,
          currentBranch: state.currentBranch,
          historyInputList: state.historyInputList,
          isShowBrnachList: state.isShowBrnachList,
          shouldShowSuggestionPage: state.shouldShowSuggestionPage,
          latestSearch: state.latestSearch,
          selectedIndex: state.selectedIndex,
          searchText: state.searchText,
        ));
      } on RESTApiException catch (e) {
        BlocProvider.of<PageResultBloc>(event.context)
            .add(SetButtonNavigator(false));
        emit(MapComplete(
          prevBranchList: state.prevBranchList,
          branchOptions: [],
          currentBranch: state.currentBranch,
          historyInputList: state.historyInputList,
          isShowBrnachList: state.isShowBrnachList,
          shouldShowSuggestionPage: state.shouldShowSuggestionPage,
          latestSearch: state.latestSearch,
          selectedIndex: state.selectedIndex,
          searchText: state.searchText,
        ));

        BlocProvider.of<PageResultBloc>(event.context)
            .add(SetCurrentNavBarIndex(0));
        BlocProvider.of<PageResultBloc>(event.context)
            .add(SetButtonNavigator(true));
        Navigator.pushNamed(event.context, '/home-page');
        serverSuspendedDialog(event.context,
            additionalText: e.cause.toString());
      } catch (e) {
        BlocProvider.of<PageResultBloc>(event.context)
            .add(SetButtonNavigator(false));
        emit(MapComplete(
          prevBranchList: state.prevBranchList,
          branchOptions: [],
          currentBranch: state.currentBranch,
          historyInputList: state.historyInputList,
          isShowBrnachList: state.isShowBrnachList,
          shouldShowSuggestionPage: state.shouldShowSuggestionPage,
          latestSearch: state.latestSearch,
          selectedIndex: state.selectedIndex,
          searchText: state.searchText,
        ));

        BlocProvider.of<PageResultBloc>(event.context)
            .add(SetCurrentNavBarIndex(0));
        BlocProvider.of<PageResultBloc>(event.context)
            .add(SetButtonNavigator(true));
        Navigator.of(event.context).pop();
        Navigator.of(event.context)
            .restorablePush(serverSuspendedDialog(event.context));
      }
    });
    on<SetIsShowNewBrnachList>((event, emit) async {
      emit(MapComplete(
        prevBranchList: state.prevBranchList,
        branchOptions: const [],
        historyInputList: state.historyInputList,
        isShowBrnachList: event.isShowBrnachList,
        shouldShowSuggestionPage: state.shouldShowSuggestionPage,
        latestSearch: state.latestSearch,
        selectedIndex: state.selectedIndex,
        searchText: state.searchText,
      ));
    });
    on<OnCurrentCardChange>((event, emit) async {
      if (event.mapWidgetController.allowSlidingSearch) {
        onCurrentCardChange(
            event.markers,
            event.selectedIndex,
            event.context,
            state,
            event.setState,
            event.mapWidgetController,
            event.mapController,
            event.carouselController);
        emit(MapComplete(
          prevBranchList: state.prevBranchList,
          branchOptions: state.branchOptions,
          historyInputList: state.historyInputList,
          isShowBrnachList: state.isShowBrnachList,
          shouldShowSuggestionPage: state.shouldShowSuggestionPage,
          latestSearch: state.latestSearch,
          selectedIndex: state.selectedIndex,
          searchText: state.searchText,
        ));
      }
      // if (event.selectedIndex == state.selectedIndex ||
      //     state.selectedIndex == 999) {
      //   event.mapWidgetController.allowSlidingSearch = true;
      // }
    });
    on<SetNewMapInit>((event, emit) async {
      emit(MapInitial(
        prevBranchList: state.prevBranchList,
        branchOptions: state.branchOptions,
        historyInputList: state.historyInputList,
        isShowBrnachList: state.isShowBrnachList,
        shouldShowSuggestionPage: state.shouldShowSuggestionPage,
        latestSearch: state.latestSearch,
        selectedIndex: state.selectedIndex,
        searchText: state.searchText,
      ));
    });
    on<SetNewComplete>((event, emit) async {
      print('check state.prevBranchList ${state.prevBranchList.length}');
      emit(MapSearchLoading(
        prevBranchList: state.prevBranchList,
        branchOptions: state.branchOptions,
        currentBranch: state.currentBranch,
        historyInputList: state.historyInputList,
        isShowBrnachList: state.isShowBrnachList,
        shouldShowSuggestionPage: state.shouldShowSuggestionPage,
        latestSearch: state.latestSearch,
        selectedIndex: state.selectedIndex,
        searchText: state.searchText,
      ));
      emit(MapComplete(
        prevBranchList: state.prevBranchList,
        branchOptions: state.prevBranchList,
        historyInputList: state.historyInputList,
        isShowBrnachList: state.isShowBrnachList,
        shouldShowSuggestionPage: state.shouldShowSuggestionPage,
        latestSearch: state.latestSearch,
        selectedIndex: state.selectedIndex,
        searchText: state.searchText,
      ));
    });
    on<OnSearchFromExistingBranchList>((event, emit) async {
      emit(MapSearchLoading(
        prevBranchList: state.prevBranchList,
        branchOptions: state.branchOptions,
        currentBranch: state.currentBranch,
        historyInputList: state.historyInputList,
        isShowBrnachList: state.isShowBrnachList,
        shouldShowSuggestionPage: state.shouldShowSuggestionPage,
        latestSearch: state.latestSearch,
        selectedIndex: state.selectedIndex,
        searchText: state.searchText,
      ));
      state.branchOptions = event.branchOptions;
      state.prevBranchList = event.branchOptions;
      state.selectedIndex = event.selectedIndex;
      event.mapWidgetController.isShowCard = true;
      event.mapWidgetController.initCard = 0;
      state.historyInputList.remove(event.branchOptions[0].branchName);
      state.historyInputList.add(event.branchOptions[0].branchName);
      state.historyInputList = state.historyInputList.toSet().toList();
      await updateMarker(
          event.markers,
          event.selectedIndex,
          event.context,
          state,
          event.setState,
          event.mapWidgetController,
          event.carouselController);
      event.mapWidgetController.deviceLatLng = LatLng(
          parsingDouble(event.branchOptions[0].latitude),
          parsingDouble(event.branchOptions[0].longtitude));
      setCenter(event.mapWidgetController.deviceLatLng, event.setState,
          event.googleMapController);
      emit(MapComplete(
        prevBranchList: state.prevBranchList,
        branchOptions: state.branchOptions,
        currentBranch: state.currentBranch,
        historyInputList: state.historyInputList,
        isShowBrnachList: state.isShowBrnachList,
        shouldShowSuggestionPage: state.shouldShowSuggestionPage,
        latestSearch: state.latestSearch,
        selectedIndex: state.selectedIndex,
        searchText: event.branchOptions[0].branchName,
      ));
    });
    on<NewMapSearch>((event, emit) async {
      // state.historyInputList.add(event.searchInput);
      try {
        emit(MapNoresultFound(
          prevBranchList: state.prevBranchList,
          branchOptions: state.branchOptions,
          historyInputList: state.historyInputList,
          isShowBrnachList: state.isShowBrnachList,
          shouldShowSuggestionPage: state.shouldShowSuggestionPage,
          latestSearch: state.latestSearch,
          selectedIndex: state.selectedIndex,
          searchText: state.searchText,
        ));
        // event.mapWidgetController.isShowCard = false;
        if (event.isIconSelected) {
          emit(MapSearchLoading(
            prevBranchList: state.prevBranchList,
            branchOptions: state.branchOptions,
            currentBranch: state.currentBranch,
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch,
            selectedIndex: state.selectedIndex,
            searchText: event.query,
          ));
          event.mapWidgetController.isShowSuggestionPage = false;
          // event.mapWidgetController.isShowCard = false;
        }
        event.mapWidgetController.isShowCard = false;
        state.historyInputList.remove(event.query);
        state.historyInputList.add(event.query);
        state.historyInputList = state.historyInputList.toSet().toList();
        late List<BranchDetail> brancgOptionsList;
        event.setState();
        brancgOptionsList = await getMapSearchOnsearchSelected(event);
        state.prevBranchList = brancgOptionsList;
        if (brancgOptionsList.isEmpty) {
          emit(MapSearchLoading(
            prevBranchList: state.prevBranchList,
            branchOptions: state.branchOptions,
            currentBranch: state.currentBranch,
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch,
            selectedIndex: state.selectedIndex,
            searchText: state.searchText,
          ));
          event.mapWidgetController.isShowCard = false;
          state.branchOptions = [];
          event.markers.clear();
          state.selectedIndex = 999;
          event.setState();
          flashNoResultFound(
              title: 'ไม่สามารถทำรายการได้ขณะนี้',
              body: 'กรุณาพิมพ์การค้นหาใหม่อีกครั้ง',
              buttonText: 'ปิด',
              context: event.context);
          emit(MapComplete(
            prevBranchList: state.prevBranchList,
            branchOptions: [],
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch,
            selectedIndex: state.selectedIndex,
            searchText: event.query,
          ));
        } else {
          state.branchOptions = brancgOptionsList;
          state.selectedIndex = 0;
          event.mapWidgetController.initCard = 0;
          await updateMarker(
              event.markers,
              0,
              event.context,
              state,
              event.setState,
              event.mapWidgetController,
              event.carouselController);
          event.mapWidgetController.deviceLatLng = LatLng(
              parsingDouble(brancgOptionsList[0].latitude),
              parsingDouble(brancgOptionsList[0].longtitude));
          setCenter(event.mapWidgetController.deviceLatLng, event.setState,
              event.mapController);
          emit(MapComplete(
            prevBranchList: state.prevBranchList,
            branchOptions: brancgOptionsList,
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch,
            selectedIndex: state.selectedIndex,
            searchText: event.query,
          ));
          event.mapWidgetController.isShowCard = true;
          event.setState();
        }
      } on RESTApiException catch (e) {
        serverSuspendedDialog(event.context,
            additionalText: e.cause.toString());
        emit(MapComplete(
          prevBranchList: state.prevBranchList,
          branchOptions: [],
          historyInputList: state.historyInputList,
          isShowBrnachList: state.isShowBrnachList,
          shouldShowSuggestionPage: state.shouldShowSuggestionPage,
          latestSearch: state.latestSearch,
          selectedIndex: state.selectedIndex,
          searchText: event.query,
        ));
      } catch (e) {
        serverSuspendedDialog(event.context);
        emit(MapComplete(
          prevBranchList: state.prevBranchList,
          branchOptions: [],
          historyInputList: state.historyInputList,
          isShowBrnachList: state.isShowBrnachList,
          shouldShowSuggestionPage: state.shouldShowSuggestionPage,
          latestSearch: state.latestSearch,
          selectedIndex: state.selectedIndex,
          searchText: event.query,
        ));
      }
    });
    on<NewMapOnTextChange>((event, emit) async {
      // state.historyInputList.add(event.searchInput);
      try {
        emit(LoadOnTextChange(
          prevBranchList: state.prevBranchList,
          branchOptions: [],
          historyInputList: state.historyInputList,
          isShowBrnachList: state.isShowBrnachList,
          shouldShowSuggestionPage: state.shouldShowSuggestionPage,
          latestSearch: state.latestSearch,
          selectedIndex: state.selectedIndex,
          searchText: state.searchText,
        ));
        if (event.isIconSelected) {
          emit(MapSearchLoading(
            prevBranchList: state.prevBranchList,
            branchOptions: state.branchOptions,
            currentBranch: state.currentBranch,
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch,
            selectedIndex: state.selectedIndex,
            searchText: state.searchText,
          ));
          event.mapWidgetController.isShowSuggestionPage = false;
          print('change textes');
          event.mapWidgetController.isShowCard = true;
        }
        late List<BranchDetail> brancgOptionsList;
        brancgOptionsList = await getMapSearchOnTextChach(event);
        // await updateMarker(event.markers, event.selectedIndex, event.context,
        //     state, event.setState, event.mapWidgetController);
        if (brancgOptionsList.isEmpty) {
          // print('check prevListOptions: ${prevListOptions.length}');
          // state.branchOptions = prevListOptions;
          // print('check state.branchOptions: ${state.branchOptions.length}');
          emit(MapNoresultFound(
            prevBranchList: state.prevBranchList,
            branchOptions: state.prevBranchList,
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch,
            selectedIndex: state.selectedIndex,
            searchText: state.searchText,
          ));
        } else {
          emit(MapComplete(
            prevBranchList: state.prevBranchList,
            branchOptions: brancgOptionsList,
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch,
            selectedIndex: state.selectedIndex,
            searchText: state.searchText,
          ));
        }
      } on RESTApiException catch (e) {
        serverSuspendedDialog(event.context,
            additionalText: e.cause.toString());
        emit(MapComplete(
          prevBranchList: state.prevBranchList,
          branchOptions: [],
          historyInputList: state.historyInputList,
          isShowBrnachList: state.isShowBrnachList,
          shouldShowSuggestionPage: state.shouldShowSuggestionPage,
          latestSearch: state.latestSearch,
          selectedIndex: state.selectedIndex,
          searchText: event.query,
        ));
      } catch (e) {
        serverSuspendedDialog(event.context);
        emit(MapComplete(
          prevBranchList: state.prevBranchList,
          branchOptions: [],
          historyInputList: state.historyInputList,
          isShowBrnachList: state.isShowBrnachList,
          shouldShowSuggestionPage: state.shouldShowSuggestionPage,
          latestSearch: state.latestSearch,
          selectedIndex: state.selectedIndex,
          searchText: event.query,
        ));
      }
    });
  }
}

Future<List<BranchDetail>> getNearbyBranchList(NewMapSearchNearby event) async {
  GoogleMapValueHandler googleMapService = GoogleMapValueHandler();
  var list = await event.mapSearch.searchNearby(
      event.deviceCenter.latitude.toString(),
      event.deviceCenter.longitude.toString());
  await calculateDistanceAndSort(list, googleMapService,
      event.screenCenter.latitude, event.screenCenter.longitude);
  return list;
}

Future<void> calculateDistanceAndSort(
    List<BranchDetail> list,
    GoogleMapValueHandler googleMapService,
    double? latitude,
    double? longitude) async {
  if (list != null &&
      list.isNotEmpty &&
      latitude != null &&
      longitude != null) {
    await Future.forEach<BranchDetail>(list, (branch) async {
      if (double.tryParse(branch.latitude) != null &&
          double.tryParse(branch.longtitude) != null) {
        branch.distance = googleMapService.haversineDistance(
            double.tryParse(branch.latitude) ?? 0,
            double.tryParse(branch.longtitude) ?? 0,
            latitude,
            longitude);
      } else {
        logger.i('branch name ${branch.branchName}');
        logger.i('lat is : ${branch.latitude} lng is : ${branch.longtitude}');
      }
    });
  }
  list.sort((a, b) {
    return a.distance!.compareTo(b.distance!);
  });
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

Future<void> updateMarker(
  Set<Marker> markers,
  int selectedIndex,
  BuildContext context,
  MapState state,
  Function setState,
  MapWidgetController mapWidgetController,
  CarouselController carouselController,
) async {
  markers.clear();
  for (int i = 0; i < state.branchOptions.length; i++) {
    await addMarker(
        state.branchOptions[i],
        i,
        markers,
        context,
        mapWidgetController.commonIcon,
        mapWidgetController.selectedIcon,
        state,
        setState,
        mapWidgetController,
        carouselController);
  }
  setState();
}

Future<void> addMarker(
    BranchDetail branch,
    int index,
    Set<Marker> markers,
    BuildContext context,
    Uint8List markerIcon,
    Uint8List selectedMarker,
    MapState state,
    Function setState,
    MapWidgetController mapWidgetController,
    CarouselController carouselController) async {
  markers.add(Marker(
    markerId: MarkerId('marker $index'),
    icon: BitmapDescriptor.fromBytes(state.selectedIndex == 999
        ? markerIcon
        : state.selectedIndex == index
            ? selectedMarker
            : markerIcon),
    onTap: () => setMainBranchList(
        index,
        context,
        state,
        markers,
        state.selectedIndex,
        setState,
        mapWidgetController,
        false,
        carouselController),
    position: LatLng(
        parsingDouble(branch.latitude), parsingDouble(branch.longtitude)),
  ));
}

void updateMarkerFromIdex(
    {required Set<Marker> markers,
    required int index,
    required LatLng newPosition,
    required Uint8List icon,
    required MapState state,
    required BuildContext context,
    required Function setState,
    required MapWidgetController mapWidgetController,
    required CarouselController carouselController}) {
  var marker = markers.firstWhere((m) => m.markerId.value == 'marker $index');
  markers.remove(marker);
  markers.add(Marker(
    markerId: marker.markerId,
    position: newPosition,
    icon: BitmapDescriptor.fromBytes(icon),
    onTap: () => setMainBranchList(
        index,
        context,
        state,
        markers,
        state.selectedIndex,
        setState,
        mapWidgetController,
        false,
        carouselController),
  ));
}

// พระ บาง น้ำ
Future<void> setMainBranchList(
    int index,
    BuildContext context,
    MapState state,
    Set<Marker> markers,
    int selectedIndex,
    Function setState,
    MapWidgetController mapWidgetController,
    bool allowOnCallSlidingCard,
    CarouselController carouselController) async {
  int initSelected = mapWidgetController.initCard;
  mapWidgetController.isShowCard = true;
  mapWidgetController.allowSlidingSearch = true;
  // mapWidgetController.initCard = index;

// update here

  LatLng branchPosition = LatLng(
      parsingDouble(state.branchOptions[index].latitude),
      parsingDouble(state.branchOptions[index].longtitude));
  updateMarkerFromIdex(
      icon: mapWidgetController.selectedIcon,
      index: index,
      markers: markers,
      newPosition: branchPosition,
      context: context,
      mapWidgetController: mapWidgetController,
      setState: setState,
      state: state,
      carouselController: carouselController);
  if (mapWidgetController.initCard != 999 &&
      mapWidgetController.initCard != index) {
    LatLng prevBranchPosition = LatLng(
        parsingDouble(
            state.branchOptions[mapWidgetController.initCard].latitude),
        parsingDouble(
            state.branchOptions[mapWidgetController.initCard].longtitude));
    updateMarkerFromIdex(
        index: mapWidgetController.initCard,
        markers: markers,
        newPosition: prevBranchPosition,
        icon: mapWidgetController.commonIcon,
        context: context,
        mapWidgetController: mapWidgetController,
        setState: setState,
        state: state,
        carouselController: carouselController);
  }
  // await updateMarker(
  //     markers, index, context, state, setState, mapWidgetController);
  mapWidgetController.allowSlidingSearch = false;
  if (initSelected != 999) {
    await carouselController
        .animateToPage(index)
        .then((value) => mapWidgetController.allowSlidingSearch = true);
  } else {
    mapWidgetController.allowSlidingSearch = true;
  }
  mapWidgetController.initCard = index;
  state.selectedIndex = index;
  setState();
}

void onCurrentCardChange(
    Set<Marker> markers,
    int selectedIndex,
    BuildContext context,
    MapState state,
    Function setState,
    MapWidgetController mapWidgetController,
    GoogleMapController mapController,
    CarouselController carouselController) {
  // mapWidgetController.initCard
  // markers.clear();
  LatLng branchPosition = LatLng(
      parsingDouble(state.branchOptions[selectedIndex].latitude),
      parsingDouble(state.branchOptions[selectedIndex].longtitude));

  updateMarkerFromIdex(
      index: selectedIndex,
      markers: markers,
      newPosition: branchPosition,
      icon: mapWidgetController.selectedIcon,
      context: context,
      mapWidgetController: mapWidgetController,
      setState: setState,
      state: state,
      carouselController: carouselController);
  if (mapWidgetController.initCard != 999) {
    LatLng prevBranchPosition = LatLng(
        parsingDouble(
            state.branchOptions[mapWidgetController.initCard].latitude),
        parsingDouble(
            state.branchOptions[mapWidgetController.initCard].longtitude));
    updateMarkerFromIdex(
        index: mapWidgetController.initCard,
        markers: markers,
        newPosition: prevBranchPosition,
        icon: mapWidgetController.commonIcon,
        context: context,
        mapWidgetController: mapWidgetController,
        setState: setState,
        state: state,
        carouselController: carouselController);
  }

  // updateMarker(
  //     markers, selectedIndex, context, state, setState, mapWidgetController);
  setCenter(
      LatLng(parsingDouble(state.branchOptions[selectedIndex].latitude),
          parsingDouble(state.branchOptions[selectedIndex].longtitude)),
      setState,
      mapController);
  setState();
  mapWidgetController.initCard = selectedIndex;
}

void setCenter(LatLng currentLatLng, Function setState,
    GoogleMapController mapController) {
  // final GoogleMapController controller = await mapController.future;

  mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: currentLatLng, zoom: 12)));
}

Future<List<BranchDetail>> getMapSearchOnsearchSelected(
    NewMapSearch event) async {
  var list = await event.mapSearchRepo.searchBranch(event.searchInput);
  await calculateDistanceAndSort(list, event.googleMapValueHandler,
      event.deviceCenter.latitude, event.deviceCenter.longitude);
  return list;
}

Future<List<BranchDetail>> getMapSearchOnTextChach(
    NewMapOnTextChange event) async {
  var list = await event.mapSearchRepo.searchBranch(event.searchInput);
  await calculateDistanceAndSort(list, event.googleMapValueHandler,
      event.deviceCenter.latitude, event.deviceCenter.longitude);
  return list;
}

void setDefaultvalue(MapState state, NewMapSearchNearby event) {
  state.searchText = '';
  state.selectedIndex = 999;
  event.mapWidgetController.deviceLatLng = event.deviceCenter;
}
