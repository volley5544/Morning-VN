import '/flutter_flow/flutter_flow_util.dart';
import 'confirm_cancel_leave_component_widget.dart'
    show ConfirmCancelLeaveComponentWidget;
import 'package:flutter/material.dart';

class ConfirmCancelLeaveComponentModel
    extends FlutterFlowModel<ConfirmCancelLeaveComponentWidget> {
  ///  State fields for stateful widgets in this component.

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
