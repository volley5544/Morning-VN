import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_application_srisawad/pages/map/map_loading_overlay.dart';
import 'package:mobile_application_srisawad/pages/map/google_map_value_handler.dart';
import 'package:mobile_application_srisawad/pages/map/serach_page.dart';

import 'package:mobile_application_srisawad/pages/map/info_window.dart' as info;
import 'package:mobile_application_srisawad/widgets/text_compent.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/map_bloc/map_bloc.dart';
import '../../bloc/page_result/page_result_bloc.dart';
import '../../main.dart';
import '../../models/branch_detail.dart';
import '../../modules/mapSearch/index.dart';
import '../../services/localStorage/local_storage.dart';
import '../../util/logger_service.dart';
import '../../widgets/no_internet_widget.dart';
import '../../widgets/progress_loading.dart';
import '../map_assets/map_detail.dart';
import 'map_controller/map_controller.dart';
import 'suggestion_page.dart';

class MapWidgetController {
  late bool isShowCard;
  late bool isShowSuggestionPage;
  late LatLng deviceLatLng = const LatLng(13.7563, 100.5018);
  late int initCard = 999;
  late Uint8List commonIcon;
  late Uint8List selectedIcon;
  late bool allowSlidingSearch;

  MapWidgetController({
    required this.isShowCard,
    required this.isShowSuggestionPage,
    required this.deviceLatLng,
    required this.initCard,
    required this.commonIcon,
    required this.selectedIcon,
    required this.allowSlidingSearch,
  });
}

class NewMapPage extends StatefulWidget {
  const NewMapPage({super.key});

  @override
  State<NewMapPage> createState() => _NewMapPageState();
}

class _NewMapPageState extends State<NewMapPage> {
  Timer? debounce;

  bool isDeviceLocationExist = false;
  bool? hasConnection = null;
  late Position devicePosition;
  Set<Marker> markers = Set();
  MapSearch mapSearchRepo = MapSearch();

  // late Uint8List markerIcon;
  // late Uint8List selectedMarker;
  late int selectedIndex = 999;
  late FocusNode myFocusNode = FocusNode();
  late bool toggler = false;
  late GoogleMapController mapController;

  final CarouselController carouselController = CarouselController();
  late TextEditingController fieldSearchText = TextEditingController();
  final GoogleMapValueHandler googleMapValueHandler = GoogleMapValueHandler();
  MapWidgetController mapWidgetController = MapWidgetController(
    isShowCard: false,
    isShowSuggestionPage: false,
    deviceLatLng: LatLng(
      13.7563,
      100.5018,
    ),
    initCard: 999,
    commonIcon: Uint8List(0),
    selectedIcon: Uint8List(0),
    allowSlidingSearch: true,
  );

  doDeniedDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding:
                EdgeInsets.only(top: 22, right: 12, left: 12, bottom: 12),
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
                Body('เพื่อให้คุณสามารถเข้าใช้งานหน้า ค้นหาสาขา ได้ คุณจำเป็นต้องไปที่ตั้งค่าและกดเปิดใช้งานตำแหน่งที่ตั้ง',
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
                          await navigateToHomeTab();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: HexColor('#FCEFE4'),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18),
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
                          // getUserLocation();
                          await openAppSettings();
                          Navigator.of(context).pop();
                          await navigateToHomeTab();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                              color: HexColor('#DB771A'),
                              borderRadius: BorderRadius.circular(15)),
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
          );
        });
  }

  Future<void> checkLocationPermission() async {
    if (await InternetConnectionChecker().hasConnection) {
      setStateWrapper(() {
        hasConnection = true;
      });
      await googleMapValueHandler.isLocationAvailable().then(
          (isAvailable) async {
        await getUserLocation();
      }, onError: (locationError) async {
        LocationPermission permission;
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            logger.i('Location Permissions are denied');
            await navigateToHomeTab();
          } else if (permission == LocationPermission.deniedForever) {
            // TODO : Bring user to applicationSettings to allow location permission;
            doDeniedDialog();
          } else {
            try {
              await Geolocator.getCurrentPosition();
              await getUserLocation();
            } catch (e) {
              await navigateToHomeTab();
            }
          }
        } else {
          try {
            await Geolocator.getCurrentPosition();
            await getUserLocation();
          } catch (e) {
            await navigateToHomeTab();
          }
        }
      });
    } else {
      setStateWrapper(() {
        hasConnection = false;
      });
    }
  }

  void loadIcon() async {
    var devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    mapWidgetController.commonIcon = await getBytesFromAsset(
        'assets/OriginnalCommonPin.png', (70 * devicePixelRatio).round());
    mapWidgetController.selectedIcon = await getBytesFromAsset(
        'assets/OriginalSelectedPin.png', (80 * devicePixelRatio).round());
  }

  @override
  void initState() {
    if (mounted) {
      checkLocationPermission();
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        loadIcon();
      });
      super.initState();
    }
  }

  @override
  void dispose() {
    // mapController.dispose();
    mapWidgetController.isShowSuggestionPage = false;
    super.dispose();
  }

  void setStateWrapper(Function callBack) {
    if (mounted) {
      callBack();
    }
  }

  Future<void> navigateToHomeTab() async {
    BlocProvider.of<PageResultBloc>(context)
        .add(const SetButtonNavigator(true));
    BlocProvider.of<PageResultBloc>(context)
        .add(const SetCurrentNavBarIndex(0));
  }

  Future<void> getUserLocation() async {
    await googleMapValueHandler.determinePosition().then((userLocation) {
      LocalStoragePrefernces localStoragePrefernces = LocalStoragePrefernces();
      localStoragePrefernces.setLocalStorage(
          'userLocation',
          '{"lat" : "${userLocation.latitude}", "lng" : "${userLocation.longitude}"}',
          'string');
      devicePosition = userLocation;
      mapWidgetController.deviceLatLng =
          LatLng(userLocation.latitude, userLocation.longitude);
      setStateWrapper(() {
        isDeviceLocationExist = true;
      });
      onSearchNearbyCall(
        isRenderedforFirstTime: true,
        considerCheckLocation: false,
        branchOptions: [],
      );
    }, onError: (e) async {
      logger.e('Error: (getUserLocation): ${e}');
      if (e == LocationPermissionError.permissionDeniedForever) {
        openAppSettingLocationDialog();
      } else {
        await navigateToHomeTab();
      }
    });
  }

  void onCurrentCardChange(int index) {
    context.read<MapBloc>().add(
          OnCurrentCardChange(
              context: context,
              deviceCenter: mapWidgetController.deviceLatLng,
              mapSearch: mapSearchRepo,
              markers: markers,
              selectedIndex: index,
              setState: (() {
                setState(() {});
              }),
              mapWidgetController: mapWidgetController,
              mapController: mapController,
              carouselController: carouselController),
        );
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

  _launchMap(BuildContext context, lat, lng) async {
    late Uri url;
    late Uri urlAppleMaps;
    if (Platform.isAndroid) {
      url = Uri.parse(
          "https://www.google.com/maps/search/?api=1&query=${lat},${lng}");
    } else {
      urlAppleMaps = Uri.parse('https://maps.apple.com/?q=$lat,$lng');
      url = Uri.parse(
          "comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=driving");
      if (await canLaunchUrl(urlAppleMaps)) {
        await launchUrl(urlAppleMaps, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(urlAppleMaps)) {
      await launchUrl(urlAppleMaps, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> onRecenterIconTaped(int selectedCradIndex,
      List<BranchDetail> branchOptions, bool considerCheckLocation) async {
    final branchLat = parsingDouble(branchOptions[selectedCradIndex].latitude);
    final branchLng =
        parsingDouble(branchOptions[selectedCradIndex].longtitude);
    if (considerCheckLocation) {
      await googleMapValueHandler.determinePosition().then((userLocation) {
        if (userLocation.latitude == devicePosition.latitude &&
            userLocation.longitude == devicePosition.longitude) {
        } else {
          devicePosition = userLocation;
        }
      });
    }
    updateCameraLocation(
        LatLng(devicePosition.latitude, devicePosition.longitude),
        LatLng(branchLat, branchLng),
        mapController);
  }

  void onSearchChanged(String query, BuildContext mapContext) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      mapContext.read<MapBloc>().add(NewMapOnTextChange(
          context: context,
          deviceCenter: mapWidgetController.deviceLatLng,
          googleMapValueHandler: googleMapValueHandler,
          mapSearchRepo: mapSearchRepo,
          mapWidgetController: mapWidgetController,
          query: query,
          searchInput: query,
          isIconSelected: false,
          mapSearch: mapSearchRepo,
          markers: markers,
          selectedIndex: 0,
          setState: () {
            setState(() {});
          }));
    });
  }

  Future<void> onSearchNearbyCall(
      {required bool isRenderedforFirstTime,
      required bool considerCheckLocation,
      required List<BranchDetail> branchOptions}) async {
    try {
      FirebaseAnalytics.instance.logEvent(
        name: 'branch_nearby_search',
        parameters: {
          'user_lat': '',
          'user_long': '',
        },
      );

      bool refetch = true;
      if (considerCheckLocation) {
        await googleMapValueHandler.determinePosition().then((userLocation) {
          if (userLocation.latitude == devicePosition.latitude &&
              userLocation.longitude == devicePosition.longitude) {
            refetch = false;
          } else {
            devicePosition = userLocation;
          }
        });
      }

      if (!isRenderedforFirstTime) {
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target:
                    LatLng(devicePosition.latitude, devicePosition.longitude),
                zoom: 12)));
      }
      if (refetch || branchOptions.isEmpty) {
        context.read<MapBloc>().add(
              NewMapSearchNearby(
                context: context,
                screenCenter: mapWidgetController.deviceLatLng,
                mapSearch: mapSearchRepo,
                markers: markers,
                selectedIndex: selectedIndex,
                setState: (() {
                  setState(() {
                    toggler = !toggler;
                  });
                  return '';
                }),
                mapWidgetController: mapWidgetController,
                deviceCenter:
                    LatLng(devicePosition.latitude, devicePosition.longitude),
                carouselController: carouselController,
              ),
            );
      }
    } catch (e) {
      logger.e('Error occur in map search nearby $e');
    }
  }

  void onSearchIconSelected(String searchInput, MapState mapState) {
    FirebaseAnalytics.instance.logEvent(
      name: 'branch_search',
      parameters: {'keyword': ''},
    );
    BlocProvider.of<PageResultBloc>(context)
        .add(SetIsSuggestionPageShown(true));
    context.read<MapBloc>().add(NewMapSearch(
        context: context,
        deviceCenter: mapWidgetController.deviceLatLng,
        googleMapValueHandler: googleMapValueHandler,
        mapSearchRepo: mapSearchRepo,
        mapWidgetController: mapWidgetController,
        query: searchInput,
        searchInput: searchInput,
        isIconSelected: true,
        mapSearch: mapSearchRepo,
        markers: markers,
        selectedIndex: 0,
        setState: () {
          setState(() {});
        },
        carouselController: carouselController,
        mapController: mapController));
  }

  void setSelectedSuggestion(List<BranchDetail> branchDetailList) {
    setState(() {
      mapWidgetController.isShowSuggestionPage = false;
    });
    fieldSearchText.text = branchDetailList[0].branchName;
    BlocProvider.of<PageResultBloc>(context)
        .add(SetIsSuggestionPageShown(true));
    context.read<MapBloc>().add(OnSearchFromExistingBranchList(
        branchOptions: branchDetailList,
        context: context,
        deviceCenter: mapWidgetController.deviceLatLng,
        mapSearch: mapSearchRepo,
        markers: markers,
        selectedIndex: 0,
        setState: (() {
          setState(() {});
        }),
        mapWidgetController: mapWidgetController,
        carouselController: carouselController,
        googleMapController: mapController));
  }

  Future<void> _setShowSuggestionPage(bool isColse) async {
    if (isColse) {
      context.read<MapBloc>().add(SetNewMapInit());
    } else {
      context.read<MapBloc>().add(SetNewComplete());
    }
    setState(() {
      mapWidgetController.isShowSuggestionPage = isColse;
    });
    BlocProvider.of<PageResultBloc>(context)
        .add(SetIsSuggestionPageShown(!isColse));
    myFocusNode.requestFocus();
  }

  void onSearchFromHistory(String userInput, MapSearch mapSearchRepo) {
    FirebaseAnalytics.instance.logEvent(
      name: 'branch_history_search',
      parameters: {
        'keyword': userInput,
      },
    );
    fieldSearchText.text = userInput;
    // shouldShowSuggestionPage = false;
    // isShowBrnachList = true;
    BlocProvider.of<PageResultBloc>(context)
        .add(SetIsSuggestionPageShown(true));
    context.read<MapBloc>().add(NewMapSearch(
        context: context,
        deviceCenter: mapWidgetController.deviceLatLng,
        googleMapValueHandler: googleMapValueHandler,
        mapSearchRepo: mapSearchRepo,
        mapWidgetController: mapWidgetController,
        query: userInput,
        searchInput: userInput,
        isIconSelected: true,
        mapSearch: mapSearchRepo,
        markers: markers,
        selectedIndex: 0,
        setState: () {
          setState(() {});
        },
        carouselController: carouselController,
        mapController: mapController));
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        // isDeviceLocationExist
        //     ?
        hasConnection != null
            ? hasConnection!
                ? Scaffold(
                    body: BlocBuilder<MapBloc, MapState>(
                      builder: (mapContext, mapState) {
                        return Stack(
                          children: [
                            // Center(child: ProgressLoading()),
                            MapDetail(
                                markers: markers,
                                latLng: mapWidgetController.deviceLatLng,
                                onMapCreate: onMapCreated),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text('test'),
                                SearchPage(
                                  setShowSuggestionPage: () =>
                                      _setShowSuggestionPage(true),
                                  mapContext: context,
                                  mapState: mapState,
                                  searchContent: mapState.searchText,
                                  onSearchNearbyCall: () => onSearchNearbyCall(
                                    isRenderedforFirstTime: false,
                                    considerCheckLocation: true,
                                    branchOptions: [],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    // SizedBox(
                                    //   height: 200,
                                    //   width: MediaQuery.of(context).size.width,
                                    // ),
                                    GestureDetector(
                                      onTap: () {
                                        if (mapState.selectedIndex != 999) {
                                          onRecenterIconTaped(
                                              mapWidgetController.initCard,
                                              mapState.branchOptions,
                                              true);
                                        } else {
                                          onSearchNearbyCall(
                                            isRenderedforFirstTime: false,
                                            considerCheckLocation: true,
                                            branchOptions:
                                                mapState.branchOptions,
                                          );
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
                                    mapWidgetController.isShowCard
                                        ? Container(
                                            width: getActualWidth(context),
                                            height: 230,
                                            child: CarouselSlider.builder(
                                              carouselController:
                                                  carouselController,
                                              options: CarouselOptions(
                                                  initialPage:
                                                      mapWidgetController
                                                                  .initCard ==
                                                              999
                                                          ? 0
                                                          : mapWidgetController
                                                              .initCard,
                                                  viewportFraction: 0.9,
                                                  onPageChanged:
                                                      (index, reason) {
                                                    onCurrentCardChange(index);
                                                  },
                                                  enableInfiniteScroll: false),
                                              itemCount:
                                                  mapState.branchOptions.length,
                                              itemBuilder:
                                                  ((context, index, realIndex) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      info.InfoWindow(
                                                          title: mapState
                                                              .branchOptions[
                                                                  index]
                                                              .branchName,
                                                          address: mapState
                                                              .branchOptions[
                                                                  index]
                                                              .brnachAddress,
                                                          subDistrict: mapState
                                                              .branchOptions[
                                                                  index]
                                                              .subDistrict,
                                                          province: mapState
                                                              .branchOptions[
                                                                  index]
                                                              .province,
                                                          contact: mapState
                                                              .branchOptions[
                                                                  index]
                                                              .mobilePhoneNumber,
                                                          district: mapState
                                                              .branchOptions[
                                                                  index]
                                                              .district,
                                                          distance: getBranchDistance(
                                                                  mapState.branchOptions[
                                                                      index],
                                                                  devicePosition) +
                                                              " กม.",
                                                          // distance: (mapState.branchOptions[index].distance ?? 0).toStringAsFixed(1) +
                                                          //     " กม.",
                                                          launchDial: () => launchCall(mapState
                                                              .branchOptions[
                                                                  index]
                                                              .mobilePhoneNumber),
                                                          launchMap: () => _launchMap(
                                                              context,
                                                              parsingDouble(
                                                                  mapState.branchOptions[index].latitude),
                                                              parsingDouble(mapState.branchOptions[index].longtitude)))
                                                    ],
                                                  ),
                                                );
                                              }),
                                            ),
                                          )
                                        : Container(),
                                    // : Center(child: ProgressLoading()),
                                  ],
                                ),
                              ],
                            ),
                            isDeviceLocationExist == false
                                ? Center(child: ProgressLoading())
                                : Container(),
                            if (mapState is MapSearchLoading)
                              MapLoadingOverlay(
                                  isLoading:
                                      mapState.runtimeType == MapSearchLoading),
                            if (mapWidgetController.isShowSuggestionPage)
                              SuggestionPage(
                                clearText: () {
                                  fieldSearchText.text = '';
                                  context.read<MapBloc>().add(SetNewMapInit());
                                },
                                deviceLocation: devicePosition,
                                fieldSearchText: fieldSearchText,
                                mapContext: context,
                                mapState: mapState,
                                myFocusNode: myFocusNode,
                                onClose: () => _setShowSuggestionPage(false),
                                onSearchFromHistory: onSearchFromHistory,
                                onSearchIconSelected: onSearchIconSelected,
                                onSearchNearbyCall: () {},
                                searchContent: fieldSearchText.text,
                                setSelectedSuggestion: setSelectedSuggestion,
                                onSearchChanged: onSearchChanged,
                              ),
                          ],
                        );
                      },
                    ),
                  )
                : Container(
                    color: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: BOTTOM_NAVIGATION_HEIGHT),
                        child: NoInternetWidget(
                          onRetry: () async {
                            checkLocationPermission();
                          },
                        ),
                      ),
                    ),
                  )
            : Center(child: ProgressLoading());
  }

  void openAppSettingLocationDialog() {
    doDeniedDialog();
    // openAppSettingDialog(
    //     context: context,
    //     title: "อนุญาตให้ “ศรีสวัสดิ์” ใช้ตำแหน่งที่ตั้ง\nของคุณหรือไม่?",
    //     detail:
    //         "เพื่อให้คุณสามารถเข้าใช้งานหน้า ค้นหาสาขา ได้ คุณจำเป็นต้องไปที่ตั้งค่าและกดเปิดใช้งาน ตำแหน่งที่ตั้ง",
    //     onCancel: () {
    //       navigateToHomeTab();
    //     },
    //     onGoToSetting: () {
    //       navigateToHomeTab();
    //     });
  }
}
