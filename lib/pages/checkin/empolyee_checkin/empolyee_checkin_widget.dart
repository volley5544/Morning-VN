import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/loading/loading_widget.dart';
import '/components/loading_scene/loading_scene_widget.dart';
import '/components/select_language_component_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/checkin/serch_branch_component_checkin/serch_branch_component_checkin_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'empolyee_checkin_model.dart';
export 'empolyee_checkin_model.dart';

class EmpolyeeCheckinWidget extends StatefulWidget {
  const EmpolyeeCheckinWidget({super.key});

  @override
  State<EmpolyeeCheckinWidget> createState() => _EmpolyeeCheckinWidgetState();
}

class _EmpolyeeCheckinWidgetState extends State<EmpolyeeCheckinWidget> {
  late EmpolyeeCheckinModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmpolyeeCheckinModel());

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

      FFAppState().imgURLTemp = '';
      FFAppState().update(() {});
      _model.getLocationApiOutput = await GetLocationCall.call(
        apiUrl: FFAppState().apiUrlAppState,
        token: FFAppState().accessToken,
      );

      if ((_model.getLocationApiOutput?.statusCode ?? 200) != 200) {
        if (GetLocationCall.code(
              (_model.getLocationApiOutput?.jsonBody ?? ''),
            ) ==
            '440') {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return WebViewAware(
                child: AlertDialog(
                  content: Text('${GetLocationCall.message(
                    (_model.getLocationApiOutput?.jsonBody ?? ''),
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
                    enText: 'Connection Error Found (',
                    viText: 'Lỗi kết nối (',
                    thText: 'พบข้อผิดพลาด Connection (',
                  )}${(_model.getLocationApiOutput?.statusCode ?? 200).toString()})'),
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

        context.pushNamed('loginPage');

        return;
      }
      if ('${GetLocationCall.code(
            (_model.getLocationApiOutput?.jsonBody ?? ''),
          )}' !=
          '200') {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return WebViewAware(
              child: AlertDialog(
                content: Text('${GetLocationCall.message(
                  (_model.getLocationApiOutput?.jsonBody ?? ''),
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
        Navigator.pop(context);
        return;
      }
      _model.listLocationData = GetLocationCall.listLocatio(
        (_model.getLocationApiOutput?.jsonBody ?? ''),
      )!
          .toList()
          .cast<ListLocationCheckInStruct>();
      safeSetState(() {});
      Navigator.pop(context);
    });

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => safeSetState(() => currentUserLocationValue = loc));
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
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
                context.pop();
              },
            ),
            title: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  barrierColor: Color(0xC0000000),
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
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.5,
                            child: SelectLanguageComponentWidget(),
                          ),
                        ),
                      ),
                    );
                  },
                ).then((value) => safeSetState(() {}));
              },
              child: Text(
                FFLocalizations.of(context).getText(
                  'dib97xps' /* Clock in/Clock out */,
                ),
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 22.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    var _shouldSetState = false;
                    HapticFeedback.mediumImpact();
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
                              child: Container(
                                height: double.infinity,
                                child: LoadingSceneWidget(),
                              ),
                            ),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));

                    final selectedMedia = await selectMedia(
                      imageQuality: 30,
                      multiImage: false,
                    );
                    if (selectedMedia != null &&
                        selectedMedia.every((m) =>
                            validateFileFormat(m.storagePath, context))) {
                      safeSetState(() => _model.isDataUploading1 = true);
                      var selectedUploadedFiles = <FFUploadedFile>[];

                      try {
                        selectedUploadedFiles = selectedMedia
                            .map((m) => FFUploadedFile(
                                  name: m.storagePath.split('/').last,
                                  bytes: m.bytes,
                                  height: m.dimensions?.height,
                                  width: m.dimensions?.width,
                                  blurHash: m.blurHash,
                                ))
                            .toList();
                      } finally {
                        _model.isDataUploading1 = false;
                      }
                      if (selectedUploadedFiles.length ==
                          selectedMedia.length) {
                        safeSetState(() {
                          _model.uploadedLocalFile1 =
                              selectedUploadedFiles.first;
                        });
                      } else {
                        safeSetState(() {});
                        return;
                      }
                    }

                    if (!((_model.uploadedLocalFile1.bytes?.isNotEmpty ??
                            false))) {
                      Navigator.pop(context);
                      if (_shouldSetState) safeSetState(() {});
                      return;
                    }
                    _model.uploadFirebaseStorageAction =
                        await actions.uploadFileFirebaseStorage(
                      'Checkin',
                      _model.uploadedLocalFile1,
                    );
                    _shouldSetState = true;
                    if (!(_model.uploadFirebaseStorageAction != null &&
                        _model.uploadFirebaseStorageAction != '')) {
                      Navigator.pop(context);
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return WebViewAware(
                            child: AlertDialog(
                              content: Text(
                                  'ไม่สามารถอัพโหลดรูปได้ กรุณาลองอีกครั้ง'),
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
                      if (_shouldSetState) safeSetState(() {});
                      return;
                    }
                    FFAppState().imgURLTemp = functions
                        .stringToImgPath(_model.uploadFirebaseStorageAction)!;
                    safeSetState(() {});
                    Navigator.pop(context);
                    if (_shouldSetState) safeSetState(() {});
                  },
                  child: FaIcon(
                    FontAwesomeIcons.camera,
                    color: Colors.white,
                    size: 40.0,
                  ),
                ),
              ),
            ],
            centerTitle: true,
            elevation: 10.0,
          ),
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    height: 30.0,
                                    child: custom_widgets.ShowDateTime(
                                      width: double.infinity,
                                      height: 30.0,
                                      currentTime: getCurrentTimestamp,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  child: custom_widgets.ShowTime(
                                    width: double.infinity,
                                    height: 60.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (responsiveVisibility(
                          context: context,
                          tablet: false,
                          tabletLandscape: false,
                          desktop: false,
                        ))
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  70.0, 10.0, 70.0, 10.0),
                              child: Container(
                                width: double.infinity,
                                height: 220.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.fade,
                                                child:
                                                    FlutterFlowExpandedImageView(
                                                  image: Image.network(
                                                    valueOrDefault<String>(
                                                      FFAppState().imgURLTemp,
                                                      'https://firebasestorage.googleapis.com/v0/b/arunsawad-vn-application.appspot.com/o/blank-profile-picture-gc19a78ed8_1280.png?alt=media&token=6c3c82ce-a6ae-4b2e-b264-303820c6b65e',
                                                    ),
                                                    fit: BoxFit.contain,
                                                  ),
                                                  allowRotation: false,
                                                  tag: valueOrDefault<String>(
                                                    FFAppState().imgURLTemp,
                                                    'https://firebasestorage.googleapis.com/v0/b/arunsawad-vn-application.appspot.com/o/blank-profile-picture-gc19a78ed8_1280.png?alt=media&token=6c3c82ce-a6ae-4b2e-b264-303820c6b65e',
                                                  ),
                                                  useHeroAnimation: true,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Hero(
                                            tag: valueOrDefault<String>(
                                              FFAppState().imgURLTemp,
                                              'https://firebasestorage.googleapis.com/v0/b/arunsawad-vn-application.appspot.com/o/blank-profile-picture-gc19a78ed8_1280.png?alt=media&token=6c3c82ce-a6ae-4b2e-b264-303820c6b65e',
                                            ),
                                            transitionOnUserGestures: true,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(0.0),
                                              child: Image.network(
                                                valueOrDefault<String>(
                                                  FFAppState().imgURLTemp,
                                                  'https://firebasestorage.googleapis.com/v0/b/arunsawad-vn-application.appspot.com/o/blank-profile-picture-gc19a78ed8_1280.png?alt=media&token=6c3c82ce-a6ae-4b2e-b264-303820c6b65e',
                                                ),
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (functions.convertImgPathToString(
                                            FFAppState().imgURLTemp) !=
                                        '')
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1.0, -1.0),
                                        child: Builder(
                                          builder: (context) => Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 20.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                var confirmDialogResponse =
                                                    await showDialog<bool>(
                                                          context: context,
                                                          builder:
                                                              (alertDialogContext) {
                                                            return WebViewAware(
                                                              child:
                                                                  AlertDialog(
                                                                content: Text(
                                                                    'คุณต้องการจะลบรูปหรือไม่?'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            false),
                                                                    child: Text(
                                                                        'ยกเลิก'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            alertDialogContext,
                                                                            true),
                                                                    child: Text(
                                                                        'ตกลง'),
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
                                                showDialog(
                                                  context: context,
                                                  builder: (dialogContext) {
                                                    return Dialog(
                                                      elevation: 0,
                                                      insetPadding:
                                                          EdgeInsets.zero,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      alignment:
                                                          AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                      child: WebViewAware(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(
                                                                    dialogContext)
                                                                .unfocus();
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child:
                                                              LoadingWidget(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );

                                                await FirebaseStorage.instance
                                                    .refFromURL(
                                                        FFAppState().imgURLTemp)
                                                    .delete();
                                                FFAppState().imgURLTemp = '';
                                                FFAppState().update(() {});
                                                Navigator.pop(context);
                                              },
                                              child: FaIcon(
                                                FontAwesomeIcons.times,
                                                color: Color(0xFFDE1013),
                                                size: 30.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 12.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 12.0, 12.0, 0.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      if (_model.listLocationData.length > 10) {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          barrierColor: Color(0xC0000000),
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return WebViewAware(
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child: Container(
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.8,
                                                    child:
                                                        SerchBranchComponentCheckinWidget(
                                                      checkdatalist: _model
                                                          .listLocationData,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(
                                            () => _model.indexdata = value));

                                        safeSetState(() {
                                          _model.dropDownBranchValueController
                                                  ?.value =
                                              _model.listLocationData
                                                  .elementAtOrNull(
                                                      _model.indexdata!)!
                                                  .branchName;
                                        });
                                      }

                                      safeSetState(() {});
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '1nfjeid0' /* Select:  */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: FlutterFlowDropDown<
                                                        String>(
                                                      controller: _model
                                                              .dropDownBranchValueController ??=
                                                          FormFieldController<
                                                              String>(null),
                                                      options: _model
                                                          .listLocationData
                                                          .map((e) =>
                                                              e.branchName)
                                                          .toList(),
                                                      onChanged: (val) =>
                                                          safeSetState(() =>
                                                              _model.dropDownBranchValue =
                                                                  val),
                                                      width: 200.0,
                                                      height: 40.0,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Readex Pro',
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                      hintText:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                        'g8kgz1my' /* Check-in location... */,
                                                      ),
                                                      icon: Icon(
                                                        Icons
                                                            .keyboard_arrow_down_rounded,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        size: 24.0,
                                                      ),
                                                      fillColor: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      elevation: 2.0,
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderWidth: 0.0,
                                                      borderRadius: 8.0,
                                                      margin:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  12.0,
                                                                  0.0,
                                                                  12.0,
                                                                  0.0),
                                                      hidesUnderline: true,
                                                      disabled: _model
                                                              .listLocationData
                                                              .length >
                                                          10,
                                                      isOverButton: false,
                                                      isSearchable: false,
                                                      isMultiSelect: false,
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
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 0.0, 12.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'k25vdgx1' /* Reason: */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    width: 200.0,
                                                    child: TextFormField(
                                                      controller:
                                                          _model.textController,
                                                      focusNode: _model
                                                          .textFieldFocusNode,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        hintText:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'n3lk5dy4' /* Please provide a reason. */,
                                                        ),
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Readex Pro',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .textControllerValidator
                                                          .asValidator(context),
                                                    ),
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
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 8.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              currentUserLocationValue =
                                                  await getCurrentUserLocation(
                                                      defaultLocation:
                                                          LatLng(0.0, 0.0));
                                              var _shouldSetState = false;
                                              if (functions
                                                      .convertImgPathToString(
                                                          FFAppState()
                                                              .imgURLTemp) ==
                                                  '') {
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
                                                              'You have not taken a photo yet, please take one',
                                                          viText:
                                                              'Bạn chưa chụp ảnh, vui lòng chụp ảnh',
                                                          thText:
                                                              'ท่านยังไม่ได้ทำการถ่ายรูปภาพ กรุณาถ่ายภาพ',
                                                        )),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext),
                                                            child: Text('Ok'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                                final selectedMedia =
                                                    await selectMedia(
                                                  imageQuality: 30,
                                                  multiImage: false,
                                                );
                                                if (selectedMedia != null &&
                                                    selectedMedia.every((m) =>
                                                        validateFileFormat(
                                                            m.storagePath,
                                                            context))) {
                                                  safeSetState(() => _model
                                                      .isDataUploading2 = true);
                                                  var selectedUploadedFiles =
                                                      <FFUploadedFile>[];

                                                  try {
                                                    selectedUploadedFiles =
                                                        selectedMedia
                                                            .map((m) =>
                                                                FFUploadedFile(
                                                                  name: m
                                                                      .storagePath
                                                                      .split(
                                                                          '/')
                                                                      .last,
                                                                  bytes:
                                                                      m.bytes,
                                                                  height: m
                                                                      .dimensions
                                                                      ?.height,
                                                                  width: m
                                                                      .dimensions
                                                                      ?.width,
                                                                  blurHash: m
                                                                      .blurHash,
                                                                ))
                                                            .toList();
                                                  } finally {
                                                    _model.isDataUploading2 =
                                                        false;
                                                  }
                                                  if (selectedUploadedFiles
                                                          .length ==
                                                      selectedMedia.length) {
                                                    safeSetState(() {
                                                      _model.uploadedLocalFile2 =
                                                          selectedUploadedFiles
                                                              .first;
                                                    });
                                                  } else {
                                                    safeSetState(() {});
                                                    return;
                                                  }
                                                }

                                                if (!((_model
                                                            .uploadedLocalFile2
                                                            .bytes
                                                            ?.isNotEmpty ??
                                                        false))) {
                                                  Navigator.pop(context);
                                                  if (_shouldSetState)
                                                    safeSetState(() {});
                                                  return;
                                                }
                                                _model.uploadFirebaseStorageAction2 =
                                                    await actions
                                                        .uploadFileFirebaseStorage(
                                                  'Checkin',
                                                  _model.uploadedLocalFile2,
                                                );
                                                _shouldSetState = true;
                                                if (!(_model.uploadFirebaseStorageAction2 !=
                                                        null &&
                                                    _model.uploadFirebaseStorageAction2 !=
                                                        '')) {
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
                                                                'Unable to upload the photo, please try again',
                                                            viText:
                                                                'Không thể tải ảnh lên, vui lòng thử lại',
                                                            thText:
                                                                'ไม่สามารถอัพโหลดรูปได้ กรุณาลองอีกครั้ง',
                                                          )),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext),
                                                              child: Text('Ok'),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                  Navigator.pop(context);
                                                  if (_shouldSetState)
                                                    safeSetState(() {});
                                                  return;
                                                }
                                                FFAppState().imgURLTemp = functions
                                                    .stringToImgPath(_model
                                                        .uploadFirebaseStorageAction2)!;
                                                safeSetState(() {});
                                              }
                                              if (!(_model.dropDownBranchValue !=
                                                      null &&
                                                  _model.dropDownBranchValue !=
                                                      '')) {
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
                                                              'Please select branch',
                                                          viText:
                                                              'Vui lòng chọn chi nhánh',
                                                          thText:
                                                              'กรุณาเลือกสาขา',
                                                        )),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext),
                                                            child: Text('Ok'),
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
                                              if (!functions
                                                  .checkEnebleLocationDevice(
                                                      currentUserLocationValue)!) {
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
                                                              'Please enable Location (GPS)',
                                                          viText:
                                                              'Vui lòng bật Vị trí (GPS)',
                                                          thText:
                                                              'กรุณาเปิด Location (GPS)',
                                                        )),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext),
                                                            child: Text('Ok'),
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
                                              _model.checkUserIsInRadius =
                                                  await actions.locationCal(
                                                functions.combineLatLngFunction(
                                                    _model.listLocationData
                                                        .elementAtOrNull(_model
                                                            .listLocationData
                                                            .map((e) =>
                                                                e.branchName)
                                                            .toList()
                                                            .indexOf((_model
                                                                .dropDownBranchValue!)))
                                                        ?.latitude,
                                                    _model.listLocationData
                                                        .elementAtOrNull(_model
                                                            .listLocationData
                                                            .map((e) =>
                                                                e.branchName)
                                                            .toList()
                                                            .indexOf((_model
                                                                .dropDownBranchValue!)))
                                                        ?.longitude),
                                                currentUserLocationValue,
                                                _model.listLocationData
                                                    .elementAtOrNull(_model
                                                        .listLocationData
                                                        .map(
                                                            (e) => e.branchName)
                                                        .toList()
                                                        .indexOf((_model
                                                            .dropDownBranchValue!)))
                                                    ?.radius,
                                              );
                                              _shouldSetState = true;
                                              if (!_model
                                                  .checkUserIsInRadius!) {
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
                                                              'You are not within the check-in range. Please stay close to the check-in location you selected',
                                                          viText:
                                                              'Bạn không ở trong phạm vi điểm danh. Vui lòng ở gần địa điểm điểm danh mà bạn đã chọn',
                                                          thText:
                                                              'คุณไม่อยู่ในระยะเช็คอิน กรุณาอยู่ใกล้กับสถานที่เช็คอินที่คุณเลือก',
                                                        )),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext),
                                                            child: Text('Ok'),
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
                                              _model.workCheckApi =
                                                  await WorkCheckAPICall.call(
                                                branch: _model.listLocationData
                                                    .elementAtOrNull(_model
                                                        .listLocationData
                                                        .map(
                                                            (e) => e.branchName)
                                                        .toList()
                                                        .indexOf((_model
                                                            .dropDownBranchValue!)))
                                                    ?.branchCode,
                                                urlImg: functions
                                                    .convertImgPathToString(
                                                        FFAppState()
                                                            .imgURLTemp),
                                                token: FFAppState().accessToken,
                                                latitude:
                                                    functions.getLatLngFunction(
                                                        currentUserLocationValue,
                                                        'lat'),
                                                remark: _model.textController
                                                            .text !=
                                                        ''
                                                    ? _model.textController.text
                                                    : '',
                                                longitude:
                                                    functions.getLatLngFunction(
                                                        currentUserLocationValue,
                                                        'longitude'),
                                                apiUrl:
                                                    FFAppState().apiUrlAppState,
                                              );

                                              _shouldSetState = true;
                                              if ((_model.workCheckApi
                                                          ?.statusCode ??
                                                      200) !=
                                                  200) {
                                                if ('${WorkCheckAPICall.statuslayer1(
                                                      (_model.workCheckApi
                                                              ?.jsonBody ??
                                                          ''),
                                                    )}' ==
                                                    '440') {
                                                  await showDialog(
                                                    context: context,
                                                    builder:
                                                        (alertDialogContext) {
                                                      return WebViewAware(
                                                        child: AlertDialog(
                                                          content: Text(
                                                              '${WorkCheckAPICall.messagelayer1(
                                                            (_model.workCheckApi
                                                                    ?.jsonBody ??
                                                                ''),
                                                          )}'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext),
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
                                                    builder:
                                                        (alertDialogContext) {
                                                      return WebViewAware(
                                                        child: AlertDialog(
                                                          content: Text(
                                                              '${FFLocalizations.of(context).getVariableText(
                                                            enText:
                                                                'An error has occurred (',
                                                            viText:
                                                                'Đã xảy ra lỗi (',
                                                            thText:
                                                                'พบข้อผิดพลาด (',
                                                          )}${WorkCheckAPICall.statuslayer1(
                                                            (_model.workCheckApi
                                                                    ?.jsonBody ??
                                                                ''),
                                                          )})'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext),
                                                              child: Text('Ok'),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                  Navigator.pop(context);
                                                  if (_shouldSetState)
                                                    safeSetState(() {});
                                                  return;
                                                }

                                                await actions.a22();
                                                FFAppState().isLogin = false;
                                                FFAppState().accessToken = '';
                                                safeSetState(() {});
                                                FFAppState().username = '';
                                                FFAppState().employeeID = '';
                                                safeSetState(() {});
                                                FFAppState()
                                                    .profilePositionName = '';
                                                FFAppState().profileStartDate =
                                                    '';
                                                FFAppState().branchCode = '';
                                                safeSetState(() {});
                                                FFAppState().profileHiredDate =
                                                    '';
                                                safeSetState(() {});
                                                FFAppState().profileBranchName =
                                                    '';
                                                FFAppState().profileBranchCode =
                                                    '';
                                                safeSetState(() {});
                                                FFAppState().isInApp = false;
                                                FFAppState().isLoginNew = false;
                                                safeSetState(() {});
                                                Navigator.pop(context);

                                                context.pushNamed('loginPage');

                                                if (_shouldSetState)
                                                  safeSetState(() {});
                                                return;
                                              }
                                              if ('${getJsonField(
                                                    (_model.workCheckApi
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$.code''',
                                                  ).toString()}' !=
                                                  '200') {
                                                await showDialog(
                                                  context: context,
                                                  builder:
                                                      (alertDialogContext) {
                                                    return WebViewAware(
                                                      child: AlertDialog(
                                                        content: Text(
                                                            '${WorkCheckAPICall.messagelayer1(
                                                          (_model.workCheckApi
                                                                  ?.jsonBody ??
                                                              ''),
                                                        )}'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    alertDialogContext),
                                                            child: Text('Ok'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                                Navigator.pop(context);
                                                if (_shouldSetState)
                                                  safeSetState(() {});
                                                return;
                                              }
                                              await showDialog(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return WebViewAware(
                                                    child: AlertDialog(
                                                      content: Text(
                                                          '${WorkCheckAPICall.messagelayer1(
                                                        (_model.workCheckApi
                                                                ?.jsonBody ??
                                                            ''),
                                                      )}'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  alertDialogContext),
                                                          child: Text('Ok'),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );

                                              context.pushNamed(
                                                  'CheckInStatusPage');

                                              if (_shouldSetState)
                                                safeSetState(() {});
                                            },
                                            text: FFLocalizations.of(context)
                                                .getText(
                                              'hgcupj9q' /* Clock in-out */,
                                            ),
                                            options: FFButtonOptions(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.3,
                                              height: 40.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: Color(0xFF08DC07),
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Colors.white,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                              elevation: 8.0,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                        .addToStart(SizedBox(width: 12.0))
                                        .addToEnd(SizedBox(width: 12.0)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: 100.0,
                          height: 285.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height * 0.25,
                            child: custom_widgets.DrawCircleMap(
                              width: double.infinity,
                              height: MediaQuery.sizeOf(context).height * 0.25,
                              latitude: _model.dropDownBranchValue != null &&
                                      _model.dropDownBranchValue != ''
                                  ? valueOrDefault<double>(
                                      double.parse(_model.listLocationData
                                          .elementAtOrNull(_model
                                              .listLocationData
                                              .map((e) => e.branchName)
                                              .toList()
                                              .indexOf((_model
                                                  .dropDownBranchValue!)))!
                                          .latitude),
                                      0.0,
                                    )
                                  : 0.0,
                              longitude: _model.dropDownBranchValue != null &&
                                      _model.dropDownBranchValue != ''
                                  ? valueOrDefault<double>(
                                      double.parse(_model.listLocationData
                                          .elementAtOrNull(_model
                                              .listLocationData
                                              .map((e) => e.branchName)
                                              .toList()
                                              .indexOf((_model
                                                  .dropDownBranchValue!)))!
                                          .longitude),
                                      0.0,
                                    )
                                  : 0.0,
                              radiusLo: _model.dropDownBranchValue != null &&
                                      _model.dropDownBranchValue != ''
                                  ? valueOrDefault<double>(
                                      double.parse(_model.listLocationData
                                          .elementAtOrNull(_model
                                              .listLocationData
                                              .map((e) => e.branchName)
                                              .toList()
                                              .indexOf((_model
                                                  .dropDownBranchValue!)))!
                                          .radius),
                                      0.0,
                                    )
                                  : 0.0,
                              currentLoLat: double.parse(
                                  (functions.getLatLngFunction(
                                      currentUserLocationValue, 'lat')!)),
                              currentLoLng: double.parse(
                                  (functions.getLatLngFunction(
                                      currentUserLocationValue, 'lng')!)),
                            ),
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
      ),
    );
  }
}
