import '/flutter_flow/flutter_flow_util.dart';
import 'input_amount_p_p_component_widget.dart'
    show InputAmountPPComponentWidget;
import 'package:flutter/material.dart';

class InputAmountPPComponentModel
    extends FlutterFlowModel<InputAmountPPComponentWidget> {
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
