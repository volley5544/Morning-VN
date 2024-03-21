import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/map_search_bloc/map_search_bloc.dart'
    as mapSearch;
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/branch_detail.dart';
import 'package:mobile_application_srisawad/modules/mapSearch/index.dart'
    as mapRepo;

import '../../bloc/map_bloc/map_bloc.dart';

class SearchPage extends StatefulWidget {
  final BuildContext mapContext;
  final MapState mapState;
  final Function setShowSuggestionPage;
  final String? searchContent;
  final Function onSearchNearbyCall;
  // final Position? deviceLocation;

  const SearchPage({
    Key? key,
    required this.mapContext,
    required this.mapState,
    // required this.setMapPageState,
    this.searchContent,
    required this.setShowSuggestionPage,
    required this.onSearchNearbyCall,
    // this.deviceLocation,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Timer? debounce;
  bool isBnrachSelected = false;
  final autocompleteText = TextEditingController();

  FutureOr<Iterable<BranchDetail>> buildBrnachOption(
      mapSearch.MapSearchState mapState, String userInput) {
    if (mapState is mapSearch.MapSearchLoading ||
        userInput == '' ||
        mapState is mapSearch.MapSearchInitial) {
      return const Iterable<BranchDetail>.empty();
    }
    if (mapState is mapSearch.MapSearchComplete) {
      return mapState.branchOptions.where((BranchDetail option) {
        return option.branchName.toString().contains(userInput.toLowerCase());
      });
    }
    return const Iterable<BranchDetail>.empty();
  }

  String displayStringOption(BranchDetail option) => option.branchName;

  final mapRepo.MapSearch mapSearchRepo = mapRepo.MapSearch();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 14,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(10, 25, 10, 0),
        child: GestureDetector(
          onTap: () => widget.setShowSuggestionPage(),
          // onTap: () => widget.setShowSuggestionPage(true, 'init'),
          child: Container(
              // width: getActualWidth(context),
              height: 54,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: <
                      Widget>[
                Container(
                    width: getActualWidth(context) * 0.82,
                    height: 54,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
                            offset: Offset(0, 0),
                            blurRadius: 30)
                      ],
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.5, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/Search.svg',
                              ),
                              Center(
                                child: SizedBox(
                                  // width: getActualWidth(context) * 0.6,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 0, 0, 5),
                                    child: widget.searchContent == '' ||
                                            widget.searchContent == null
                                        ? Text(
                                            'ค้นหาชื่อสาขา, ตำบล, อำเภอ, จังหวัด',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    219, 219, 219, 1),
                                                fontFamily: 'NotoSansThai',
                                                fontSize: MediaQuery.of(context)
                                                            .textScaleFactor !=
                                                        1
                                                    ? 14
                                                    : 16,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.normal,
                                                height: 2.5),
                                          )
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                                '${widget.searchContent}',
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.notoSansThai(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        HexColor('#003063'))),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          widget.searchContent == '' ||
                                  widget.searchContent == null
                              ? Container()
                              : GestureDetector(
                                  onTap: () => widget.onSearchNearbyCall(),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 14, 0),
                                    child: SvgPicture.asset(
                                      'assets/ClearIcon.svg',
                                    ),
                                  ),
                                )
                        ],
                      ),
                    )),
              ])),
        ),
      ),
    );
  }
}

// Figma Flutter Generator SearchWidget - INSTANCE
