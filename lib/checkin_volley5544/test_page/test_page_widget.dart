import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/loading/loading_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'test_page_model.dart';
export 'test_page_model.dart';

class TestPageWidget extends StatefulWidget {
  const TestPageWidget({super.key});

  static String routeName = 'TestPage';
  static String routePath = '/testPage';

  @override
  State<TestPageWidget> createState() => _TestPageWidgetState();
}

class _TestPageWidgetState extends State<TestPageWidget> {
  late TestPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TestPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setAppLanguage(context, 'en');
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
                child: LoadingWidget(),
              ),
            ),
          );
        },
      );

      _model.apiResult235 = await GetLeaveListCall.call(
        apiUrl: FFAppState().apiUrlAppState,
        token: FFAppState().accessToken,
      );

      _model.holidayDataPage = GetLeaveListCall.listcalendar(
        (_model.apiResult235?.jsonBody ?? ''),
      )!
          .toList()
          .cast<CalendarDataStruct>();
      _model.currentYearDataPage = GetLeaveListCall.currentyear(
        (_model.apiResult235?.jsonBody ?? ''),
      )!
          .toList()
          .cast<CurrentYearStruct>();
      _model.nextYearDataPage = GetLeaveListCall.nextyear(
        (_model.apiResult235?.jsonBody ?? ''),
      )!
          .toList()
          .cast<CurrentYearStruct>();
      _model.listLeaveData = GetLeaveListCall.leavelist(
        (_model.apiResult235?.jsonBody ?? ''),
      )!
          .toList()
          .cast<dynamic>();
      safeSetState(() {});
      Navigator.pop(context);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
      builder: (context) => Title(
          title: 'TestPage',
          color: FlutterFlowTheme.of(context).primary.withAlpha(0XFF),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: PopScope(
              canPop: false,
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                appBar: AppBar(
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  automaticallyImplyLeading: false,
                  title: Text(
                    FFLocalizations.of(context).getText(
                      'twf4yttl' /* Page Title */,
                    ),
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          font: GoogleFonts.outfit(
                            fontWeight: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .fontStyle,
                          ),
                          color: Colors.white,
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                        ),
                  ),
                  actions: [],
                  centerTitle: false,
                  elevation: 2.0,
                ),
                body: SafeArea(
                  top: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 400.0,
                        decoration: BoxDecoration(),
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: custom_widgets.LeaveCalendarWidget(
                            width: double.infinity,
                            height: double.infinity,
                            todayColor: Color(0xFFFF843D),
                            selectedColor: Color(0xFFFF843D),
                            selectedTextColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            holidaysList: _model.holidayDataPage
                                .map((e) => e.date)
                                .toList(),
                            currentDate: getCurrentTimestamp,
                            currentYear:
                                _model.currentYearDataPage.lastOrNull?.year,
                            nextYear: _model.nextYearDataPage.lastOrNull?.year,
                            currentYearSelectableDates: _model
                                .currentYearDataPage.lastOrNull!.leaveRemain,
                            nextYearSelectableDates:
                                _model.nextYearDataPage.lastOrNull!.leaveRemain,
                            startdate: getJsonField(
                              _model.listLeaveData.lastOrNull,
                              r'''$.start_date''',
                            ).toString(),
                            enddate: getJsonField(
                              _model.listLeaveData.lastOrNull,
                              r'''$.end_date''',
                            ).toString(),
                            previousYear: '1',
                            previousYearSelectableDates: '3',
                          ),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return WebViewAware(
                                child: AlertDialog(
                                  title: Text(
                                      'จำนวนวันลา ${FFAppState().selectedDatesList.length.toString()} วัน'),
                                  content: Text(functions.returnAllValueInList(
                                      FFAppState()
                                          .selectedDatesList
                                          .toList())!),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        text: FFLocalizations.of(context).getText(
                          'lwgr5i7x' /* print date */,
                        ),
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.readexPro(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
