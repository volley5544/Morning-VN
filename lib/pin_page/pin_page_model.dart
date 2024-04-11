import '/flutter_flow/flutter_flow_util.dart';
import 'pin_page_widget.dart' show PinPageWidget;
import 'package:flutter/material.dart';

class PinPageModel extends FlutterFlowModel<PinPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - getBuildVersion] action in pinPage widget.
  String? getBuildVersion;
  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  // Stores action output result for [Custom Action - backgroundLocationCheck] action in PinCode widget.
  bool? backgroundLocationCheck;
  // Stores action output result for [Custom Action - backgroundLocationPermission] action in PinCode widget.
  bool? permissionRequestOutput;
  // Stores action output result for [Custom Action - checkGpsServiceEnable] action in PinCode widget.
  bool? checkGpsEnable;
  // Stores action output result for [Custom Action - checkGpsServiceEnable] action in PinCode widget.
  bool? checkGpsEnable2;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    pinCodeController?.dispose();
  }
}
