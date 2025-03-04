import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'approve_show_page5544_widget.dart' show ApproveShowPage5544Widget;
import 'package:flutter/material.dart';

class ApproveShowPage5544Model
    extends FlutterFlowModel<ApproveShowPage5544Widget> {
  ///  Local state fields for this page.

  ApproveListDataModelStruct? currentYearData;
  void updateCurrentYearDataStruct(
      Function(ApproveListDataModelStruct) updateFn) {
    updateFn(currentYearData ??= ApproveListDataModelStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getAllLeave Copy)] action in ApproveShowPage5544 widget.
  ApiCallResponse? getAllLeave;
  // State field(s) for yearSelect widget.
  String? yearSelectValue;
  FormFieldController<String>? yearSelectValueController;
  // State field(s) for monthSelect widget.
  String? monthSelectValue;
  FormFieldController<String>? monthSelectValueController;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
