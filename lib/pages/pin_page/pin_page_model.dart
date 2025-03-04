import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'pin_page_widget.dart' show PinPageWidget;
import 'package:flutter/material.dart';

class PinPageModel extends FlutterFlowModel<PinPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getBuildVersion] action in pinPage widget.
  String? getBuildVersion;
  // Stores action output result for [Firestore Query - Query a collection] action in pinPage widget.
  KeyStorage2Record? apiKeyStorage;
  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  FocusNode? pinCodeFocusNode;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  // Stores action output result for [Custom Action - backgroundLocationCheck] action in PinCode widget.
  bool? backgroundLocationCheck;
  // Stores action output result for [Custom Action - backgroundLocationPermission] action in PinCode widget.
  bool? permissionRequestOutput;
  // Stores action output result for [Custom Action - checkGpsServiceEnable] action in PinCode widget.
  bool? checkGpsEnable;
  // Stores action output result for [Custom Action - checkGpsServiceEnable] action in PinCode widget.
  bool? checkGpsEnable2;
  // Stores action output result for [Backend Call - API (getUserProfileAPI)] action in PinCode widget.
  ApiCallResponse? getUserProfile;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    pinCodeFocusNode?.dispose();
    pinCodeController?.dispose();
  }
}
