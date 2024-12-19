import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'add_resign_page_widget.dart' show AddResignPageWidget;
import 'package:flutter/material.dart';

class AddResignPageModel extends FlutterFlowModel<AddResignPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for CheckboxGroup widget.
  FormFieldController<List<String>>? checkboxGroupValueController1;
  List<String>? get checkboxGroupValues1 =>
      checkboxGroupValueController1?.value;
  set checkboxGroupValues1(List<String>? v) =>
      checkboxGroupValueController1?.value = v;

  // State field(s) for ReasonToLeaveEtcTextField widget.
  FocusNode? reasonToLeaveEtcTextFieldFocusNode;
  TextEditingController? reasonToLeaveEtcTextFieldTextController;
  String? Function(BuildContext, String?)?
      reasonToLeaveEtcTextFieldTextControllerValidator;
  // State field(s) for ReasonToLeaveTextField widget.
  FocusNode? reasonToLeaveTextFieldFocusNode;
  TextEditingController? reasonToLeaveTextFieldTextController;
  String? Function(BuildContext, String?)?
      reasonToLeaveTextFieldTextControllerValidator;
  // State field(s) for provinceDropDown widget.
  String? provinceDropDownValue;
  FormFieldController<String>? provinceDropDownValueController;
  // State field(s) for districtDropDown widget.
  String? districtDropDownValue;
  FormFieldController<String>? districtDropDownValueController;
  // State field(s) for subdistrictDropDown widget.
  String? subdistrictDropDownValue;
  FormFieldController<String>? subdistrictDropDownValueController;
  // State field(s) for postCodeDropDown widget.
  String? postCodeDropDownValue;
  FormFieldController<String>? postCodeDropDownValueController;
  // State field(s) for batchRoadTextField widget.
  FocusNode? batchRoadTextFieldFocusNode;
  TextEditingController? batchRoadTextFieldTextController;
  String? Function(BuildContext, String?)?
      batchRoadTextFieldTextControllerValidator;
  // State field(s) for PhoneNumberTextField widget.
  FocusNode? phoneNumberTextFieldFocusNode;
  TextEditingController? phoneNumberTextFieldTextController;
  String? Function(BuildContext, String?)?
      phoneNumberTextFieldTextControllerValidator;
  // State field(s) for ChanceToWorkTgtDropDown widget.
  String? chanceToWorkTgtDropDownValue;
  FormFieldController<String>? chanceToWorkTgtDropDownValueController;
  // State field(s) for CheckboxGroup widget.
  FormFieldController<List<String>>? checkboxGroupValueController2;
  List<String>? get checkboxGroupValues2 =>
      checkboxGroupValueController2?.value;
  set checkboxGroupValues2(List<String>? v) =>
      checkboxGroupValueController2?.value = v;

  // State field(s) for ReturnAssetTextField widget.
  FocusNode? returnAssetTextFieldFocusNode;
  TextEditingController? returnAssetTextFieldTextController;
  String? Function(BuildContext, String?)?
      returnAssetTextFieldTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController1?.dispose();

    reasonToLeaveEtcTextFieldFocusNode?.dispose();
    reasonToLeaveEtcTextFieldTextController?.dispose();

    reasonToLeaveTextFieldFocusNode?.dispose();
    reasonToLeaveTextFieldTextController?.dispose();

    batchRoadTextFieldFocusNode?.dispose();
    batchRoadTextFieldTextController?.dispose();

    phoneNumberTextFieldFocusNode?.dispose();
    phoneNumberTextFieldTextController?.dispose();

    returnAssetTextFieldFocusNode?.dispose();
    returnAssetTextFieldTextController?.dispose();
  }
}
