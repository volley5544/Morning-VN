import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'edit_leave_page_widget.dart' show EditLeavePageWidget;
import 'package:flutter/material.dart';

class EditLeavePageModel extends FlutterFlowModel<EditLeavePageWidget> {
  ///  Local state fields for this page.

  List<String> leaveDocList = [];
  void addToLeaveDocList(String item) => leaveDocList.add(item);
  void removeFromLeaveDocList(String item) => leaveDocList.remove(item);
  void removeAtIndexFromLeaveDocList(int index) => leaveDocList.removeAt(index);
  void insertAtIndexInLeaveDocList(int index, String item) =>
      leaveDocList.insert(index, item);
  void updateLeaveDocListAtIndex(int index, Function(String) updateFn) =>
      leaveDocList[index] = updateFn(leaveDocList[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for leaveTime widget.
  String? leaveTimeValue;
  FormFieldController<String>? leaveTimeValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
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
    textFieldFocusNode?.dispose();
    textController1?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    reasonToLeaveFocusNode?.dispose();
    reasonToLeaveTextController?.dispose();
  }
}
