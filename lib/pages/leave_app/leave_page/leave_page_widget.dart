import '/backend/api_requests/api_calls.dart';
import '/components/p_d_f_viewer/p_d_f_viewer_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/checkin/loading_scene/loading_scene_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'leave_page_model.dart';
export 'leave_page_model.dart';

class LeavePageWidget extends StatefulWidget {
  const LeavePageWidget({super.key});

  @override
  State<LeavePageWidget> createState() => _LeavePageWidgetState();
}

class _LeavePageWidgetState extends State<LeavePageWidget> {
  late LeavePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LeavePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
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
                child: const LoadingSceneWidget(),
              ),
            ),
          );
        },
      ).then((value) => safeSetState(() {}));

      _model.leaveListAPIOutput = await GetLeaveListCall.call(
        apiUrl: FFAppState().apiUrlAppState,
        token: FFAppState().accessToken,
      );

      if ((_model.leaveListAPIOutput?.statusCode ?? 200) != 200) {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return WebViewAware(
              child: AlertDialog(
                content: Text(GetLeaveListCall.message(
                  (_model.leaveListAPIOutput?.jsonBody ?? ''),
                )!),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: const Text('Ok'),
                  ),
                ],
              ),
            );
          },
        );
        Navigator.pop(context);
        return;
      }
      if (getJsonField(
            (_model.leaveListAPIOutput?.jsonBody ?? ''),
            r'''$.code''',
          ).toString().toString() !=
          '200') {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return WebViewAware(
              child: AlertDialog(
                content: Text(getJsonField(
                  (_model.leaveListAPIOutput?.jsonBody ?? ''),
                  r'''$.message''',
                ).toString().toString()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: const Text('Ok'),
                  ),
                ],
              ),
            );
          },
        );
        Navigator.pop(context);
        return;
      }
      if (GetLeaveListCall.total(
            (_model.leaveListAPIOutput?.jsonBody ?? ''),
          )! <=
          0) {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return WebViewAware(
              child: AlertDialog(
                content: Text(FFLocalizations.of(context).getVariableText(
                  enText: 'No leave records.',
                  viText: 'không có danh sách nghỉ phép',
                  thText: 'ไม่มีรายการลา',
                )),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: const Text('Ok'),
                  ),
                ],
              ),
            );
          },
        );
        Navigator.pop(context);
        return;
      }
      _model.listLeaveData = getJsonField(
        (_model.leaveListAPIOutput?.jsonBody ?? ''),
        r'''$.results.leave_list[*]''',
        true,
      )!
          .toList()
          .cast<dynamic>();
      safeSetState(() {});
      Navigator.pop(context);
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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: const Color(0xFFFF6500),
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () async {
                context.pushNamed('DashboardLeavePage');
              },
            ),
            title: Text(
              FFLocalizations.of(context).getText(
                '96do8hcg' /* รายการลา */,
              ),
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 30.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            actions: const [],
            centerTitle: true,
            elevation: 8.0,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    if (functions.checkYearHoliday(getCurrentTimestamp)!) {
                      await showModalBottomSheet(
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
                                child: const PDFViewerWidget(
                                  pdfUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/flut-flow-test.appspot.com/o/AnnouncementPDF%2F%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B8%81%E0%B8%B2%E0%B8%A8%E0%B8%A7%E0%B8%B1%E0%B8%99%E0%B8%AB%E0%B8%A2%E0%B8%B8%E0%B8%94%E0%B8%95%E0%B8%B2%E0%B8%A1%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B9%80%E0%B8%9E%E0%B8%93%E0%B8%B5%20%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B8%88%E0%B8%B3%E0%B8%9B%E0%B8%B52568.pdf?alt=media&token=8bd45d24-e555-4e59-9ebe-1eb0ac4ebfc5',
                                ),
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    } else {
                      await showModalBottomSheet(
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
                                child: const PDFViewerWidget(
                                  pdfUrl:
                                      'https://firebasestorage.googleapis.com/v0/b/flut-flow-test.appspot.com/o/AnnouncementPDF%2F%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B8%81%E0%B8%B2%E0%B8%A8%E0%B8%A7%E0%B8%B1%E0%B8%99%E0%B8%AB%E0%B8%A2%E0%B8%B8%E0%B8%94%E0%B8%95%E0%B8%B2%E0%B8%A1%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B9%80%E0%B8%9E%E0%B8%93%E0%B8%B5%20%E0%B8%9B%E0%B8%A3%E0%B8%B0%E0%B8%88%E0%B8%B3%E0%B8%9B%E0%B8%B5%202567.pdf?alt=media&token=15daf745-a5c8-477f-aed0-acebb73d8cee',
                                ),
                              ),
                            ),
                          );
                        },
                      ).then((value) => safeSetState(() {}));
                    }
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(
                            0.0,
                            2.0,
                          ),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.download_rounded,
                              color: Color(0xFFFF6500),
                              size: 24.0,
                            ),
                            SelectionArea(
                                child: Text(
                              functions.checkYearHoliday(getCurrentTimestamp)!
                                  ? FFLocalizations.of(context).getVariableText(
                                      enText:
                                          'Announcement of Traditional Holidays for the Year 2025',
                                      viText:
                                          'Thông báo ngày nghỉ lễ truyền thống năm 2568',
                                      thText:
                                          'ประกาศวันหยุดตามประเพณี ประจำปี  2568',
                                    )
                                  : FFLocalizations.of(context).getVariableText(
                                      enText:
                                          'Announcement of Traditional Holidays for the Year 2024',
                                      viText:
                                          'Thông báo ngày nghỉ lễ truyền thống năm 2567',
                                      thText:
                                          'ประกาศวันหยุดตามประเพณี ประจำปี  2567',
                                    ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                    child: Builder(
                      builder: (context) {
                        final listLeaveDataItem = _model.listLeaveData.toList();

                        return ListView.builder(
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            0,
                            0,
                            60.0,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listLeaveDataItem.length,
                          itemBuilder: (context, listLeaveDataItemIndex) {
                            final listLeaveDataItemItem =
                                listLeaveDataItem[listLeaveDataItemIndex];
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  2.0, 10.0, 0.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'AddLeavePage',
                                    queryParameters: {
                                      'leaveName': serializeParam(
                                        getJsonField(
                                          listLeaveDataItemItem,
                                          r'''$.name''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'leaveType': serializeParam(
                                        getJsonField(
                                          listLeaveDataItemItem,
                                          r'''$.leave_type''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'startDateLeave': serializeParam(
                                        getJsonField(
                                          listLeaveDataItemItem,
                                          r'''$.start_date''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'endDateLeave': serializeParam(
                                        getJsonField(
                                          listLeaveDataItemItem,
                                          r'''$.end_date''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'currentYear': serializeParam(
                                        getJsonField(
                                          listLeaveDataItemItem,
                                          r'''$.current_year.year''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'nextYear': serializeParam(
                                        getJsonField(
                                          listLeaveDataItemItem,
                                          r'''$.next_year.year''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'currentYearSelectableDates':
                                          serializeParam(
                                        getJsonField(
                                          listLeaveDataItemItem,
                                          r'''$.current_year.leave_remain''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'nextYearSelectableDates': serializeParam(
                                        getJsonField(
                                          listLeaveDataItemItem,
                                          r'''$.next_year.leave_remain''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'leavePeriods': serializeParam(
                                        getJsonField(
                                          listLeaveDataItemItem,
                                          r'''$.leave_period''',
                                          true,
                                        ),
                                        ParamType.JSON,
                                        isList: true,
                                      ),
                                      'previousYear': serializeParam(
                                        getJsonField(
                                          listLeaveDataItemItem,
                                          r'''$.previous_year.year''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'previousYearSelectableDates':
                                          serializeParam(
                                        '',
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: Color(0x33000000),
                                        offset: Offset(
                                          0.0,
                                          2.0,
                                        ),
                                      )
                                    ],
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(0.0),
                                      topLeft: Radius.circular(0.0),
                                      topRight: Radius.circular(0.0),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 0.0),
                                        child: Text(
                                          getJsonField(
                                            listLeaveDataItemItem,
                                            r'''$.name''',
                                          ).toString(),
                                          style: FlutterFlowTheme.of(context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w900,
                                              ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(0.0, -1.0),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 10.0, 0.0),
                                              child: Container(
                                                width: 69.0,
                                                height: 61.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.network(
                                                    functions.stringToImgPath(
                                                        getJsonField(
                                                      listLeaveDataItemItem,
                                                      r'''$.icon''',
                                                    ).toString())!,
                                                    width: 200.0,
                                                    height: 200.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.623,
                                              height: 70.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'hvcoykrb' /* All */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                      Text(
                                                        getJsonField(
                                                          listLeaveDataItemItem,
                                                          r'''$.current_year.leave_limit''',
                                                        ).toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'yofhaew7' /* Used */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                      Text(
                                                        getJsonField(
                                                          listLeaveDataItemItem,
                                                          r'''$.current_year.leave_use''',
                                                        ).toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'xstbiiqr' /* Remaining */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                      Text(
                                                        getJsonField(
                                                          listLeaveDataItemItem,
                                                          r'''$.current_year.leave_remain''',
                                                        ).toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
