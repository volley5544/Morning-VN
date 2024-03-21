import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/models/branch_detail.dart';
import 'package:mobile_application_srisawad/modules/mapSearch/index.dart';
import 'package:mobile_application_srisawad/pages/map/old_map_page.dart';
import 'package:mobile_application_srisawad/services/localStorage/local_storage.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'package:mobile_application_srisawad/widgets/dialog/no_result_found.dart';
import 'package:mobile_application_srisawad/widgets/dialog/server_error_1_dialog.dart';
import 'package:mobile_application_srisawad/widgets/dialog/server_suspended_dialog.dart';

import '../../main.dart';
import '../../pages/map/google_map_value_handler.dart';
import '../../widgets/flash/_dialog_flash.dart';
import '../../widgets/flash/server_suspended.dart';

part 'map_search_event.dart';

part 'map_search_state.dart';

class MapSearchBloc extends Bloc<MapSearchEvent, MapSearchState> {
  MapSearchBloc()
      : super(MapSearchInitial(
            branchOptions: [],
            historyInputList: [],
            isShowBrnachList: false,
            shouldShowSuggestionPage: false,
            latestSearch: '')) {
    on<MapsearchTextChange>(((event, emit) async {
      try {
        emit(MapSearchLoading(
            branchOptions: const [],
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch));
        List<BranchDetail> brancgOptionsList;
        brancgOptionsList = await getMapSearchBranchList(event);
        if (state is MapInfoBoxComplete != true) {
          emit(MapSearchComplete(
              branchOptions: brancgOptionsList,
              historyInputList: state.historyInputList,
              isShowBrnachList: state.isShowBrnachList,
              shouldShowSuggestionPage: state.shouldShowSuggestionPage,
              latestSearch: event.input));
        }

        if (event.input == '') {
          emit(MapSearchInitial(
              branchOptions: const [],
              historyInputList: state.historyInputList,
              isShowBrnachList: state.isShowBrnachList,
              shouldShowSuggestionPage: state.shouldShowSuggestionPage,
              latestSearch: event.input));
        }
      } catch (e) {
        emit(MapSearchError(
            branchOptions: const [],
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch));
      }
    }));
    on<SetCurrentBranch>((event, emit) async {
      try {
        emit(MapInfoBoxInitial(
            branchOptions: state.branchOptions,
            currentBranch: state.currentBranch,
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch));
        emit(MapInfoBoxLoading(
            branchOptions: state.branchOptions,
            currentBranch: state.currentBranch,
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch));
        emit(MapInfoBoxComplete(
            branchOptions: state.branchOptions,
            currentBranch: event.branchDetail,
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch));
      } catch (e) {
        emit(MapInfoBoxError(
            branchOptions: state.branchOptions,
            currentBranch: state.currentBranch,
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch));
      }
    });
    on<MapSearchNearby>((event, emit) async {
      try {
        emit(MapSearchNearbyInitial(
            branchOptions: state.branchOptions,
            currentBranch: state.currentBranch,
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch));
        emit(MapSearchNearbyLoading(
            branchOptions: state.branchOptions,
            currentBranch: state.currentBranch,
            historyInputList: state.historyInputList,
            isShowBrnachList: false,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch));
        late List<BranchDetail> brancgOptionsList;
        brancgOptionsList = await getNearbyBranchList(event);
        emit(MapSearchNearbyComplete(
            branchOptions: brancgOptionsList,
            currentBranch: state.currentBranch,
            historyInputList: state.historyInputList,
            isShowBrnachList: false,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch));
        BlocProvider.of<PageResultBloc>(event.context)
            .add(SetButtonNavigator(true));
        BlocProvider.of<PageResultBloc>(event.context)
            .add(SetCurrentNavBarIndex(1));
        await Navigator.popAndPushNamed(event.context, '/map-page',
            arguments: MapPageModel(
              branchList: brancgOptionsList,
              userInput: '',
              isShowBranchListWhenInit: false,
              deviceCenter: event.deviceCenter,
            ));
      } catch (e) {
        Navigator.of(event.context)
            .restorablePush(serverSuspendedDialog(event.context));
        emit(MapSearchNearbyError(
            branchOptions: state.branchOptions,
            currentBranch: state.currentBranch,
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch));
      }
    });
    on<MapStoreSearchHistory>((event, emit) async {
      state.historyInputList.add(event.searchInput);
      emit(MapSetSearchHistory(
          branchOptions: state.branchOptions,
          historyInputList: state.historyInputList,
          isShowBrnachList: false,
          shouldShowSuggestionPage: true,
          latestSearch: state.latestSearch));
    });
    on<MapSetStateInit>((event, emit) async {
      emit(MapSearchInitial(
          branchOptions: const [],
          historyInputList: state.historyInputList,
          isShowBrnachList: state.isShowBrnachList,
          shouldShowSuggestionPage: state.shouldShowSuggestionPage,
          latestSearch: state.latestSearch));
    });
    on<SetShouldShowSuggestionPage>((event, emit) async {
      if (event.stateRuntimeType == 'init') {
        emit(MapSearchInitial(
            branchOptions: const [],
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: event.isShouldShowSuggestionPage,
            latestSearch: state.latestSearch));
      } else {
        emit(MapSearchNearbyComplete(
            branchOptions: const [],
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: event.isShouldShowSuggestionPage,
            latestSearch: state.latestSearch));
      }
    });
    on<SetIsShowBrnachList>((event, emit) async {
      emit(MapSearchNearbyComplete(
          branchOptions: const [],
          historyInputList: state.historyInputList,
          isShowBrnachList: event.isShowBrnachList,
          shouldShowSuggestionPage: state.shouldShowSuggestionPage,
          latestSearch: state.latestSearch));
    });
    on<MapFetchFromHistory>((event, emit) async {
      try {
        var localStorageObject = LocalStoragePrefernces();
        // state.historyInputList.add(event.input);
        emit(MapSearchNearbyLoading(
            branchOptions: const [],
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch));
        late List<BranchDetail> brancgOptionsList;
        brancgOptionsList = await getMapSearchHistoryBranchList(event);
        if (brancgOptionsList.isEmpty) {
          emit(MapSearchInitial(
              branchOptions: [],
              historyInputList: state.historyInputList,
              isShowBrnachList: state.isShowBrnachList,
              shouldShowSuggestionPage: state.shouldShowSuggestionPage,
              latestSearch: event.input));
          // dynamic userLocation = await localStorageObject.getLocalStorage(
          //     'userLocation', 'string');
          // Map<String, dynamic> maper = jsonDecode(
          //   userLocation.toString(),
          // );
          emit(MapSearchComplete(
              branchOptions: [],
              historyInputList: state.historyInputList,
              isShowBrnachList: true,
              shouldShowSuggestionPage: false,
              latestSearch: event.input));
          Navigator.push(
              event.context,
              new MaterialPageRoute(
                  builder: (context) => new MapPage(
                      mapPageModel: MapPageModel(
                          branchList: [],
                          userInput: '',
                          isShowBranchListWhenInit: false))));
          flashNoResultFound(
              title: 'ไม่สามารถทำรายการได้ขณะนี้',
              body: 'กรุณาพิมพ์การค้นหาใหม่อีกครั้ง',
              buttonText: 'ปิด',
              context: event.context);
          // Navigator.of(event.context)
          //     .restorablePush(noResultFound(event.context));
        } else {
          emit(MapSearchComplete(
              branchOptions: brancgOptionsList,
              historyInputList: state.historyInputList,
              isShowBrnachList: true,
              shouldShowSuggestionPage: false,
              latestSearch: event.input));
          Navigator.push(
              event.context,
              new MaterialPageRoute(
                  builder: (context) => new MapPage(
                      mapPageModel: MapPageModel(
                          branchList: brancgOptionsList,
                          userInput: event.input,
                          isShowBranchListWhenInit: true))));
        }
      } catch (e) {
        Navigator.of(event.context)
            .restorablePush(serverSuspendedDialog(event.context));
        emit(MapSearchNearbyError(
            branchOptions: state.branchOptions,
            currentBranch: state.currentBranch,
            historyInputList: state.historyInputList,
            isShowBrnachList: state.isShowBrnachList,
            shouldShowSuggestionPage: state.shouldShowSuggestionPage,
            latestSearch: state.latestSearch));
      }
    });
  }

  Future<List<BranchDetail>> getMapSearchHistoryBranchList(
      MapFetchFromHistory event) async {
    var list = await event.mapSearch.searchBranch(event.input);
    await calculateDistanceAndSort(list, event.googleMapService,
        event.deviceLocation?.latitude, event.deviceLocation?.longitude);
    return list;
  }

  Future<List<BranchDetail>> getMapSearchBranchList(
      MapsearchTextChange event) async {
    var list = await event.mapSearch.searchBranch(event.input);
    try {
      await calculateDistanceAndSort(list, event.googleMapService,
          event.deviceLocation?.latitude, event.deviceLocation?.longitude);
      return list;
    } catch (e) {
      logger.e('Lat Lng has a null value or #N/A value $e');
      return [];
    }
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

  Future<List<BranchDetail>> getNearbyBranchList(MapSearchNearby event) async {
    GoogleMapValueHandler googleMapService = GoogleMapValueHandler();
    var list = await event.mapSearch.searchNearby(
        event.latLng.latitude.toString(), event.latLng.longitude.toString());
    await calculateDistanceAndSort(list, googleMapService,
        event.deviceCenter.latitude, event.deviceCenter.longitude);
    return list;
  }
}
