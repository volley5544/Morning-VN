import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_application_srisawad/bloc/map_search_bloc/map_search_bloc.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/branch_detail.dart';
import 'package:mobile_application_srisawad/pages/map/google_map_value_handler.dart';
import 'package:mobile_application_srisawad/pages/map/serach_page.dart';
import 'package:mobile_application_srisawad/pages/map/old_suggestion_page.dart';
import 'package:mobile_application_srisawad/pages/map_assets/map_detail.dart';
import 'package:mobile_application_srisawad/pages/map/info_window.dart' as info;
import 'package:mobile_application_srisawad/bloc/map_search_bloc/map_search_bloc.dart'
    as mapSearch;
import 'package:mobile_application_srisawad/modules/mapSearch/index.dart'
    as mapRepo;
import 'package:mobile_application_srisawad/services/localStorage/pin_local_storage.dart';
import 'package:mobile_application_srisawad/widgets/no_internet_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/map_bloc/map_bloc.dart';
import '../../services/localStorage/local_storage.dart';
import '../../util/logger_service.dart';
import '../../widgets/text_compent.dart';

class MapPageModel {
  List<BranchDetail>? branchList;
  final bool? isShowBranchListWhenInit;
  final String? userInput;
  final LatLng? deviceCenter;

  MapPageModel(
      {this.userInput,
      this.branchList,
      this.isShowBranchListWhenInit,
      this.deviceCenter});
}

class MapPage extends StatefulWidget {
  MapPageModel? mapPageModel;
  final List<MapPageModel>? mapPageModelList;
  final BuildContext? context;

  MapPage({this.context, this.mapPageModel, this.mapPageModelList});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  TextEditingController searchController = TextEditingController();

  late String searchContent = '';
  late bool isSelcted = false;
  Set<Marker> markers = Set();

  // late bool shouldShowSuggestionPage = false;
  late bool setSuggestText = true;
  late Uint8List markerIcon;
  late Uint8List selectedMarker;
  late Uint8List currentUserIcon;
  late int selectedIndex = 999;
  bool isMapSearchModel = false;
  LatLng? latLng;
  late LatLng deviceLatLng = const LatLng(13.7563, 100.5018);
  final GoogleMapValueHandler googleMapValueHandler = GoogleMapValueHandler();
  late List<BranchDetail>? mainBranchList = [];
  final CarouselController carouselController = CarouselController();
  late bool isShowBranchListWhenInit = false;
  Position? position;
  late bool isPosition = false;
  late bool isCenterSet = false;
  late TextEditingController fieldSearchText = TextEditingController();
  late FocusNode myFocusNode = FocusNode();
  var isAskPermission = false;
  mapRepo.MapSearch mapSearchRepo = mapRepo.MapSearch();
  bool? hasConnection = null;
  late GoogleMapController mapController;

  Future<void> checkLocationPermission() async {
    if (await InternetConnectionChecker().hasConnection) {
      setState(() {
        hasConnection = true;
      });
      await googleMapValueHandler.isLocationAvailable().then((isAvailable) {
        if (isAvailable) {
          if (widget.mapPageModel == null) {
            getUserLocation();
          } else {
            initInstance();
          }
        }
      }, onError: (e) {
        if (isAskPermission) {
          navigateToHomeTab();
        } else {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => WillPopScope(
                    onWillPop: () async {
                      return false;
                    },
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      contentPadding: EdgeInsets.only(
                          top: 22, right: 12, left: 12, bottom: 12),
                      content: Container(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextTitle(
                                  "อนุญาตให้ “ศรีสวัสดิ์” ใช้ตำแหน่งที่ตั้ง\nของคุณหรือไม่",
                                  TextAlign.center)
                              .styleSecondary(),
                          SizedBox(
                            height: 9,
                          ),
                          Body('กรุณากดปุ่ม “อนุญาต” เพื่อให้คุณสามารถเข้าใช้งาน\nหน้า ค้นหาสาขา ได้ หากคุณปฏิเสธระบบจะไม่อนุญาต\nให้คุณเข้าถึงหน้า ค้นหาสาขา',
                                  TextAlign.center)
                              .styleLightGrey(),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    navigateToHomeTab();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: HexColor('#FCEFE4'),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 18),
                                      child: Center(
                                        child: Text(
                                          'ปฏิเสธ',
                                          style: GoogleFonts.notoSansThai(
                                              color: HexColor('#DB771A'),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    getUserLocation();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    decoration: BoxDecoration(
                                        color: HexColor('#DB771A'),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                      child: Text(
                                        'อนุญาต',
                                        style: GoogleFonts.notoSansThai(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                    ),
                  ));
        }
      });
    } else {
      setState(() {
        hasConnection = false;
      });
    }
  }

  @override
  void initState() {
    if (mounted) {
      checkLocationPermission();
    }
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  Future<void> getDeviceCenter() async {
    dynamic userLocation =
        await localStorageObject.getLocalStorage('userLocation', 'string');
    Map<String, dynamic> maper = jsonDecode(
      userLocation.toString(),
    );
    setStateWrapper(() {
      latLng = LatLng(parsingDouble(maper['lat']), parsingDouble(maper['lng']));
      deviceLatLng =
          LatLng(parsingDouble(maper['lat']), parsingDouble(maper['lng']));
    });
  }

  void getDevicePosition(bool isbranchFound) async {
    Position pos = await googleMapValueHandler.determinePosition();
    setStateWrapper(() {
      position = pos;
      isPosition = true;
    });
    if (!isbranchFound && mounted) {
      setCenter(LatLng(pos.latitude, pos.longitude));
    }
  }

  void setMainBranchList(int index) {
    context
        .read<mapSearch.MapSearchBloc>()
        .add(mapSearch.SetIsShowBrnachList(isShowBrnachList: true));
    selectedIndex = index;
    _clearMarker();
    updateMarker(widget.mapPageModel!.branchList!);
    setStateWrapper(() {
      isShowBranchListWhenInit = true;
    });

    carouselController.animateToPage(index);
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

  Future<void> _setShowSuggestionPage(bool isShow, String stateType) async {
    // context.read<mapSearch.MapSearchBloc>().add(mapSearch.MapSetStateInit());
    context.read<mapSearch.MapSearchBloc>().add(
        mapSearch.SetShouldShowSuggestionPage(
            isShouldShowSuggestionPage: isShow, stateRuntimeType: stateType));
    myFocusNode.requestFocus();
  }

  void _clearMarker() {
    markers.clear();
  }

  Future<void> updateMarker(List<BranchDetail> branchList) async {
    _clearMarker();
    markerIcon = await getBytesFromAsset('assets/OriginnalCommonPin.png', 300);
    selectedMarker =
        await getBytesFromAsset('assets/OriginalSelectedPin.png', 300);
    for (int i = 0; i < branchList.length; i++) {
      await addMarker(branchList[i], i);
    }
  }

  Future<void> addMarker(BranchDetail? branch, int index) async {
    markers.add(Marker(
      markerId: MarkerId('marker $index'),
      icon: BitmapDescriptor.fromBytes(selectedIndex == 999
          ? markerIcon
          : selectedIndex == index
              ? selectedMarker
              : markerIcon),
      onTap: () => setMainBranchList(index),
      position: LatLng(
          parsingDouble(branch!.latitude), parsingDouble(branch.longtitude)),
    ));
  }

  void setCenter(LatLng currentLatLng) {
    if (isShowBranchListWhenInit) {
      setStateWrapper(() {
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: currentLatLng, zoom: 12)));
        isCenterSet = true;
        latLng = currentLatLng;
      });
    } else {
      setStateWrapper(() {
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: currentLatLng, zoom: 12)));
        isCenterSet = true;
        latLng = widget.mapPageModel!.deviceCenter!;
      });
    }
  }

  Future<void> updateCameraLocation(
    LatLng source,
    LatLng destination,
    GoogleMapController mapController,
  ) async {
    if (mapController == null) return;

    LatLngBounds bounds;

    if (source.latitude > destination.latitude &&
        source.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: source);
    } else if (source.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(source.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, source.longitude));
    } else if (source.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, source.longitude),
          northeast: LatLng(source.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: source, northeast: destination);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 70);

    return checkCameraLocation(cameraUpdate, mapController);
  }

  Future<void> checkCameraLocation(
      CameraUpdate cameraUpdate, GoogleMapController mapController) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }

  void onRecenterIconTaped(int selectedCradIndex) {
    final branchLat = parsingDouble(
        widget.mapPageModel!.branchList![selectedCradIndex].latitude);
    final branchLng = parsingDouble(
        widget.mapPageModel!.branchList![selectedCradIndex].longtitude);
    updateCameraLocation(
        LatLng(position?.latitude ?? 0, position?.longitude ?? 0),
        LatLng(branchLat, branchLng),
        mapController);
  }

  void setSelectedSuggestion(List<BranchDetail> branchDetailList) {
    // shouldShowSuggestionPage = false;
    context.read<mapSearch.MapSearchBloc>().add(
        mapSearch.SetShouldShowSuggestionPage(
            isShouldShowSuggestionPage: false, stateRuntimeType: 'complete'));
    context
        .read<mapSearch.MapSearchBloc>()
        .add(mapSearch.SetIsShowBrnachList(isShowBrnachList: true));
    // isShowBrnachList = true;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MapPage(
                mapPageModel: MapPageModel(
                    branchList: branchDetailList,
                    userInput: branchDetailList[0].branchName,
                    isShowBranchListWhenInit: true,
                    deviceCenter: deviceLatLng))));
  }

  void onSearchIconSelected(String searchInput, MapSearchState mapState) {
    FirebaseAnalytics.instance.logEvent(
      name: 'branch_search',
      parameters: {'keyword': ''},
    );
    final mapRepo.MapSearch mapSearchRepo = mapRepo.MapSearch();
    context
        .read<mapSearch.MapSearchBloc>()
        .add(mapSearch.MapStoreSearchHistory(searchInput));
    context.read<mapSearch.MapSearchBloc>().add(mapSearch.MapFetchFromHistory(
        searchInput, mapSearchRepo, context, googleMapValueHandler, position));
  }

  void onSearchFromHistory(String userInput, mapRepo.MapSearch mapSearchRepo) {
    FirebaseAnalytics.instance.logEvent(
      name: 'branch_history_search',
      parameters: {
        'keyword': userInput,
      },
    );
    // shouldShowSuggestionPage = false;
    // isShowBrnachList = true;
    context.read<mapSearch.MapSearchBloc>().add(mapSearch.MapFetchFromHistory(
        userInput, mapSearchRepo, context, googleMapValueHandler, position));
  }

  void onSearchNearbyCall() {
    try {
      FirebaseAnalytics.instance.logEvent(
        name: 'branch_nearby_search',
        parameters: {
          'user_lat': '',
          'user_long': '',
        },
      );
      // shouldShowSuggestionPage = false;
      final mapRepo.MapSearch mapSearchRepo = mapRepo.MapSearch();
      context.read<mapSearch.MapSearchBloc>().add(mapSearch.MapSearchNearby(
          LatLng(position?.latitude ?? 0, position?.longitude ?? 0),
          mapSearchRepo,
          context,
          deviceLatLng));
    } catch (e) {
      logger.e('Error occur in map search nearby $e');
    }
  }

  void onCurrentCardChange(int index) {
    selectedIndex = index;
    _clearMarker();
    updateMarker(widget.mapPageModel!.branchList!);
    setCenter(LatLng(
        parsingDouble(widget.mapPageModel!.branchList![index].latitude),
        parsingDouble(widget.mapPageModel!.branchList![index].longtitude)));
  }

  Future<void> launchCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> launchMap(double latitude, double longitude) async {
    final Uri googleUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }

  void clearText() {
    context.read<mapSearch.MapSearchBloc>().add(mapSearch.MapSetStateInit());
    fieldSearchText.text = '';
    // widget.onSearchNearbyCall();
  }

  double parsingDouble(String value) {
    try {
      return double.parse(value);
    } catch (e) {
      return 0.0;
    }
  }

  void setStateWrapper(Function callBack) {
    if (mounted) {
      callBack();
    }
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return hasConnection != null
        ? hasConnection!
            ? Scaffold(
                resizeToAvoidBottomInset: false,
                body: BlocBuilder<mapSearch.MapSearchBloc,
                    mapSearch.MapSearchState>(builder: (mapContext, mapState) {
                  if (setSuggestText) {
                    fieldSearchText.text = mapState.latestSearch;
                    setSuggestText = false;
                  }
                  return Stack(
                    children: [
                      MapDetail(
                        markers: markers,
                        latLng: latLng,
                        onMapCreate: onMapCreated,
                      ),
                      if (mapState is mapSearch.MapSearchNearbyLoading)
                        const Center(
                            child: CircularProgressIndicator(
                          color: Color.fromRGBO(219, 119, 26, 1),
                        )),
                      mapState.shouldShowSuggestionPage
                          ? SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Stack(children: [
                                Container(
                                  color: Colors.white,
                                  child: OldSuggestionPage(
                                      onClose: () => _setShowSuggestionPage(
                                          false, 'complete'),
                                      mapContext: mapContext,
                                      mapState: mapState,
                                      searchContent: fieldSearchText.text,
                                      setSelectedSuggestion:
                                          setSelectedSuggestion,
                                      onSearchIconSelected:
                                          onSearchIconSelected,
                                      onSearchNearbyCall: onSearchNearbyCall,
                                      onSearchFromHistory: onSearchFromHistory,
                                      fieldSearchText: fieldSearchText,
                                      myFocusNode: myFocusNode,
                                      clearText: clearText,
                                      deviceLocation: position),
                                )
                              ]))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  // SearchPage(
                                  //     setShowSuggestionPage:
                                  //         _setShowSuggestionPage,
                                  //     mapContext: mapContext,
                                  //     mapState: mapState,
                                  //     searchContent: isMapSearchModel
                                  //         ? widget.mapPageModel?.userInput
                                  //         : '',
                                  //     onSearchNearbyCall: onSearchNearbyCall,
                                  //     deviceLocation: position),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (selectedIndex != 999) {
                                            onRecenterIconTaped(selectedIndex);
                                          } else {
                                            onSearchNearbyCall();
                                          }
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(14)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: ui.Color.fromARGB(
                                                      40, 112, 112, 112),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 10)
                                            ],
                                          ),
                                          child: SvgPicture.asset(
                                              'assets/RecenterButton.svg'),
                                        ),
                                      ),
                                      if (mapState.isShowBrnachList ||
                                          isShowBranchListWhenInit)
                                        Container(
                                          width: getActualWidth(context),
                                          height: 230,
                                          child: CarouselSlider.builder(
                                            carouselController:
                                                carouselController,
                                            options: CarouselOptions(
                                                initialPage:
                                                    selectedIndex == 999
                                                        ? 0
                                                        : selectedIndex,
                                                viewportFraction: 0.9,
                                                onPageChanged: (index, reason) {
                                                  onCurrentCardChange(index);
                                                },
                                                enableInfiniteScroll: false),
                                            itemCount: mainBranchList!.length,
                                            itemBuilder:
                                                ((context, index, realIndex) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    info.InfoWindow(
                                                        title: mainBranchList![index]
                                                            .branchName,
                                                        address: mainBranchList![index]
                                                            .brnachAddress,
                                                        subDistrict:
                                                            mainBranchList![index]
                                                                .subDistrict,
                                                        province: mainBranchList![index]
                                                            .province,
                                                        contact: mainBranchList![index]
                                                            .mobilePhoneNumber,
                                                        district:
                                                            mainBranchList![index]
                                                                .district,
                                                        distance: isPosition
                                                            ? (mainBranchList![index].distance ?? 0).toStringAsFixed(1) +
                                                                " กม."
                                                            : '0 กม.',
                                                        // ? '${googleMapValueHandler.haversineDistance(position.latitude, position.longitude, parsingDouble(mainBranchList![index].latitude), parsingDouble(mainBranchList![index].longtitude)).toStringAsFixed(1)} กม.'
                                                        // : '0 กม.',
                                                        launchDial: () => launchCall(
                                                            mainBranchList![index]
                                                                .mobilePhoneNumber),
                                                        launchMap: () => launchMap(
                                                            parsingDouble(mainBranchList![index].latitude),
                                                            parsingDouble(mainBranchList![index].longtitude)))
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                        )
                                    ],
                                  )
                                ])
                    ],
                  );
                }))
            : Container(
                color: Colors.white,
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: BOTTOM_NAVIGATION_HEIGHT),
                    child: NoInternetWidget(
                      onRetry: () async {
                        checkLocationPermission();
                      },
                    ),
                  ),
                ),
              )
        : Container();
  }

  void initInstance() {
    FirebaseAnalytics.instance.logEvent(
      name: 'branch_page_view',
      parameters: {
        'user_lat': '',
        'user_long': '',
      },
    );
    BlocProvider.of<PageResultBloc>(context)
        .add(const SetButtonNavigator(true));
    isMapSearchModel = widget.mapPageModel != null &&
        widget.mapPageModel!.branchList!.isNotEmpty;
    try {
      getDeviceCenter();
      if (isMapSearchModel) {
        isShowBranchListWhenInit =
            widget.mapPageModel!.isShowBranchListWhenInit!;
        mainBranchList = widget.mapPageModel!.branchList;
        if (isShowBranchListWhenInit) {
          selectedIndex = 0;
        }
        updateMarker(widget.mapPageModel!.branchList!);
        if (widget.mapPageModel!.isShowBranchListWhenInit!) {
          setCenter(LatLng(
              parsingDouble(widget.mapPageModel!.branchList![0].latitude),
              parsingDouble(widget.mapPageModel!.branchList![0].longtitude)));

          getDevicePosition(true);
        } else {
          getDevicePosition(false);
        }
      } else {
        getDevicePosition(false);
      }
    } catch (e) {
      logger.e('Error occur in map init $e');
    }
  }

  Future<void> navigateToHomeTab() async {
    await Timer(Duration(seconds: 5), () {
      BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
      BlocProvider.of<PageResultBloc>(context).add(SetCurrentNavBarIndex(0));
      Navigator.pushNamed(context, '/home-page');
    });
  }

  Future<void> getUserLocation() async {
    await googleMapValueHandler.determinePosition().then((userLocation) {
      LocalStoragePrefernces localStoragePrefernces = LocalStoragePrefernces();
      localStoragePrefernces.setLocalStorage(
          'userLocation',
          '{"lat" : "${userLocation.latitude}", "lng" : "${userLocation.longitude}"}',
          'string');
      var userLocationLatLng =
          LatLng(userLocation.latitude, userLocation.longitude);
      context.read<mapSearch.MapSearchBloc>().add(mapSearch.MapSearchNearby(
          userLocationLatLng, mapSearchRepo, context, userLocationLatLng));
    }, onError: (e) {
      navigateToHomeTab();
    });
  }
}
