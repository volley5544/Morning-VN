import '/flutter_flow/flutter_flow_util.dart';
import 'cancel_page_widget.dart' show CancelPageWidget;
import 'package:flutter/material.dart';

class CancelPageModel extends FlutterFlowModel<CancelPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for reasonCancel widget.
  FocusNode? reasonCancelFocusNode;
  TextEditingController? reasonCancelTextController;
  String? Function(BuildContext, String?)? reasonCancelTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    reasonCancelFocusNode?.dispose();
    reasonCancelTextController?.dispose();
  }
}
