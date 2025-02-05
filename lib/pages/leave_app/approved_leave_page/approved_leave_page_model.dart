import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'approved_leave_page_widget.dart' show ApprovedLeavePageWidget;
import 'package:flutter/material.dart';

class ApprovedLeavePageModel extends FlutterFlowModel<ApprovedLeavePageWidget> {
  ///  Local state fields for this page.

  List<ListApproveStruct> approveLeaveData = [];
  void addToApproveLeaveData(ListApproveStruct item) =>
      approveLeaveData.add(item);
  void removeFromApproveLeaveData(ListApproveStruct item) =>
      approveLeaveData.remove(item);
  void removeAtIndexFromApproveLeaveData(int index) =>
      approveLeaveData.removeAt(index);
  void insertAtIndexInApproveLeaveData(int index, ListApproveStruct item) =>
      approveLeaveData.insert(index, item);
  void updateApproveLeaveDataAtIndex(
          int index, Function(ListApproveStruct) updateFn) =>
      approveLeaveData[index] = updateFn(approveLeaveData[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getUserProfileAPI)] action in ApprovedLeavePage widget.
  ApiCallResponse? getUserProfileAPI;
  // Stores action output result for [Backend Call - API (getLeaveListApprove)] action in ApprovedLeavePage widget.
  ApiCallResponse? getLeaveListApprove;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // Stores action output result for [Backend Call - API (saveStatusLeave)] action in Button widget.
  ApiCallResponse? leaveListApproveAllAPIOutput;
  // Stores action output result for [Backend Call - API (saveStatusLeave)] action in Button widget.
  ApiCallResponse? saveStatusLeave;
  // Stores action output result for [Backend Call - API (saveStatusLeave)] action in Button widget.
  ApiCallResponse? saveStatusLeaveNotApprove;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
