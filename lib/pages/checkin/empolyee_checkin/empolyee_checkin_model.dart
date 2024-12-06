import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'empolyee_checkin_widget.dart' show EmpolyeeCheckinWidget;
import 'package:flutter/material.dart';

class EmpolyeeCheckinModel extends FlutterFlowModel<EmpolyeeCheckinWidget> {
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

  // Stores action output result for [Backend Call - API (GetLocation)] action in EmpolyeeCheckin widget.
  ApiCallResponse? getLocationApiOutput;
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Custom Action - uploadFileFirebaseStorage] action in Icon widget.
  String? uploadFirebaseStorageAction;
  // Stores action output result for [Bottom Sheet - serchBranchComponentCheckin] action in Row widget.
  int? indexdata;
  // State field(s) for DropDownBranch widget.
  String? dropDownBranchValue;
  FormFieldController<String>? dropDownBranchValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Custom Action - uploadFileFirebaseStorage] action in Button widget.
  String? uploadFirebaseStorageAction2;
  // Stores action output result for [Custom Action - locationCal] action in Button widget.
  bool? checkUserIsInRadius;
  // Stores action output result for [Backend Call - API (workCheckAPI)] action in Button widget.
  ApiCallResponse? workCheckApi;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
