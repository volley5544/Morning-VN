import '/flutter_flow/flutter_flow_util.dart';
import 'lead_list_page_widget.dart' show LeadListPageWidget;
import 'package:flutter/material.dart';

class LeadListPageModel extends FlutterFlowModel<LeadListPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextFieldSearch widget.
  FocusNode? textFieldSearchFocusNode;
  TextEditingController? textFieldSearchTextController;
  String? Function(BuildContext, String?)?
      textFieldSearchTextControllerValidator;
  // Stores action output result for [Custom Action - open3CXAction] action in Image widget.
  bool? call3CXAction;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldSearchFocusNode?.dispose();
    textFieldSearchTextController?.dispose();
  }
}
