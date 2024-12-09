import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'change_lat_lng_page_widget.dart' show ChangeLatLngPageWidget;
import 'package:flutter/material.dart';

class ChangeLatLngPageModel extends FlutterFlowModel<ChangeLatLngPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - a8] action in ChangeLatLngPage widget.
  bool? checkGps;
  // State field(s) for BranchCodeInput widget.
  FocusNode? branchCodeInputFocusNode;
  TextEditingController? branchCodeInputTextController;
  String? Function(BuildContext, String?)?
      branchCodeInputTextControllerValidator;
  // State field(s) for LatInput widget.
  FocusNode? latInputFocusNode;
  TextEditingController? latInputTextController;
  String? Function(BuildContext, String?)? latInputTextControllerValidator;
  // State field(s) for LngInput widget.
  FocusNode? lngInputFocusNode;
  TextEditingController? lngInputTextController;
  String? Function(BuildContext, String?)? lngInputTextControllerValidator;
  // Stores action output result for [Backend Call - API (getBranchLocation)] action in Button widget.
  ApiCallResponse? locationCheckApi;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter1;
  final googleMapsController1 = Completer<GoogleMapController>();
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter2;
  final googleMapsController2 = Completer<GoogleMapController>();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    branchCodeInputFocusNode?.dispose();
    branchCodeInputTextController?.dispose();

    latInputFocusNode?.dispose();
    latInputTextController?.dispose();

    lngInputFocusNode?.dispose();
    lngInputTextController?.dispose();
  }
}
