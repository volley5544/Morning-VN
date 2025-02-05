import '/backend/schema/structs/index.dart';
import '/components/loading/loading_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/tracking_location/poly_map_widget_component/poly_map_widget_component_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'tracking_page_model.dart';
export 'tracking_page_model.dart';

class TrackingPageWidget extends StatefulWidget {
  const TrackingPageWidget({
    super.key,
    this.selectDate,
    this.data,
    this.index,
  });

  final String? selectDate;
  final List<TrackingEmployeeDataLocationModelStruct>? data;
  final int? index;

  @override
  State<TrackingPageWidget> createState() => _TrackingPageWidgetState();
}

class _TrackingPageWidgetState extends State<TrackingPageWidget>
    with TickerProviderStateMixin {
  late TrackingPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TrackingPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        context: context,
        builder: (context) {
          return WebViewAware(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: MediaQuery.viewInsetsOf(context),
                child: const SizedBox(
                  height: double.infinity,
                  child: LoadingWidget(),
                ),
              ),
            ),
          );
        },
      ).then((value) => safeSetState(() {}));

      _model.dateIndex = (widget.data?.elementAtOrNull(widget.index!))?.date;
      safeSetState(() {});
      FFAppState().polyMapLatLngList = functions
          .makeLatLngList(
              (widget.data?.elementAtOrNull(widget.index!))
                  ?.data
                  .map((e) => e.latitude)
                  .toList()
                  .toList(),
              (widget.data?.elementAtOrNull(widget.index!))
                  ?.data
                  .map((e) => e.latitude)
                  .toList()
                  .toList())!
          .toList()
          .cast<LatLng>();
      FFAppState().polyMapTimeList =
          (widget.data!.elementAtOrNull(widget.index!))!
              .data
              .map((e) => e.times)
              .toList()
              .toList()
              .cast<String>();
      safeSetState(() {});
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.pop(context);
    });

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: const Offset(0.0, 25.0),
            end: const Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: const Offset(0.0, 25.0),
            end: const Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: const Offset(0.0, 25.0),
            end: const Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: const Offset(0.0, 25.0),
            end: const Offset(0.0, 0.0),
          ),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        drawer: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.5,
          child: Drawer(
            elevation: 16.0,
            child: WebViewAware(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(),
                child: Visibility(
                  visible: responsiveVisibility(
                    context: context,
                    tablet: false,
                    tabletLandscape: false,
                    desktop: false,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 100.0, 0.0, 100.0),
                    child: Container(
                      width: 100.0,
                      height: double.infinity,
                      decoration: const BoxDecoration(),
                      child: Builder(
                        builder: (context) {
                          final list30DaysDateTimeListItem = functions
                                  .generateListLast30dateTime(
                                      widget.selectDate)
                                  ?.toList() ??
                              [];

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: list30DaysDateTimeListItem.length,
                            itemBuilder:
                                (context, list30DaysDateTimeListItemIndex) {
                              final list30DaysDateTimeListItemItem =
                                  list30DaysDateTimeListItem[
                                      list30DaysDateTimeListItemIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0,
                                    valueOrDefault<double>(
                                      functions.getDateFormat(
                                                  list30DaysDateTimeListItemItem) ==
                                              _model.dateIndex
                                          ? 8.0
                                          : 4.0,
                                      0.0,
                                    ),
                                    4.0,
                                    valueOrDefault<double>(
                                      functions.getDateFormat(
                                                  list30DaysDateTimeListItemItem) ==
                                              _model.dateIndex
                                          ? 8.0
                                          : 0.0,
                                      0.0,
                                    )),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    if (!functions.containStringInListString(
                                        widget.data
                                            ?.map((e) => e.date)
                                            .toList()
                                            .toList(),
                                        functions.getDateFormat(
                                            list30DaysDateTimeListItemItem))!) {
                                      return;
                                    }
                                    if (scaffoldKey
                                            .currentState!.isDrawerOpen ||
                                        scaffoldKey
                                            .currentState!.isEndDrawerOpen) {
                                      Navigator.pop(context);
                                    }

                                    if (Navigator.of(context).canPop()) {
                                      context.pop();
                                    }
                                    context.pushNamed(
                                      'TrackingPage',
                                      queryParameters: {
                                        'selectDate': serializeParam(
                                          widget.selectDate,
                                          ParamType.String,
                                        ),
                                        'data': serializeParam(
                                          widget.data,
                                          ParamType.DataStruct,
                                          isList: true,
                                        ),
                                        'index': serializeParam(
                                          functions.getIndexOfSomethingList(
                                              widget.data
                                                  ?.map((e) => e.date)
                                                  .toList()
                                                  .toList(),
                                              functions.getDateFormat(
                                                  list30DaysDateTimeListItemItem)),
                                          ParamType.int,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: functions.getDateFormat(
                                                list30DaysDateTimeListItemItem) ==
                                            _model.dateIndex
                                        ? 5.0
                                        : 0.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          valueOrDefault<double>(
                                        functions.getDateFormat(
                                                    list30DaysDateTimeListItemItem) ==
                                                _model.dateIndex
                                            ? 12.0
                                            : 0.0,
                                        0.0,
                                      )),
                                    ),
                                    child: Container(
                                      width: 100.0,
                                      height: functions.getDateFormat(
                                                  list30DaysDateTimeListItemItem) ==
                                              _model.dateIndex
                                          ? 65.0
                                          : 40.0,
                                      decoration: BoxDecoration(
                                        color: valueOrDefault<Color>(
                                          functions.containStringInListString(
                                                  widget.data
                                                      ?.map((e) => e.date)
                                                      .toList()
                                                      .toList(),
                                                  functions.getDateFormat(
                                                      list30DaysDateTimeListItemItem))!
                                              ? FlutterFlowTheme.of(context)
                                                  .secondaryBackground
                                              : const Color(0xFFDFDFDF),
                                          const Color(0xFFDFDFDF),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            valueOrDefault<double>(
                                          functions.getDateFormat(
                                                      list30DaysDateTimeListItemItem) ==
                                                  _model.dateIndex
                                              ? 12.0
                                              : 0.0,
                                          0.0,
                                        )),
                                        border: Border.all(
                                          color: functions.getDateFormat(
                                                      list30DaysDateTimeListItemItem) ==
                                                  _model.dateIndex
                                              ? const Color(0xFFFF6500)
                                              : Colors.transparent,
                                          width: functions.getDateFormat(
                                                      list30DaysDateTimeListItemItem) ==
                                                  _model.dateIndex
                                              ? 3.0
                                              : 0.0,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            valueOrDefault<String>(
                                              valueOrDefault<String>(
                                                functions.showDateBE(
                                                    list30DaysDateTimeListItemItem
                                                        .toString()),
                                                '22/01/68',
                                              ),
                                              '22/01/68',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: valueOrDefault<Color>(
                                                    functions.containStringInListString(
                                                            widget.data
                                                                ?.map((e) =>
                                                                    e.date)
                                                                .toList()
                                                                .toList(),
                                                            functions.getDateFormat(
                                                                list30DaysDateTimeListItemItem))!
                                                        ? FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText
                                                        : const Color(0xFF969696),
                                                    const Color(0xFF969696),
                                                  ),
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF6500),
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.safePop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFBFFFFFF),
              size: 30.0,
            ),
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'f4i8hze7' /* Location พนักงาน */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 10.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 10.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.grid_3x3,
                                  color: Colors.black,
                                  size: 24.0,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    '623ekfqn' /* รหัสพนักงาน : */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 13.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  FFAppState().EmpProfileLocationSelected.employeeId,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 13.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation1']!),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 10.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                  size: 24.0,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'yt2d1r9c' /* ชื่อพนักงาน :  */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 13.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  decoration: const BoxDecoration(),
                                  child: Text(
                                    FFAppState().EmpProfileLocationSelected.nameTh,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 13.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation2']!),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 10.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.work,
                                  color: Colors.black,
                                  size: 24.0,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'ag8e9bht' /* ตำแหน่ง :  */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 13.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  decoration: const BoxDecoration(),
                                  child: Text(
                                    FFAppState().EmpProfileLocationSelected.position,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 13.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation3']!),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 10.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.location_on_sharp,
                                  color: Colors.black,
                                  size: 24.0,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'flp6d1t0' /* จำนวนLocation :  */,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 13.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  decoration: const BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          '${'${(widget.data?.elementAtOrNull(widget.index!))?.data.length.toString()}'} ที่ (${functions.showDateBE(widget.selectDate)})',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 13.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ),
                                      if (responsiveVisibility(
                                        context: context,
                                        tablet: false,
                                        tabletLandscape: false,
                                        desktop: false,
                                      ))
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              scaffoldKey.currentState!
                                                  .openDrawer();
                                            },
                                            child: const Icon(
                                              Icons.calendar_month_rounded,
                                              color: Color(0xFFFF6500),
                                              size: 30.0,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ).animateOnPageLoad(
                          animationsMap['containerOnPageLoadAnimation4']!),
                      const Divider(
                        thickness: 2.0,
                      ),
                    ].addToStart(const SizedBox(height: 8.0)),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (responsiveVisibility(
                          context: context,
                          phone: false,
                        ))
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: 100.0,
                              height: double.infinity,
                              decoration: const BoxDecoration(),
                              child: Builder(
                                builder: (context) {
                                  final list30DaysDateTimeListItem = functions
                                          .generateListLast30dateTime(
                                              widget.selectDate)
                                          ?.toList() ??
                                      [];

                                  return ListView.builder(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      8.0,
                                      0,
                                      12.0,
                                    ),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        list30DaysDateTimeListItem.length,
                                    itemBuilder: (context,
                                        list30DaysDateTimeListItemIndex) {
                                      final list30DaysDateTimeListItemItem =
                                          list30DaysDateTimeListItem[
                                              list30DaysDateTimeListItemIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4.0,
                                            valueOrDefault<double>(
                                              functions.getDateFormat(
                                                          list30DaysDateTimeListItemItem) ==
                                                      _model.dateIndex
                                                  ? 8.0
                                                  : 4.0,
                                              0.0,
                                            ),
                                            4.0,
                                            valueOrDefault<double>(
                                              functions.getDateFormat(
                                                          list30DaysDateTimeListItemItem) ==
                                                      _model.dateIndex
                                                  ? 8.0
                                                  : 0.0,
                                              0.0,
                                            )),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            if (!functions
                                                .containStringInListString(
                                                    widget.data
                                                        ?.map((e) => e.date)
                                                        .toList()
                                                        .toList(),
                                                    functions.getDateFormat(
                                                        list30DaysDateTimeListItemItem))!) {
                                              return;
                                            }
                                            if (Navigator.of(context)
                                                .canPop()) {
                                              context.pop();
                                            }
                                            context.pushNamed(
                                              'TrackingPage',
                                              queryParameters: {
                                                'selectDate': serializeParam(
                                                  widget.selectDate,
                                                  ParamType.String,
                                                ),
                                                'data': serializeParam(
                                                  widget.data,
                                                  ParamType.DataStruct,
                                                  isList: true,
                                                ),
                                                'index': serializeParam(
                                                  functions.getIndexOfSomethingList(
                                                      widget.data
                                                          ?.map((e) => e.date)
                                                          .toList()
                                                          .toList(),
                                                      functions.getDateFormat(
                                                          list30DaysDateTimeListItemItem)),
                                                  ParamType.int,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: functions.getDateFormat(
                                                        list30DaysDateTimeListItemItem) ==
                                                    _model.dateIndex
                                                ? 5.0
                                                : 0.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      valueOrDefault<double>(
                                                functions.getDateFormat(
                                                            list30DaysDateTimeListItemItem) ==
                                                        _model.dateIndex
                                                    ? 12.0
                                                    : 0.0,
                                                0.0,
                                              )),
                                            ),
                                            child: Container(
                                              width: 100.0,
                                              height: functions.getDateFormat(
                                                          list30DaysDateTimeListItemItem) ==
                                                      _model.dateIndex
                                                  ? 65.0
                                                  : 40.0,
                                              decoration: BoxDecoration(
                                                color: valueOrDefault<Color>(
                                                  functions.containStringInListString(
                                                          widget.data
                                                              ?.map(
                                                                  (e) => e.date)
                                                              .toList()
                                                              .toList(),
                                                          functions.getDateFormat(
                                                              list30DaysDateTimeListItemItem))!
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground
                                                      : const Color(0xFFDFDFDF),
                                                  const Color(0xFFDFDFDF),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        valueOrDefault<double>(
                                                  functions.getDateFormat(
                                                              list30DaysDateTimeListItemItem) ==
                                                          _model.dateIndex
                                                      ? 12.0
                                                      : 0.0,
                                                  0.0,
                                                )),
                                                border: Border.all(
                                                  color: functions.getDateFormat(
                                                              list30DaysDateTimeListItemItem) ==
                                                          _model.dateIndex
                                                      ? const Color(0xFFFF6500)
                                                      : Colors.transparent,
                                                  width: functions.getDateFormat(
                                                              list30DaysDateTimeListItemItem) ==
                                                          _model.dateIndex
                                                      ? 3.0
                                                      : 0.0,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    valueOrDefault<String>(
                                                      valueOrDefault<String>(
                                                        functions.showDateBE(
                                                            list30DaysDateTimeListItemItem
                                                                .toString()),
                                                        '22/01/68',
                                                      ),
                                                      '22/01/68',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color: valueOrDefault<
                                                              Color>(
                                                            functions.containStringInListString(
                                                                    widget.data
                                                                        ?.map((e) => e
                                                                            .date)
                                                                        .toList()
                                                                        .toList(),
                                                                    functions
                                                                        .getDateFormat(
                                                                            list30DaysDateTimeListItemItem))!
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText
                                                                : const Color(
                                                                    0xFF969696),
                                                            const Color(0xFF969696),
                                                          ),
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        if (responsiveVisibility(
                          context: context,
                          phone: false,
                        ))
                          const VerticalDivider(
                            thickness: 2.0,
                          ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: wrapWithModel(
                              model: _model.polyMapWidgetComponentModel,
                              updateCallback: () => safeSetState(() {}),
                              child: const PolyMapWidgetComponentWidget(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ].addToEnd(const SizedBox(height: 12.0)),
            ),
          ),
        ),
      ),
    );
  }
}
