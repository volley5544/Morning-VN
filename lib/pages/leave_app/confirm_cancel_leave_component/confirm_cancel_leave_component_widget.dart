import '/backend/api_requests/api_calls.dart';
import '/components/loading/loading_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'confirm_cancel_leave_component_model.dart';
export 'confirm_cancel_leave_component_model.dart';

class ConfirmCancelLeaveComponentWidget extends StatefulWidget {
  const ConfirmCancelLeaveComponentWidget({
    super.key,
    String? leaveID,
    this.employeeID,
    this.leaveName,
    this.isFromCancelPage,
    required this.leaveStatus,
  }) : leaveID = leaveID ?? '';

  final String leaveID;
  final String? employeeID;
  final String? leaveName;
  final String? isFromCancelPage;
  final String? leaveStatus;

  @override
  State<ConfirmCancelLeaveComponentWidget> createState() =>
      _ConfirmCancelLeaveComponentWidgetState();
}

class _ConfirmCancelLeaveComponentWidgetState
    extends State<ConfirmCancelLeaveComponentWidget> {
  late ConfirmCancelLeaveComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConfirmCancelLeaveComponentModel());

    _model.reasonCancelTextController ??= TextEditingController();
    _model.reasonCancelFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 270.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SelectionArea(
                              child: Text(
                            FFLocalizations.of(context).getText(
                              '3fsz4nym' /* Confirm leave cancellation. */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 20.0,
                                  letterSpacing: 0.0,
                                ),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                controller: _model.reasonCancelTextController,
                                focusNode: _model.reasonCancelFocusNode,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: FFLocalizations.of(context).getText(
                                    '6b6wmwup' /* Specify the reason... */,
                                  ),
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          20.0, 40.0, 24.0, 0.0),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 15.0,
                                      letterSpacing: 0.0,
                                    ),
                                maxLines: 4,
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                validator: _model
                                    .reasonCancelTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              text: FFLocalizations.of(context).getText(
                                'md2xelp4' /* Cancel */,
                              ),
                              options: FFButtonOptions(
                                width: 130.0,
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: const Color(0xFFB32A33),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                elevation: 1.0,
                                borderSide: const BorderSide(
                                  width: 0.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                var shouldSetState = false;
                                if (!(_model.reasonCancelTextController.text !=
                                        '')) {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return WebViewAware(
                                        child: AlertDialog(
                                          content: Text(
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                            enText:
                                                'Please provide a reason for cancellation.',
                                            viText:
                                                'vui lòng điền lý do hủy bỏ',
                                            thText: 'กรุณากรอกเหตุผลที่ยกเลิก',
                                          )),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: const Text('Ok'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  if (shouldSetState) safeSetState(() {});
                                  return;
                                }
                                var confirmDialogResponse =
                                    await showDialog<bool>(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return WebViewAware(
                                              child: AlertDialog(
                                                content: Text(
                                                    FFLocalizations.of(context)
                                                        .getVariableText(
                                                  enText:
                                                      'Do you want to cancel the leave day?',
                                                  viText:
                                                      'Bạn có muốn hủy ngày nghỉ phép không?',
                                                  thText:
                                                      'คุณต้องการยกเลิกวันลาใช่หรือไม่',
                                                )),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            false),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            true),
                                                    child: const Text('Confirm'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ) ??
                                        false;
                                if (!confirmDialogResponse) {
                                  if (shouldSetState) safeSetState(() {});
                                  return;
                                }
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return WebViewAware(
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: const LoadingWidget(),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));

                                _model.leaveListCancelAPIOutput =
                                    await SaveStatusLeaveCall.call(
                                  apiUrl: FFAppState().apiUrlAppState,
                                  token: FFAppState().accessToken,
                                  idList:
                                      functions.converApproveOneSaveFunction(
                                          widget.leaveID),
                                  status: widget.leaveStatus,
                                  reason:
                                      _model.reasonCancelTextController.text,
                                );

                                shouldSetState = true;
                                if ((_model.leaveListCancelAPIOutput
                                            ?.statusCode ??
                                        200) !=
                                    200) {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return WebViewAware(
                                        child: AlertDialog(
                                          content: Text(
                                              'พบข้อผิดพลาด (${SaveStatusLeaveCall.message(
                                            (_model.leaveListCancelAPIOutput
                                                    ?.jsonBody ??
                                                ''),
                                          )})'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: const Text('Ok'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  Navigator.pop(context);
                                  if (shouldSetState) safeSetState(() {});
                                  return;
                                }
                                if (getJsonField(
                                      (_model.leaveListCancelAPIOutput
                                              ?.jsonBody ??
                                          ''),
                                      r'''$.code''',
                                    ).toString() !=
                                    '200') {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return WebViewAware(
                                        child: AlertDialog(
                                          content:
                                              Text(SaveStatusLeaveCall.message(
                                            (_model.leaveListCancelAPIOutput
                                                    ?.jsonBody ??
                                                ''),
                                          )!),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: const Text('Ok'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  Navigator.pop(context);
                                  if (shouldSetState) safeSetState(() {});
                                  return;
                                }
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return WebViewAware(
                                      child: AlertDialog(
                                        content:
                                            Text(SaveStatusLeaveCall.message(
                                          (_model.leaveListCancelAPIOutput
                                                  ?.jsonBody ??
                                              ''),
                                        )!),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: const Text('Ok'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                                Navigator.pop(context);
                                if (widget.isFromCancelPage ==
                                    'leaveShowPage') {
                                  context.goNamed('leaveShowPage');
                                } else {
                                  context.goNamed('ApproveShowPage');
                                }

                                if (shouldSetState) safeSetState(() {});
                              },
                              text: FFLocalizations.of(context).getText(
                                'm27y9t0n' /* OK */,
                              ),
                              options: FFButtonOptions(
                                width: 130.0,
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: const Color(0xFF00968A),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
