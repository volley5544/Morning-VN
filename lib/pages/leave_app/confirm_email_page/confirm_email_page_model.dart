import '/flutter_flow/flutter_flow_util.dart';
import 'confirm_email_page_widget.dart' show ConfirmEmailPageWidget;
import 'package:flutter/material.dart';

class ConfirmEmailPageModel extends FlutterFlowModel<ConfirmEmailPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
