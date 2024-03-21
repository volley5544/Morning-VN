import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/pages/map/google_map_value_handler.dart';
import 'package:mobile_application_srisawad/pages/map/suggestion_list.dart';
import 'package:mobile_application_srisawad/widgets/history_list.dart'
    as history;
import '../../bloc/map_bloc/map_bloc.dart';
import '../../main.dart';
import '../../models/branch_detail.dart';
import '../../widgets/suggest_result.dart';
// import 'package:mobile_application_srisawad/bloc/map_search_bloc/map_search_bloc.dart'
//     as mapSearch;
import 'package:mobile_application_srisawad/modules/mapSearch/index.dart'
    as mapRepo;

class SuggestionPage extends StatefulWidget {
  final VoidCallback onClose;

  final BuildContext mapContext;
  final MapState mapState;
  final String? searchContent;

  // var userInput;
  final Function setSelectedSuggestion;
  final Function onSearchIconSelected;
  final Function onSearchNearbyCall;
  final Function onSearchFromHistory;
  final TextEditingController fieldSearchText;
  final FocusNode myFocusNode;
  final Function clearText;
  final Function onSearchChanged;
  final Position deviceLocation;

  const SuggestionPage(
      {Key? key,
      required this.onClose,
      required this.mapContext,
      required this.mapState,
      required this.searchContent,
      // required this.userInput,
      required this.setSelectedSuggestion,
      required this.onSearchIconSelected,
      required this.onSearchNearbyCall,
      required this.onSearchFromHistory,
      required this.fieldSearchText,
      required this.myFocusNode,
      required this.clearText,
      required this.onSearchChanged,
      required this.deviceLocation});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  // final fieldSearchText = TextEditingController();
  final GoogleMapValueHandler googleMapValueHandler = GoogleMapValueHandler();
  Timer? debounce;

  late bool isTextSet = true;

  final mapRepo.MapSearch mapSearchRepo = mapRepo.MapSearch();

  // void onSearchChanged(String query, BuildContext mapContext) {
  //   if (debounce?.isActive ?? false) debounce?.cancel();
  //   debounce = Timer(const Duration(milliseconds: 500), () {
  //     mapContext.read<NewMapBloc>().add(
  //         NewMapSearch(query, mapSearchRepo, context,
  //             googleMapValueHandler, widget.deviceLocation));
  //   });
  // }

  @override
  void initState() {
    FirebaseAnalytics.instance.logEvent(
      name: 'branch_suggest_search',
      parameters: {
        'keyword': '',
      },
    );
    if (widget.searchContent != null && isTextSet) {
      // fieldSearchText.text = '20';
      widget.fieldSearchText.text = widget.searchContent!;
      isTextSet = false;
    }
    super.initState();
  }

  Widget renderErrorCase() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 63),
          child: Image.asset('assets/ServerSuspended.png'),
        ),
        Text(
          'ไม่สามารถทำรายการได้ขณะนี้?',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.merge(const TextStyle(letterSpacing: -0.1)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text(
            'ขออภัย กรุณาลองใหม่อีกครั้ง',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.merge(TextStyle(
                color: Theme.of(context).colorScheme.tertiaryContainer)),
          ),
        ),
      ],
    );
  }

  Widget historyList() {
    return Expanded(
      child: Container(
        color: HexColor('#FFFFFF'),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                ...(widget.mapState.historyInputList
                    .map((e) {
                      return GestureDetector(
                        onTap: () {
                          widget.onSearchFromHistory(e, mapSearchRepo);
                        },
                        child: Container(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            child: history.HistoryList(e)),
                      );
                    })
                    .toList()
                    .reversed),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget notFoundWidget(MapState mapState) {
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset('assets/notFoundIcon.svg'),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'ไม่พบการค้นหา',
              style: TextStyle(
                      color: Color.fromRGBO(138, 152, 167, 1),
                      fontFamily: 'NotoSansThai',
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                      height: 1)
                  .merge(TextStyle(fontFamily: 'NotoSansThaiSemiBold')),
            ),
          )
        ],
      ),
    );
  }

  Widget renderWidget(MapState mapState) {
    switch (mapState.runtimeType) {
      case (MapError):
        return renderErrorCase();
      case (MapInitial):
        return historyList();
      case (MapNoresultFound):
        return Expanded(
          child: SingleChildScrollView(
            child: Container(
                width: double.infinity, child: notFoundWidget(mapState)),
          ),
        );
      case (MapComplete):
        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SuggestionList(
                  fieldSearchText: widget.fieldSearchText,
                  mapState: widget.mapState,
                  setSelectedSuggestion: widget.setSelectedSuggestion,
                  position: widget.deviceLocation,
                ),
              ],
            ),
          ),
        );
      case (LoadOnTextChange):
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: CircularProgressIndicator(
                color: Color.fromRGBO(219, 119, 26, 1),
              )),
            ],
          ),
        );
      default:
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor('#FFFFFF'),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(12, 56, 12, 20),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: widget.onClose,
                          child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                  border: Border.all(
                                      color: Color.fromRGBO(229, 229, 229, 1))),
                              child: SvgPicture.asset('assets/GoBackIcon.svg')),
                        ),
                        Container(
                          width: 8,
                        ),
                        Container(
                          width: isWidthTooLong(context)
                              ? 500 - 92
                              : MediaQuery.of(context).size.width - 92,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            border: Border.all(
                                color: Color.fromRGBO(229, 229, 229, 1)),
                          ),
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Container(
                            height: 60,
                            child: Center(
                              child: TextField(
                                onChanged: (value) {
                                  widget.onSearchChanged(
                                      value, widget.mapContext);
                                },
                                onSubmitted: (e) {
                                  if (e.isNotEmpty) {
                                    widget.onSearchIconSelected(
                                        widget.fieldSearchText.text,
                                        widget.mapState);
                                  }
                                },
                                maxLines: 1,
                                controller: widget.fieldSearchText,
                                focusNode: widget.myFocusNode,
                                // textAlignVertical: TextAlignVertical.bottom,
                                style: GoogleFonts.notoSansThai(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: HexColor('#003063')),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  labelStyle:
                                      const TextStyle(color: Colors.yellow),
                                  hintStyle: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Color.fromRGBO(219, 219, 219, 1),
                                    fontFamily: 'NotoSansThai',
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  prefixIcon: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 12, 0, 12),
                                    child: SvgPicture.asset(
                                      'assets/Search.svg',
                                    ),
                                  ),
                                  suffixIcon: widget.fieldSearchText.text == ''
                                      ? Padding(padding: EdgeInsets.all(1))
                                      : GestureDetector(
                                          onTap: () => widget.clearText(),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 12, 0, 12),
                                            child: SvgPicture.asset(
                                                'assets/ClearIcon.svg'),
                                          )),
                                  hintText:
                                      'ค้นหาชื่อสาขา, ตำบล, อำเภอ, จังหวัด',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))),
            widget.mapState is MapInitial
                ? Column(
                    children: [
                      Container(
                        height: 3,
                        color: Color.fromRGBO(230, 230, 230, 1),
                      ),
                      Container(
                        color: HexColor('#FFFFFF'),
                        child: Row(children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 15, 8, 8),
                            child: Text(
                              'ค้นหาล่าสุด',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(218, 119, 26, 1),
                                  fontFamily: 'NotoSansThai',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  height: 1),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  )
                : Container(
                    height: 3,
                    color: HexColor('#E6E6E6'), // F)0000
                  ),
            renderWidget(widget.mapState),
          ],
        ),
      ),
    );
  }
}
