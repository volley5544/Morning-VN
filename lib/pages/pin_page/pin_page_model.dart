import '/flutter_flow/flutter_flow_util.dart';
import 'pin_page_widget.dart' show PinPageWidget;
import 'package:flutter/material.dart';

class PinPageModel extends FlutterFlowModel<PinPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getBuildVersion] action in pinPage widget.
  String? getBuildVersion;
  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    pinCodeController?.dispose();
  }
}
