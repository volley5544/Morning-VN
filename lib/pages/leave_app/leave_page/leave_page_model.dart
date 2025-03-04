import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'leave_page_widget.dart' show LeavePageWidget;
import 'package:flutter/material.dart';

class LeavePageModel extends FlutterFlowModel<LeavePageWidget> {
  ///  Local state fields for this page.

  List<dynamic> listLeaveData = [];
  void addToListLeaveData(dynamic item) => listLeaveData.add(item);
  void removeFromListLeaveData(dynamic item) => listLeaveData.remove(item);
  void removeAtIndexFromListLeaveData(int index) =>
      listLeaveData.removeAt(index);
  void insertAtIndexInListLeaveData(int index, dynamic item) =>
      listLeaveData.insert(index, item);
  void updateListLeaveDataAtIndex(int index, Function(dynamic) updateFn) =>
      listLeaveData[index] = updateFn(listLeaveData[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getUserProfileAPI)] action in LeavePage widget.
  ApiCallResponse? getUserProfileAPI;
  // Stores action output result for [Backend Call - API (getLeaveList)] action in LeavePage widget.
  ApiCallResponse? leaveListAPIOutput;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
