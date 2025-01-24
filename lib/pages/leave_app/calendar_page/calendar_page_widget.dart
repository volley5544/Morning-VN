import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/loading/loading_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'calendar_page_model.dart';
export 'calendar_page_model.dart';

class CalendarPageWidget extends StatefulWidget {
  const CalendarPageWidget({
    super.key,
    required this.leaveType,
  });

  final String? leaveType;

  @override
  State<CalendarPageWidget> createState() => _CalendarPageWidgetState();
}

class _CalendarPageWidgetState extends State<CalendarPageWidget> {
  late CalendarPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarPageModel());

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
            alignment: const AlignmentDirectional(0.0, 0.0)
                .resolve(Directionality.of(context)),
            child: WebViewAware(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(dialogContext).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: const LoadingWidget(),
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
              onPressed: () async {},
            ),
            title: Text(
              FFLocalizations.of(context).getText(
                '3s9c8puw' /* เลือกวันที่ต้องการลา */,
              ),
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Outfit',
                    color: FlutterFlowTheme.of(context).secondaryBackground,
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
                Container(
                  width: double.infinity,
                  height: 400.0,
                  decoration: const BoxDecoration(),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: custom_widgets.LeaveCalendarWidget(
                      width: double.infinity,
                      height: double.infinity,
                      todayColor: const Color(0xFFFF843D),
                      selectedColor: const Color(0xFFFF843D),
                      selectedTextColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      holidaysList:
                          _model.holidayDataPage.map((e) => e.date).toList(),
                      currentDate: getCurrentTimestamp,
                      currentYear: _model.currentYearDataPage.lastOrNull?.year,
                      nextYear: _model.nextYearDataPage.lastOrNull?.year,
                      currentYearSelectableDates:
                          _model.currentYearDataPage.lastOrNull!.leaveRemain,
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
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
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
                                    FFAppState().selectedDatesList.toList())!),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: const Text('Ok'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      text: FFLocalizations.of(context).getText(
                        'sxfn8fc6' /* print date */,
                      ),
                      options: FFButtonOptions(
                        height: 40.0,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(1.0, 1.0),
                      child: FFButtonWidget(
                        onPressed: () async {},
                        text: FFLocalizations.of(context).getText(
                          'ddp4swob' /* ตกลง */,
                        ),
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
