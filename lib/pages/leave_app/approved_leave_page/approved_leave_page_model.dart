import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'approved_leave_page_widget.dart' show ApprovedLeavePageWidget;
import 'package:flutter/material.dart';

class ApprovedLeavePageModel extends FlutterFlowModel<ApprovedLeavePageWidget> {
  ///  Local state fields for this page.

  List<ListAppoveStruct> approveLeaveData = [];
  void addToApproveLeaveData(ListAppoveStruct item) =>
      approveLeaveData.add(item);
  void removeFromApproveLeaveData(ListAppoveStruct item) =>
      approveLeaveData.remove(item);
  void removeAtIndexFromApproveLeaveData(int index) =>
      approveLeaveData.removeAt(index);
  void insertAtIndexInApproveLeaveData(int index, ListAppoveStruct item) =>
      approveLeaveData.insert(index, item);
  void updateApproveLeaveDataAtIndex(
          int index, Function(ListAppoveStruct) updateFn) =>
      approveLeaveData[index] = updateFn(approveLeaveData[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getLeaveListApprove)] action in ApprovedLeavePage widget.
  ApiCallResponse? getLeaveListApprove;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
