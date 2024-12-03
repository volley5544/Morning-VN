import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_leave_page_widget.dart' show AddLeavePageWidget;
import 'package:flutter/material.dart';

class AddLeavePageModel extends FlutterFlowModel<AddLeavePageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  // State field(s) for reasonToLeave widget.
  FocusNode? reasonToLeaveFocusNode;
  TextEditingController? reasonToLeaveTextController;
  String? Function(BuildContext, String?)? reasonToLeaveTextControllerValidator;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    reasonToLeaveFocusNode?.dispose();
    reasonToLeaveTextController?.dispose();
  }
}
