import '';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/loading_scene/loading_scene_widget.dart';
import '/components/p_d_f_viewer/p_d_f_viewer_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'leave_page_model.dart';
export 'leave_page_model.dart';

class LeavePageWidget extends StatefulWidget {
  const LeavePageWidget({super.key});

  static String routeName = 'LeavePage';
  static String routePath = '/leavePage';

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
                child: LoadingSceneWidget(),
              ),
            ),
          );
        },
      ).then((value) => safeSetState(() {}));

      _model.getUserProfileAPI = await GetUserProfileAPICall.call(
        apiUrl: FFAppState().apiUrlAppState,
        token: FFAppState().accessToken,
      );

      if ((_model.getUserProfileAPI?.statusCode ?? 200) != 200) {
        if (GetUserProfileAPICall.code(
              (_model.getUserProfileAPI?.jsonBody ?? ''),
            ) ==
            '440') {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return WebViewAware(
                child: AlertDialog(
                  content: Text('${GetUserProfileAPICall.message(
                    (_model.getUserProfileAPI?.jsonBody ?? ''),
                  )}'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext),
                      child: Text('Ok'),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return WebViewAware(
                child: AlertDialog(
                  content: Text('${FFLocalizations.of(context).getVariableText(
                    enText: 'Error encountered(',
                    viText: 'Đã xảy ra lỗi(',
                    thText: 'พบข้อผิดพลาด(',
                  )}${(_model.getUserProfileAPI?.statusCode ?? 200).toString()})'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext),
                      child: Text('Ok'),
                    ),
                  ],
                ),
              );
            },
          );
          Navigator.pop(context);
          return;
        }

        await actions.a22();
        FFAppState().isLogin = false;
        FFAppState().accessToken = '';
        safeSetState(() {});
        FFAppState().username = '';
        FFAppState().employeeID = '';
        safeSetState(() {});
        FFAppState().profilePositionName = '';
        FFAppState().profileStartDate = '';
        FFAppState().branchCode = '';
        safeSetState(() {});
        FFAppState().profileHiredDate = '';
        safeSetState(() {});
        FFAppState().profileBranchName = '';
        FFAppState().profileBranchCode = '';
        safeSetState(() {});
        FFAppState().isInApp = false;
        FFAppState().isLoginNew = false;
        safeSetState(() {});
        Navigator.pop(context);

        context.pushNamed(LoginPageWidget.routeName);

        return;
      }
      _model.leaveListAPIOutput = await GetLeaveListCall.call(
        apiUrl: FFAppState().apiUrlAppState,
        token: FFAppState().accessToken,
      );

      if ((_model.leaveListAPIOutput?.statusCode ?? 200) != 200) {
        if ('${getJsonField(
              (_model.leaveListAPIOutput?.jsonBody ?? ''),
              r'''$.code''',
            ).toString().toString()}' ==
            '440') {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return WebViewAware(
                child: AlertDialog(
                  content: Text('${GetLeaveListCall.message(
                    (_model.leaveListAPIOutput?.jsonBody ?? ''),
                  )}'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext),
                      child: Text('Ok'),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return WebViewAware(
                child: AlertDialog(
                  content: Text('${FFLocalizations.of(context).getVariableText(
                    enText: 'Error encountered(',
                    viText: 'Đã xảy ra lỗi(',
                    thText: 'พบข้อผิดพลาด(',
                  )}${(_model.getUserProfileAPI?.statusCode ?? 200).toString()})'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext),
                      child: Text('Ok'),
                    ),
                  ],
                ),
              );
            },
          );
          Navigator.pop(context);
          return;
        }

        await actions.a22();
        FFAppState().isLogin = false;
        FFAppState().accessToken = '';
        safeSetState(() {});
        FFAppState().username = '';
        FFAppState().employeeID = '';
        safeSetState(() {});
        FFAppState().profilePositionName = '';
        FFAppState().profileStartDate = '';
        FFAppState().branchCode = '';
        safeSetState(() {});
        FFAppState().profileHiredDate = '';
        safeSetState(() {});
        FFAppState().profileBranchName = '';
        FFAppState().profileBranchCode = '';
        safeSetState(() {});
        FFAppState().isInApp = false;
        FFAppState().isLoginNew = false;
        safeSetState(() {});
        Navigator.pop(context);

        context.pushNamed(LoginPageWidget.routeName);

        return;
      }
      if ('${getJsonField(
            (_model.leaveListAPIOutput?.jsonBody ?? ''),
            r'''$.code''',
          ).toString().toString()}' !=
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
                    child: Text('Ok'),
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
                    child: Text('Ok'),
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

    return StreamBuilder<List<HolidayStorageRecord>>(
      stream: queryHolidayStorageRecord(
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<HolidayStorageRecord> leavePageHolidayStorageRecordList =
            snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final leavePageHolidayStorageRecord =
            leavePageHolidayStorageRecordList.isNotEmpty
                ? leavePageHolidayStorageRecordList.first
                : null;

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
                backgroundColor: Color(0xFFFF6500),
                automaticallyImplyLeading: false,
                leading: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    context.pushNamed(DashboardLeavePageWidget.routeName);
                  },
                ),
                title: Text(
                  FFLocalizations.of(context).getText(
                    '96do8hcg' /* Leave List */,
                  ),
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 22.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                actions: [],
                centerTitle: true,
                elevation: 8.0,
              ),
              body: SafeArea(
                top: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (leavePageHolidayStorageRecord?.urlFileHoliday != null &&
                        leavePageHolidayStorageRecord?.urlFileHoliday != '')
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
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
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  child: Padding(
                                    padding: MediaQuery.viewInsetsOf(context),
                                    child: PDFViewerWidget(
                                      pdfUrl: leavePageHolidayStorageRecord!
                                          .urlFileHoliday,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            boxShadow: [
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
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 5.0, 0.0, 5.0),
                                    child: Icon(
                                      Icons.download_rounded,
                                      color: Color(0xFFFF6500),
                                      size: 24.0,
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: SelectionArea(
                                        child: Text(
                                      '${FFLocalizations.of(context).getVariableText(
                                        enText:
                                            'Traditional Holidays for the Year ',
                                        viText:
                                            'Thông báo ngày nghỉ lễ theo truyền thống ',
                                        thText:
                                            'ประกาศวันหยุดตามประเพณี ประจำปี ',
                                      )}${functions.checkYearHolidayCopy(getCurrentTimestamp, FFAppState().appLanguage).toString()}',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                          ),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: Builder(
                          builder: (context) {
                            final listLeaveDataItem =
                                _model.listLeaveData.toList();

                            return ListView.builder(
                              padding: EdgeInsets.fromLTRB(
                                0,
                                0,
                                0,
                                50.0,
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: listLeaveDataItem.length,
                              itemBuilder: (context, listLeaveDataItemIndex) {
                                final listLeaveDataItemItem =
                                    listLeaveDataItem[listLeaveDataItemIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      2.0, 10.0, 0.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        AddLeavePageWidget.routeName,
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
                                          'nextYearSelectableDates':
                                              serializeParam(
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
                                            getJsonField(
                                              listLeaveDataItemItem,
                                              r'''$.previous_year.leave_remain''',
                                            ).toString(),
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.9,
                                      height: 120.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4.0,
                                            color: Color(0x33000000),
                                            offset: Offset(
                                              0.0,
                                              2.0,
                                            ),
                                          )
                                        ],
                                        borderRadius: BorderRadius.only(
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Text(
                                              getJsonField(
                                                listLeaveDataItemItem,
                                                r'''$.name''',
                                              ).toString(),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: FlutterFlowTheme.of(
                                                            context)
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
                                                alignment: AlignmentDirectional(
                                                    0.0, -1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 10.0, 0.0),
                                                  child: Container(
                                                    width: 69.0,
                                                    height: 61.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.network(
                                                        functions
                                                            .stringToImgPath(
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
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 10.0, 0.0, 0.0),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.623,
                                                  height: 70.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
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
                                                            style: FlutterFlowTheme
                                                                    .of(context)
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
                                                            style: FlutterFlowTheme
                                                                    .of(context)
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
                                                            style: FlutterFlowTheme
                                                                    .of(context)
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
                                                            style: FlutterFlowTheme
                                                                    .of(context)
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
                                                            style: FlutterFlowTheme
                                                                    .of(context)
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
                                                            style: FlutterFlowTheme
                                                                    .of(context)
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
      },
    );
  }
}
