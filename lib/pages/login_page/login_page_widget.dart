import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/walkthroughs/login.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart'
    show TutorialCoachMark;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key});

  static String routeName = 'loginPage';
  static String routePath = '/loginPage';

  @override
  State<LoginPageWidget> createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget>
    with TickerProviderStateMixin {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().appLanguage != '') {
        if ((FFAppState().appLanguage == 'en') ||
            (FFAppState().appLanguage == 'vi')) {
          if (FFAppState().appLanguage == 'vi') {
            setAppLanguage(context, 'vi');
          } else {
            setAppLanguage(context, 'en');
          }
        } else {
          setAppLanguage(context, 'th');
        }
      } else {
        setAppLanguage(context, 'vi');
      }

      setDarkModeSetting(context, ThemeMode.light);
      _model.getBuildVersion = await actions.getBuildVersion();
      _model.getBuildNumber = await actions.getBuildNumber1();
      if (isAndroid) {
        _model.androidIMEI1st = await actions.a3();
        FFAppState().Uid = _model.androidIMEI1st!;
        safeSetState(() {});
      } else {
        _model.iOSidentifierForVendor1st = await actions.a4();
        FFAppState().Uid = _model.iOSidentifierForVendor1st!;
        safeSetState(() {});
      }
    });

    _model.usernameTextController ??= TextEditingController();
    _model.usernameFocusNode ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
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
          VisibilityEffect(duration: 100.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 100.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 200.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'imageOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 400.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 400.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation5': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 700.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 700.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 800.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 800.0.ms,
            duration: 500.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
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

    return FutureBuilder<List<KeyStorage2Record>>(
      future: queryKeyStorage2RecordOnce(
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
        List<KeyStorage2Record> loginPageKeyStorage2RecordList = snapshot.data!;
        final loginPageKeyStorage2Record =
            loginPageKeyStorage2RecordList.isNotEmpty
                ? loginPageKeyStorage2RecordList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: SafeArea(
              top: true,
              child: FutureBuilder<ApplicationConfigRecord>(
                future: ApplicationConfigRecord.getDocumentOnce(
                    FFAppState().applicationConfigDocRef!),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }

                  final containerApplicationConfigRecord = snapshot.data!;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height * 0.44,
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                height: MediaQuery.sizeOf(context).width * 0.5,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF1E0098),
                                      Color(0xFFFFA071)
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(0.0, -1.0),
                                    end: AlignmentDirectional(0, 1.0),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation1']!),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.7,
                                height: MediaQuery.sizeOf(context).width * 0.7,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF0006B4),
                                      Color(0xFF7479FF)
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(0.0, -1.0),
                                    end: AlignmentDirectional(0, 1.0),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation2']!),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 0.8,
                                height: MediaQuery.sizeOf(context).width * 0.8,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFD63C00),
                                      Color(0xFFFFA071)
                                    ],
                                    stops: [0.0, 1.0],
                                    begin: AlignmentDirectional(0.0, -1.0),
                                    end: AlignmentDirectional(0, 1.0),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                              ).animateOnPageLoad(animationsMap[
                                  'containerOnPageLoadAnimation3']!),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  var confirmDialogResponse =
                                      await showDialog<bool>(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return WebViewAware(
                                                child: AlertDialog(
                                                  content: Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getVariableText(
                                                    enText:
                                                        'Do you want to clear your data?',
                                                    viText:
                                                        'Bạn có muốn xóa dữ liệu của mình không?',
                                                    thText:
                                                        'คุณต้องการล้างข้อมูลใช่หรือไม่',
                                                  )),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              false),
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext,
                                                              true),
                                                      child: Text('Confirm'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ) ??
                                          false;
                                  if (!confirmDialogResponse) {
                                    return;
                                  }
                                  await actions.clearAllAppDataCopy();
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return WebViewAware(
                                        child: AlertDialog(
                                          content: Text(
                                              FFLocalizations.of(context)
                                                  .getVariableText(
                                            enText:
                                                'Clear cache successfully, please close the app and reopen it.',
                                            viText:
                                                'Xóa bộ nhớ đệm thành công, vui lòng đóng ứng dụng và mở lại.',
                                            thText:
                                                'เคลียร์แคชเรียบร้อยกรุณาปิดแอปเปิดใหม่',
                                          )),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0.0),
                                  child: Image.asset(
                                    'assets/images/Logo-Morning_VN_HEAD_2(1)(1).png',
                                    width: 220.0,
                                    height: 200.0,
                                    fit: BoxFit.cover,
                                    alignment: Alignment(0.0, 0.0),
                                  ),
                                ),
                              ).animateOnPageLoad(
                                  animationsMap['imageOnPageLoadAnimation']!),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 10.0),
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.sizeOf(context).height * 0.17,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.0, 0.0, 8.0, 0.0),
                                    child: TextFormField(
                                      controller: _model.usernameTextController,
                                      focusNode: _model.usernameFocusNode,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText:
                                            FFLocalizations.of(context).getText(
                                          '9ac7xmrv' /* username */,
                                        ),
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.person_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      validator: _model
                                          .usernameTextControllerValidator
                                          .asValidator(context),
                                    ).addWalkthrough(
                                      textField0mut7dyi,
                                      _model.loginController,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.0, 0.0, 8.0, 0.0),
                                    child: TextFormField(
                                      controller: _model.passwordTextController,
                                      focusNode: _model.passwordFocusNode,
                                      autofocus: false,
                                      obscureText: !_model.passwordVisibility,
                                      decoration: InputDecoration(
                                        labelText:
                                            FFLocalizations.of(context).getText(
                                          '4m3tr4fm' /* password */,
                                        ),
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        prefixIcon: Icon(
                                          Icons.key,
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () => safeSetState(
                                            () => _model.passwordVisibility =
                                                !_model.passwordVisibility,
                                          ),
                                          focusNode:
                                              FocusNode(skipTraversal: true),
                                          child: Icon(
                                            _model.passwordVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.readexPro(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      validator: _model
                                          .passwordTextControllerValidator
                                          .asValidator(context),
                                    ).addWalkthrough(
                                      textFieldCv11xejx,
                                      _model.loginController,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation4']!),
                      ),
                      FutureBuilder<List<KeyStorage1Record>>(
                        future: queryKeyStorage1RecordOnce(
                          singleRecord: true,
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          List<KeyStorage1Record> columnKeyStorage1RecordList =
                              snapshot.data!;
                          // Return an empty Container when the item does not exist.
                          if (snapshot.data!.isEmpty) {
                            return Container();
                          }
                          final columnKeyStorage1Record =
                              columnKeyStorage1RecordList.isNotEmpty
                                  ? columnKeyStorage1RecordList.first
                                  : null;

                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 40.0, 0.0, 0.0),
                                      child: Container(
                                        width: 190.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFD63C00),
                                              Color(0xFFFFA071)
                                            ],
                                            stops: [0.0, 1.0],
                                            begin:
                                                AlignmentDirectional(0.0, -1.0),
                                            end: AlignmentDirectional(0, 1.0),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    currentUserLocationValue =
                                                        await getCurrentUserLocation(
                                                            defaultLocation:
                                                                LatLng(
                                                                    0.0, 0.0));
                                                    var _shouldSetState = false;
                                                    if (!((String
                                                                appBuildNumber,
                                                            String
                                                                latestBuildNumber) {
                                                      return int.parse(
                                                              appBuildNumber) >=
                                                          int.parse(
                                                              latestBuildNumber);
                                                    }(
                                                        functions.getBuildNumber(
                                                            _model
                                                                .getBuildVersion)!,
                                                        (isiOS
                                                            ? containerApplicationConfigRecord
                                                                .buildNumberIos
                                                            : containerApplicationConfigRecord
                                                                .buildNumber)))) {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return WebViewAware(
                                                            child: AlertDialog(
                                                              content: Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getVariableText(
                                                                enText:
                                                                    'Morning VN\' has a new version available in the store! Please update it in the store before using the application.',
                                                                viText:
                                                                    '\'Morning VN\' Có phiên bản mới trong cửa hàng!. Vui lòng cập nhật tại cửa hàng trước khi sử dụng ứng dụng',
                                                                thText:
                                                                    'Morning VN\' มีเวอร์ชันใหม่! กรุณาอัปเดตก่อนใช้งานแอปพลิเคชัน',
                                                              )),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                      if (isiOS) {
                                                        await launchURL(
                                                            'https://testflight.apple.com/join/GG9nQqJR');
                                                      } else {
                                                        await launchURL(
                                                            'https://play.google.com/store/apps/details?id=com.srisawad.morningvn');
                                                      }

                                                      await actions
                                                          .terminateAppAction();
                                                      if (_shouldSetState)
                                                        safeSetState(() {});
                                                      return;
                                                    }
                                                    if (_model.usernameTextController
                                                                .text !=
                                                            '') {
                                                      if (!(_model.passwordTextController
                                                                  .text !=
                                                              '')) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getVariableText(
                                                                enText:
                                                                    'Please enter your password',
                                                                viText:
                                                                    'Xin vui lòng nhập mật khẩu',
                                                                thText:
                                                                    'กรุณากรอกรหัสผ่าน',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    3000),
                                                            backgroundColor:
                                                                Color(
                                                                    0xB3090F13),
                                                          ),
                                                        );
                                                        if (_shouldSetState)
                                                          safeSetState(() {});
                                                        return;
                                                      }
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getVariableText(
                                                              enText:
                                                                  'Please enter your username',
                                                              viText:
                                                                  'Vui lòng nhập tên người dùng',
                                                              thText:
                                                                  'กรุณากรอกชื่อผู้ใช้งาน',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .readexPro(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  3000),
                                                          backgroundColor:
                                                              Color(0xB3090F13),
                                                        ),
                                                      );
                                                      if (_shouldSetState)
                                                        safeSetState(() {});
                                                      return;
                                                    }

                                                    await requestPermission(
                                                        locationPermission);
                                                    if (await getPermissionStatus(
                                                        locationPermission)) {
                                                      _model.backgroundLocationCheck =
                                                          await actions
                                                              .backgroundLocationCheck();
                                                      _shouldSetState = true;
                                                      if (!_model
                                                          .backgroundLocationCheck!) {
                                                        if (isiOS) {
                                                          _model.backgroundLocationCheck2 =
                                                              await actions
                                                                  .backgroundLocationCheck();
                                                          _shouldSetState =
                                                              true;
                                                        } else {
                                                          await showDialog(
                                                            context: context,
                                                            builder:
                                                                (alertDialogContext) {
                                                              return WebViewAware(
                                                                child:
                                                                    AlertDialog(
                                                                  content: Text(
                                                                      'Để theo dõi công việc của bạn, Morning FM cần có quyền vị trí nền. Vui lòng chọn \"Cho phép mọi lúc\" trong cài đặt quyền ứng dụng.'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(alertDialogContext),
                                                                      child: Text(
                                                                          'Mở Cài Đặt'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );
                                                          if (_shouldSetState)
                                                            safeSetState(() {});
                                                          return;
                                                        }

                                                        if (!_model
                                                            .backgroundLocationCheck2!) {
                                                          await showDialog(
                                                            context: context,
                                                            builder:
                                                                (alertDialogContext) {
                                                              return WebViewAware(
                                                                child:
                                                                    AlertDialog(
                                                                  content: Text(
                                                                      'Để theo dõi công việc của bạn, Morning FM cần có quyền vị trí nền. Vui lòng chọn \"Cho phép mọi lúc\" trong cài đặt quyền ứng dụng.'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.pop(alertDialogContext),
                                                                      child: Text(
                                                                          'Mở Cài Đặt'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );
                                                          if (_shouldSetState)
                                                            safeSetState(() {});
                                                          return;
                                                        }
                                                      }
                                                    } else {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return WebViewAware(
                                                            child: AlertDialog(
                                                              content: Text(
                                                                  'Vui lòng cho phép truy cập vị trí của bạn để theo dõi công việc của bạn'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }

                                                    _model.permissionRequestOutput =
                                                        await actions
                                                            .backgroundLocationPermission();
                                                    _shouldSetState = true;
                                                    if (!_model
                                                        .permissionRequestOutput!) {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return WebViewAware(
                                                            child: AlertDialog(
                                                              content: Text(
                                                                  'Vui lòng chọn \"Cho phép mọi lúc\" quyền truy cập vào vị trí của bạn để theo dõi công việc của bạn'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                      if (_shouldSetState)
                                                        safeSetState(() {});
                                                      return;
                                                    }
                                                    _model.checkGpsEnable =
                                                        await actions
                                                            .checkGpsServiceEnable();
                                                    _shouldSetState = true;
                                                    if (!_model
                                                        .checkGpsEnable!) {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return WebViewAware(
                                                            child: AlertDialog(
                                                              content: Text(
                                                                  'Vui lòng bật GPS trước khi tiếp tục'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                      await actions
                                                          .enableGpsService();
                                                      _model.checkGpsEnable2 =
                                                          await actions
                                                              .checkGpsServiceEnable();
                                                      _shouldSetState = true;
                                                      if (!_model
                                                          .checkGpsEnable2!) {
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return WebViewAware(
                                                              child:
                                                                  AlertDialog(
                                                                content: Text(
                                                                    'Vui lòng bật GPS trước khi tiếp tục'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext),
                                                                    child: Text(
                                                                        'Ok'),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                        if (_shouldSetState)
                                                          safeSetState(() {});
                                                        return;
                                                      }
                                                    }
                                                    FFAppState()
                                                        .apiUrlAppState = FFAppState()
                                                            .isProduction
                                                        ? columnKeyStorage1Record!
                                                            .apiUrl
                                                        : loginPageKeyStorage2Record!
                                                            .apiUrl;
                                                    safeSetState(() {});
                                                    _model.authAPIOutput =
                                                        await AuthenAPICall
                                                            .call(
                                                      username: _model
                                                          .usernameTextController
                                                          .text,
                                                      password: _model
                                                          .passwordTextController
                                                          .text,
                                                      apiUrl: FFAppState()
                                                          .apiUrlAppState,
                                                      projectName:
                                                          'SSW_ARUNSAWAD_VN',
                                                      uid: FFAppState().Uid,
                                                    );

                                                    _shouldSetState = true;
                                                    if ((_model.authAPIOutput
                                                                ?.statusCode ??
                                                            200) ==
                                                        200) {
                                                    } else {
                                                      if ((_model.authAPIOutput
                                                                  ?.statusCode ??
                                                              200) ==
                                                          401) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getVariableText(
                                                                enText:
                                                                    'User not found, or Username or Password is incorrect.',
                                                                viText:
                                                                    'Không tìm thấy người dùng hoặc Tên đăng nhập hoặc Mật khẩu không chính xác.',
                                                                thText:
                                                                    'ไม่พบผู้ใช้งาน Username หรือ Password ไม่ถูกต้อง',
                                                              ),
                                                              style: TextStyle(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                              ),
                                                            ),
                                                            duration: Duration(
                                                                milliseconds:
                                                                    4000),
                                                            backgroundColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                          ),
                                                        );
                                                        if (_shouldSetState)
                                                          safeSetState(() {});
                                                        return;
                                                      }
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return WebViewAware(
                                                            child: AlertDialog(
                                                              content: Text(
                                                                  '${'${FFLocalizations.of(context).getVariableText(
                                                                enText:
                                                                    'An error has occurred',
                                                                viText:
                                                                    'Đã xảy ra lỗi',
                                                                thText:
                                                                    'พบข้อผิดพลาด',
                                                              )} ('}${(_model.authAPIOutput?.statusCode ?? 200).toString()})'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                      if (_shouldSetState)
                                                        safeSetState(() {});
                                                      return;
                                                    }

                                                    if ('${getJsonField(
                                                          (_model.authAPIOutput
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.status''',
                                                        ).toString()}' ==
                                                        '200') {
                                                    } else {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return WebViewAware(
                                                            child: AlertDialog(
                                                              content: Text(
                                                                  '${AuthenAPICall.messagelayer1(
                                                                (_model.authAPIOutput
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              )}'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                      if (_shouldSetState)
                                                        safeSetState(() {});
                                                      return;
                                                    }

                                                    FFAppState().isLogin = true;
                                                    FFAppState().username =
                                                        '${AuthenAPICall.nameth(
                                                      (_model.authAPIOutput
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}';
                                                    FFAppState().employeeID =
                                                        '${AuthenAPICall.employeeid(
                                                      (_model.authAPIOutput
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}';
                                                    FFAppState()
                                                            .profilePositionName =
                                                        '${AuthenAPICall.position(
                                                      (_model.authAPIOutput
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}';
                                                    FFAppState()
                                                            .profileStartDate =
                                                        '${AuthenAPICall.startdate(
                                                      (_model.authAPIOutput
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}';
                                                    FFAppState().accessToken =
                                                        '${AuthenAPICall.accesstoken(
                                                      (_model.authAPIOutput
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}';
                                                    FFAppState().branchCode =
                                                        '${AuthenAPICall.branchcode(
                                                      (_model.authAPIOutput
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}';
                                                    safeSetState(() {});
                                                    if (isAndroid) {
                                                    } else {
                                                      if (!isiOS) {
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return WebViewAware(
                                                              child:
                                                                  AlertDialog(
                                                                content: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getVariableText(
                                                                  enText:
                                                                      'This application is only available for use on Android or iOS.',
                                                                  viText:
                                                                      'Ứng dụng này chỉ được sử dụng trên Android hoặc iOS',
                                                                  thText:
                                                                      'แอพพลิเคชั่นนี้ ให้ใช้ได้แค่ใน Android หรือ Ios เท่านั้น',
                                                                )),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext),
                                                                    child: Text(
                                                                        'Ok'),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        );
                                                        if (_shouldSetState)
                                                          safeSetState(() {});
                                                        return;
                                                      }
                                                    }

                                                    _model.getUserProfile =
                                                        await GetUserProfileAPICall
                                                            .call(
                                                      apiUrl: FFAppState()
                                                          .apiUrlAppState,
                                                      token: FFAppState()
                                                          .accessToken,
                                                    );

                                                    _shouldSetState = true;
                                                    if ((_model.getUserProfile
                                                                ?.statusCode ??
                                                            200) !=
                                                        200) {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return WebViewAware(
                                                            child: AlertDialog(
                                                              content: Text(
                                                                  '${FFLocalizations.of(context).getVariableText(
                                                                enText:
                                                                    'Error encountered(',
                                                                viText:
                                                                    'Đã xảy ra lỗi(',
                                                                thText:
                                                                    'พบข้อผิดพลาด(',
                                                              )}${(_model.getUserProfile?.statusCode ?? 200).toString()})'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                      if (_shouldSetState)
                                                        safeSetState(() {});
                                                      return;
                                                    }
                                                    if ('${getJsonField(
                                                          (_model.getUserProfile
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.status''',
                                                        ).toString()}' !=
                                                        '200') {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return WebViewAware(
                                                            child: AlertDialog(
                                                              content: Text(
                                                                  GetUserProfileAPICall
                                                                      .message(
                                                                (_model.getUserProfile
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              )!),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () =>
                                                                      Navigator.pop(
                                                                          alertDialogContext),
                                                                  child: Text(
                                                                      'Ok'),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                      if (_shouldSetState)
                                                        safeSetState(() {});
                                                      return;
                                                    }
                                                    FFAppState()
                                                            .profilePositionName =
                                                        '${'${GetUserProfileAPICall.profliePositionName(
                                                      (_model.getUserProfile
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}'}';
                                                    FFAppState()
                                                            .ProfilePhoneNumber =
                                                        '${'${GetUserProfileAPICall.profilePhoneNumber(
                                                      (_model.getUserProfile
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}'}';
                                                    FFAppState()
                                                            .profileBranchName =
                                                        '${'${GetUserProfileAPICall.profileBranchName(
                                                      (_model.getUserProfile
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}'}';
                                                    FFAppState()
                                                            .profileBranchCode =
                                                        '${GetUserProfileAPICall.profileBranchCode(
                                                      (_model.getUserProfile
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}';
                                                    safeSetState(() {});
                                                    FFAppState()
                                                            .profileHiredDate =
                                                        '${'${GetUserProfileAPICall.profileHiredDate(
                                                      (_model.getUserProfile
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}'}';
                                                    FFAppState()
                                                            .profileServiceDurationYY =
                                                        '${GetUserProfileAPICall.profileServiceDurationYY(
                                                      (_model.getUserProfile
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}';
                                                    FFAppState()
                                                            .profileServiceDurationMM =
                                                        '${GetUserProfileAPICall.profileServiceDurationMM(
                                                      (_model.getUserProfile
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}';
                                                    FFAppState()
                                                            .profileServiceDurationDD =
                                                        '${GetUserProfileAPICall.profileServiceDurationDD(
                                                      (_model.getUserProfile
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}';
                                                    FFAppState().roleName =
                                                        '${'${GetUserProfileAPICall.rolename(
                                                      (_model.getUserProfile
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}'}';
                                                    FFAppState().profileLevel =
                                                        '${GetUserProfileAPICall.gpslevel(
                                                      (_model.getUserProfile
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}';
                                                    safeSetState(() {});
                                                    FFAppState().isLogin = true;
                                                    safeSetState(() {});
                                                    _model.customFirebaseAuthen =
                                                        await actions
                                                            .checkFirebase(
                                                      '${_model.usernameTextController.text}@srisawadvn.com',
                                                    );
                                                    _shouldSetState = true;
                                                    if (_model
                                                            .customFirebaseAuthen ==
                                                        'Create') {
                                                      _model.userUID =
                                                          await actions
                                                              .checkUserFirebase();
                                                      _shouldSetState = true;

                                                      var userCustomRecordReference =
                                                          UserCustomRecord
                                                              .collection
                                                              .doc();
                                                      await userCustomRecordReference
                                                          .set(
                                                              createUserCustomRecordData(
                                                        email:
                                                            '${_model.usernameTextController.text}@VN.com',
                                                        uid: _model.userUID,
                                                        createdDate:
                                                            getCurrentTimestamp,
                                                        eployeeId: _model
                                                            .usernameTextController
                                                            .text,
                                                        profileImg:
                                                            'https://firebasestorage.googleapis.com/v0/b/arunsawad-vn-application.appspot.com/o/blank-profile-picture-gc19a78ed8_1280.png?alt=media&token=6c3c82ce-a6ae-4b2e-b264-303820c6b65e',
                                                      ));
                                                      _model.createdUserCustom =
                                                          UserCustomRecord
                                                              .getDocumentFromData(
                                                                  createUserCustomRecordData(
                                                                    email:
                                                                        '${_model.usernameTextController.text}@VN.com',
                                                                    uid: _model
                                                                        .userUID,
                                                                    createdDate:
                                                                        getCurrentTimestamp,
                                                                    eployeeId: _model
                                                                        .usernameTextController
                                                                        .text,
                                                                    profileImg:
                                                                        'https://firebasestorage.googleapis.com/v0/b/arunsawad-vn-application.appspot.com/o/blank-profile-picture-gc19a78ed8_1280.png?alt=media&token=6c3c82ce-a6ae-4b2e-b264-303820c6b65e',
                                                                  ),
                                                                  userCustomRecordReference);
                                                      _shouldSetState = true;
                                                    }

                                                    context.goNamed(
                                                        SetPinPageWidget
                                                            .routeName);

                                                    if (_shouldSetState)
                                                      safeSetState(() {});
                                                  },
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    '3h1qkrxb' /* LOGIN */,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: Color(0x00FFFFFF),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .fontStyle,
                                                          ),
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                        ),
                                                    elevation: 2.0,
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ).addWalkthrough(
                                                  buttonQvk3d3t3,
                                                  _model.loginController,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).animateOnPageLoad(animationsMap[
                                          'containerOnPageLoadAnimation5']!),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'f6exf55c' /* Copyright ©2024.  Srisawad Cor... */,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: Color(0xFF607D8B),
                                  fontSize: 13.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ).animateOnPageLoad(
                              animationsMap['textOnPageLoadAnimation']!),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  TutorialCoachMark createPageWalkthrough(BuildContext context) =>
      TutorialCoachMark(
        targets: createWalkthroughTargets(context),
        onFinish: () async {
          safeSetState(() => _model.loginController = null);
        },
        onSkip: () {
          return true;
        },
      );
}
