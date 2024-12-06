import '/flutter_flow/flutter_flow_util.dart';
import 'search_branch_component_widget.dart' show SearchBranchComponentWidget;
import 'package:flutter/material.dart';

class SearchBranchComponentModel
    extends FlutterFlowModel<SearchBranchComponentWidget> {
  ///  State fields for stateful widgets in this component.

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
