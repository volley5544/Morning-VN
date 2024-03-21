import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_application_srisawad/pages/map/google_map_value_handler.dart';
import 'package:mobile_application_srisawad/pages/map/suggestion_list.dart';
import 'package:mobile_application_srisawad/widgets/history_list.dart'
    as history;
import '../../main.dart';
import '../../widgets/suggest_result.dart';
import 'package:mobile_application_srisawad/bloc/map_search_bloc/map_search_bloc.dart'
    as mapSearch;
import 'package:mobile_application_srisawad/modules/mapSearch/index.dart'
    as mapRepo;

class OldSuggestionPage extends StatefulWidget {
  final VoidCallback onClose;

  final BuildContext mapContext;
  final mapSearch.MapSearchState mapState;
  final String? searchContent;

  // var userInput;
  final Function setSelectedSuggestion;
  final Function onSearchIconSelected;
  final Function onSearchNearbyCall;
  final Function onSearchFromHistory;
  final TextEditingController fieldSearchText;
  final FocusNode myFocusNode;
  final Function clearText;
  final Position? deviceLocation;

  OldSuggestionPage(
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
      required this.deviceLocation})
      : super(key: key);
  // Widget SuggestionBox

  @override
  State<OldSuggestionPage> createState() => _OldSuggestionPage();
}

class _OldSuggestionPage extends State<OldSuggestionPage> {
  // final fieldSearchText = TextEditingController();
  final GoogleMapValueHandler googleMapValueHandler = GoogleMapValueHandler();
  Timer? debounce;

  late bool isTextSet = true;

  final mapRepo.MapSearch mapSearchRepo = mapRepo.MapSearch();

  void onSearchChanged(String query, BuildContext mapContext) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      mapContext.read<mapSearch.MapSearchBloc>().add(
          mapSearch.MapsearchTextChange(query, mapSearchRepo, context,
              googleMapValueHandler, widget.deviceLocation));
    });
    // setState(() {
    //   fieldSearchText.text = query;
    // });
  }

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

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    SizedBox(
                      width: isWidthTooLong(context)
                          ? 500 - 92
                          : MediaQuery.of(context).size.width - 92,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                          border: Border.all(
                              color: Color.fromRGBO(229, 229, 229, 1)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Container(
                            height: 60,
                            child: TextField(
                              onChanged: (value) {
                                onSearchChanged(value, widget.mapContext);
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
                              textAlignVertical: TextAlignVertical.bottom,
                              style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Color.fromRGBO(0, 48, 99, 1),
                                  fontFamily: 'NotoSansThai',
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w500,
                                  height: 1.6),
                              decoration: InputDecoration(
                                border: InputBorder.none,
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
                                suffixIcon: GestureDetector(
                                    onTap: () => widget.clearText(),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 12, 0, 12),
                                      child: SvgPicture.asset(
                                          'assets/ClearIcon.svg'),
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide.none),
                                hintText: 'ค้นหาชื่อสาขา, ตำบล, อำเภอ',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))),
        widget.mapState is mapSearch.MapSearchInitial
            ? Column(
                children: [
                  Container(
                    height: 3,
                    color: Color.fromRGBO(230, 230, 230, 1),
                  ),
                  Row(children: const <Widget>[
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
                ],
              )
            : Container(
                height: 3,
                color: Color.fromRGBO(230, 230, 230, 1), // F)0000
              ),
        widget.mapState is mapSearch.MapSearchError
            ? renderErrorCase()
            : widget.mapState is mapSearch.MapSearchInitial
                ? Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              ...(widget.mapState.historyInputList
                                  .map((e) {
                                    return GestureDetector(
                                      onTap: () {
                                        widget.onSearchFromHistory(
                                            e, mapSearchRepo);
                                      },
                                      child: Container(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          child: history.HistoryList(e)),
                                    );
                                  })
                                  .toList()
                                  .reversed),
                            ],
                          )),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                          width: double.infinity,
                          child: widget.mapState
                                      is mapSearch.MapSearchComplete &&
                                  widget.mapState.branchOptions.isEmpty
                              ? Container(
                                  height: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: SvgPicture.asset(
                                            'assets/notFoundIcon.svg'),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Text(
                                          'ไม่พบการค้นหา',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  138, 152, 167, 1),
                                              fontFamily: 'NotoSansThai',
                                              fontSize: 16,
                                              letterSpacing:
                                                  0 /*percentages not used in flutter. defaulting to zero*/,
                                              fontWeight: FontWeight.w600,
                                              height: 1),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Column(
                                  children: [
                                    // SuggestionList(
                                    //   fieldSearchText: widget.fieldSearchText,
                                    //   mapState: widget.mapState,
                                    //   setSelectedSuggestion:
                                    //       widget.setSelectedSuggestion,
                                    // ),
                                  ],
                                )),
                    ),
                  ),
      ],
    );
  }
}
