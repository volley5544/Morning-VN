import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'pin_page_model.dart';
export 'pin_page_model.dart';

class PinPageWidget extends StatefulWidget {
  const PinPageWidget({super.key});

  @override
  State<PinPageWidget> createState() => _PinPageWidgetState();
}

class _PinPageWidgetState extends State<PinPageWidget>
    with TickerProviderStateMixin {
  late PinPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 1100.ms,
          duration: 600.ms,
          begin: 1.0,
          end: 1.0,
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 1100.ms,
          duration: 600.ms,
          begin: const Offset(1.0, 1.0),
          end: const Offset(1.0, 1.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PinPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setAppLanguage(context, 'vi');
      setDarkModeSetting(context, ThemeMode.light);
    });

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
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
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 1.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Color(0xFFFF9E35)],
                stops: [0.0, 1.0],
                begin: AlignmentDirectional(0.0, -1.0),
                end: AlignmentDirectional(0, 1.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  height: 50.0,
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30.0,
                              borderWidth: 1.0,
                              buttonSize: 55.0,
                              icon: Icon(
                                Icons.logout,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 35.0,
                              ),
                              onPressed: () async {
                                context.goNamed('loginPage');
                              },
                            ),
                          ),
                          SelectionArea(
                              child: Text(
                            FFLocalizations.of(context).getText(
                              'fi8l0tpk' /* Logout */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  fontSize: 14.0,
                                ),
                          )),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 30.0,
                              borderWidth: 1.0,
                              buttonSize: 55.0,
                              icon: Icon(
                                Icons.app_blocking_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 33.0,
                              ),
                              onPressed: () {
                                print('IconButton pressed ...');
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 20.0, 0.0),
                            child: SelectionArea(
                                child: Text(
                              FFLocalizations.of(context).getText(
                                'el0vuhmy' /* Clear Cache */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 14.0,
                                  ),
                            )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  decoration: const BoxDecoration(),
                ),
                Image.asset(
                  'assets/images/ArunSawadQR.png',
                  width: 140.0,
                  height: 140.0,
                  fit: BoxFit.fitHeight,
                ).animateOnPageLoad(animationsMap['imageOnPageLoadAnimation']!),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                  child: Container(
                    width: double.infinity,
                    height: 50.0,
                    decoration: const BoxDecoration(),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'ayr2w6ox' /* Welcome to ArunSawad */,
                        ),
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: Colors.black,
                              fontSize: 28.0,
                            ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'm6g8fmaa' /* Enter Pin to Use App */,
                        ),
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: 'Outfit',
                                  color: Colors.black,
                                ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 200.0,
                        decoration: const BoxDecoration(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 32.0, 12.0, 0.0),
                              child: PinCodeTextField(
                                autoDisposeControllers: false,
                                appContext: context,
                                length: 6,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                    ),
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                enableActiveFill: true,
                                autoFocus: false,
                                enablePinAutofill: true,
                                errorTextSpace: 16.0,
                                showCursor: false,
                                cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                obscureText: true,
                                obscuringCharacter: '●',
                                hintCharacter: '*',
                                keyboardType: TextInputType.number,
                                pinTheme: PinTheme(
                                  fieldHeight: 55.0,
                                  fieldWidth: 50.0,
                                  borderWidth: 2.0,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0),
                                    topLeft: Radius.circular(12.0),
                                    topRight: Radius.circular(12.0),
                                  ),
                                  shape: PinCodeFieldShape.box,
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.white,
                                  selectedColor: const Color(0x66FFFFFF),
                                  activeFillColor: Colors.white,
                                  inactiveFillColor: Colors.white,
                                  selectedFillColor: const Color(0x66FFFFFF),
                                ),
                                controller: _model.pinCodeController,
                                onChanged: (_) {},
                                onCompleted: (_) async {
                                  if (_model.pinCodeController!.text !=
                                      FFAppState().pinCode) {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          content: const Text(
                                              'พินไม่ถูกต้อง โปรดลองอีกครั้งหรือใช้การยืนยันตัวตนของมือถือแทน'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: const Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    return;
                                  }
                                  setState(() {
                                    FFAppState().fromPinPage = true;
                                  });

                                  context.goNamed('HomePage');
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: _model.pinCodeControllerValidator
                                    .asValidator(context),
                              ),
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