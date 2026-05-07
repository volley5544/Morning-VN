import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'remark_r_p8_page_widget.dart' show RemarkRP8PageWidget;
import 'package:flutter/material.dart';

class RemarkRP8PageModel extends FlutterFlowModel<RemarkRP8PageWidget> {
  ///  Local state fields for this page.

  List<FFUploadedFile> imageList = [];
  void addToImageList(FFUploadedFile item) => imageList.add(item);
  void removeFromImageList(FFUploadedFile item) => imageList.remove(item);
  void removeAtIndexFromImageList(int index) => imageList.removeAt(index);
  void insertAtIndexInImageList(int index, FFUploadedFile item) =>
      imageList.insert(index, item);
  void updateImageListAtIndex(int index, Function(FFUploadedFile) updateFn) =>
      imageList[index] = updateFn(imageList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getRemarkRPDropdownApi)] action in RemarkRP8Page widget.
  ApiCallResponse? getRemarkDropdownOutput;
  // State field(s) for DropDownFollowup widget.
  String? dropDownFollowupValue;
  FormFieldController<String>? dropDownFollowupValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for RemarkTextField widget.
  FocusNode? remarkTextFieldFocusNode;
  TextEditingController? remarkTextFieldTextController;
  String? Function(BuildContext, String?)?
      remarkTextFieldTextControllerValidator;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController1?.dispose();

    remarkTextFieldFocusNode?.dispose();
    remarkTextFieldTextController?.dispose();
  }
}
