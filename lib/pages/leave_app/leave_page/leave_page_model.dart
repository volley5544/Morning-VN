import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'leave_page_widget.dart' show LeavePageWidget;
import 'package:flutter/material.dart';

class LeavePageModel extends FlutterFlowModel<LeavePageWidget> {
  ///  Local state fields for this page.

  List<LeaveListDataStruct> listLeaveData = [];
  void addToListLeaveData(LeaveListDataStruct item) => listLeaveData.add(item);
  void removeFromListLeaveData(LeaveListDataStruct item) =>
      listLeaveData.remove(item);
  void removeAtIndexFromListLeaveData(int index) =>
      listLeaveData.removeAt(index);
  void insertAtIndexInListLeaveData(int index, LeaveListDataStruct item) =>
      listLeaveData.insert(index, item);
  void updateListLeaveDataAtIndex(
          int index, Function(LeaveListDataStruct) updateFn) =>
      listLeaveData[index] = updateFn(listLeaveData[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getLeaveList)] action in LeavePage widget.
  ApiCallResponse? leaveListAPIOutput;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
