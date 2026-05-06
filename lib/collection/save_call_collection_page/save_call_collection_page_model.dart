import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/input_amount_p_p_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'save_call_collection_page_widget.dart'
    show SaveCallCollectionPageWidget;
import 'package:flutter/material.dart';

class SaveCallCollectionPageModel
    extends FlutterFlowModel<SaveCallCollectionPageWidget> {
  ///  Local state fields for this page.

  List<SaveCallCollectionDataModelStruct> saveCall = [];
  void addToSaveCall(SaveCallCollectionDataModelStruct item) =>
      saveCall.add(item);
  void removeFromSaveCall(SaveCallCollectionDataModelStruct item) =>
      saveCall.remove(item);
  void removeAtIndexFromSaveCall(int index) => saveCall.removeAt(index);
  void insertAtIndexInSaveCall(
          int index, SaveCallCollectionDataModelStruct item) =>
      saveCall.insert(index, item);
  void updateSaveCallAtIndex(
          int index, Function(SaveCallCollectionDataModelStruct) updateFn) =>
      saveCall[index] = updateFn(saveCall[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for DropDownSaveCall widget.
  String? dropDownSaveCallValue;
  FormFieldController<String>? dropDownSaveCallValueController;
  DateTime? datePicked;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // Models for InputAmountPPComponent dynamic component.
  late FlutterFlowDynamicModels<InputAmountPPComponentModel>
      inputAmountPPComponentModels;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Stores action output result for [Backend Call - API (save call collection)] action in Button widget.
  ApiCallResponse? apiResultkap;

  @override
  void initState(BuildContext context) {
    inputAmountPPComponentModels =
        FlutterFlowDynamicModels(() => InputAmountPPComponentModel());
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    inputAmountPPComponentModels.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }
}
