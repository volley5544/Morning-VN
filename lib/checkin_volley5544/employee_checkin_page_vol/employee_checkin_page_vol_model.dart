import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'employee_checkin_page_vol_widget.dart'
    show EmployeeCheckinPageVolWidget;
import 'package:flutter/material.dart';

class EmployeeCheckinPageVolModel
    extends FlutterFlowModel<EmployeeCheckinPageVolWidget> {
  ///  Local state fields for this page.

  List<ListLocationCheckInStruct> listLocationData = [];
  void addToListLocationData(ListLocationCheckInStruct item) =>
      listLocationData.add(item);
  void removeFromListLocationData(ListLocationCheckInStruct item) =>
      listLocationData.remove(item);
  void removeAtIndexFromListLocationData(int index) =>
      listLocationData.removeAt(index);
  void insertAtIndexInListLocationData(
          int index, ListLocationCheckInStruct item) =>
      listLocationData.insert(index, item);
  void updateListLocationDataAtIndex(
          int index, Function(ListLocationCheckInStruct) updateFn) =>
      listLocationData[index] = updateFn(listLocationData[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetLocation)] action in EmployeeCheckinPageVol widget.
  ApiCallResponse? apiResultjwm;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Custom Action - uploadFileFirebaseStorage] action in Button widget.
  String? uploadedImageOutput2;
  // Stores action output result for [Custom Action - locationCal] action in Button widget.
  bool? checkUserIsInRadius;
  // Stores action output result for [Backend Call - API (workCheckAPI)] action in Button widget.
  ApiCallResponse? workCheckApiOutput;
  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Custom Action - uploadFileFirebaseStorage] action in IconButton widget.
  String? uploadedImageOutput1;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
