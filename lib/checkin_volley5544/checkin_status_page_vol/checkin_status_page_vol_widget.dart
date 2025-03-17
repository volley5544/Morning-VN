import '';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/checkin_volley5544/checkin_data_table_component/checkin_data_table_component_widget.dart';
import '/components/loading/loading_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/checkin/status_compnent/status_compnent_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'checkin_status_page_vol_model.dart';
export 'checkin_status_page_vol_model.dart';

class CheckinStatusPageVolWidget extends StatefulWidget {
  const CheckinStatusPageVolWidget({super.key});

  static String routeName = 'CheckinStatusPageVol';
  static String routePath = '/checkinStatusPageVol';

  @override
  State<CheckinStatusPageVolWidget> createState() =>
      _CheckinStatusPageVolWidgetState();
}

class _CheckinStatusPageVolWidgetState extends State<CheckinStatusPageVolWidget>
    with TickerProviderStateMixin {
  late CheckinStatusPageVolModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckinStatusPageVolModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            alignment: AlignmentDirectional(0.0, 0.0)
                .resolve(Directionality.of(context)),
            child: WebViewAware(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(dialogContext).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Container(
                  height: double.infinity,
                  child: LoadingWidget(),
                ),
              ),
            ),
          );
        },
      );

      _model.workCheckHistoryApiOutput = await WorkCheckHistoryAPICall.call(
        apiUrl: FFAppState().apiUrlAppState,
        token: FFAppState().accessToken,
      );

      if ((_model.workCheckHistoryApiOutput?.statusCode ?? 200) != 200) {
        Navigator.pop(context);
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return WebViewAware(
              child: AlertDialog(
                content: Text(
                    'พบข้อผิดพลาดConnection (${(_model.workCheckHistoryApiOutput?.statusCode ?? 200).toString()})'),
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
        return;
      }
      if ('${WorkCheckHistoryAPICall.code(
            (_model.workCheckHistoryApiOutput?.jsonBody ?? ''),
          )}' !=
          '200') {
        Navigator.pop(context);
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return WebViewAware(
              child: AlertDialog(
                content: Text(
                    'พบข้อผิดพลาดConnection (${WorkCheckHistoryAPICall.code(
                  (_model.workCheckHistoryApiOutput?.jsonBody ?? ''),
                )}) ${WorkCheckHistoryAPICall.message(
                  (_model.workCheckHistoryApiOutput?.jsonBody ?? ''),
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
        return;
      }
      _model.checkinHistoryCurrentMonthData =
          WorkCheckHistoryAPICall.currentMonth(
        (_model.workCheckHistoryApiOutput?.jsonBody ?? ''),
      )!
              .toList()
              .cast<CheckinDataStruct>();
      _model.checkinHistoryLastMonthData = WorkCheckHistoryAPICall.lastMonth(
        (_model.workCheckHistoryApiOutput?.jsonBody ?? ''),
      )!
          .toList()
          .cast<CheckinDataStruct>();
      safeSetState(() {});
      Navigator.pop(context);
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: Color(0xFFFF843D),
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 8.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.arrow_back,
                color: FlutterFlowTheme.of(context).info,
                size: 30.0,
              ),
              onPressed: () async {
                context.safePop();
              },
            ),
            title: Text(
              FFLocalizations.of(context).getText(
                'gldh814t' /* รายการเช็คอิน */,
              ),
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                  ),
            ),
            actions: [
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 8.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.info_outline,
                  color: FlutterFlowTheme.of(context).info,
                  size: 30.0,
                ),
                onPressed: () async {
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    barrierColor: Color(0xBE000000),
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
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * 0.8,
                              child: StatusCompnentWidget(),
                            ),
                          ),
                        ),
                      );
                    },
                  ).then((value) => safeSetState(() {}));
                },
              ),
            ],
            centerTitle: true,
            elevation: 2.0,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment(0.0, 0),
                        child: TabBar(
                          labelColor: FlutterFlowTheme.of(context).primaryText,
                          unselectedLabelColor:
                              FlutterFlowTheme.of(context).secondaryText,
                          labelStyle:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                          unselectedLabelStyle:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                          indicatorColor: FlutterFlowTheme.of(context).primary,
                          tabs: [
                            Tab(
                              text: FFLocalizations.of(context).getText(
                                'fqbu66eb' /* เดือนปัจจุบัน */,
                              ),
                            ),
                            Tab(
                              text: FFLocalizations.of(context).getText(
                                'z88z2cj0' /* เดือนที่แล้ว */,
                              ),
                            ),
                          ],
                          controller: _model.tabBarController,
                          onTap: (i) async {
                            [() async {}, () async {}][i]();
                          },
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _model.tabBarController,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Builder(
                                    builder: (context) {
                                      if ('${WorkCheckHistoryAPICall.code(
                                            (_model.workCheckHistoryApiOutput
                                                    ?.jsonBody ??
                                                ''),
                                          )}' ==
                                          '200') {
                                        return Container(
                                          height: 200.0,
                                          child: wrapWithModel(
                                            model: _model
                                                .checkinDataTableComponentModel1,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            updateOnChange: true,
                                            child:
                                                CheckinDataTableComponentWidget(
                                              checkinHistoryData: _model
                                                  .checkinHistoryCurrentMonthData,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'zuaoy20t' /* No Data  */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Color(0xB357636C),
                                                    fontSize: 24.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ].addToEnd(SizedBox(height: 100.0)),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Builder(
                                    builder: (context) {
                                      if ('${WorkCheckHistoryAPICall.code(
                                            (_model.workCheckHistoryApiOutput
                                                    ?.jsonBody ??
                                                ''),
                                          )}' ==
                                          '200') {
                                        return Container(
                                          height: 200.0,
                                          child: wrapWithModel(
                                            model: _model
                                                .checkinDataTableComponentModel2,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child:
                                                CheckinDataTableComponentWidget(
                                              checkinHistoryData: _model
                                                  .checkinHistoryLastMonthData,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'v4obacrw' /* No Data */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Color(0xB357636C),
                                                    fontSize: 24.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ].addToEnd(SizedBox(height: 100.0)),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
