import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'approve_show_page_widget.dart' show ApproveShowPageWidget;
import 'package:flutter/material.dart';

class ApproveShowPageModel extends FlutterFlowModel<ApproveShowPageWidget> {
  ///  Local state fields for this page.

  List<dynamic> approve = [];
  void addToApprove(dynamic item) => approve.add(item);
  void removeFromApprove(dynamic item) => approve.remove(item);
  void removeAtIndexFromApprove(int index) => approve.removeAt(index);
  void insertAtIndexInApprove(int index, dynamic item) =>
      approve.insert(index, item);
  void updateApproveAtIndex(int index, Function(dynamic) updateFn) =>
      approve[index] = updateFn(approve[index]);

  List<dynamic> notApprove = [];
  void addToNotApprove(dynamic item) => notApprove.add(item);
  void removeFromNotApprove(dynamic item) => notApprove.remove(item);
  void removeAtIndexFromNotApprove(int index) => notApprove.removeAt(index);
  void insertAtIndexInNotApprove(int index, dynamic item) =>
      notApprove.insert(index, item);
  void updateNotApproveAtIndex(int index, Function(dynamic) updateFn) =>
      notApprove[index] = updateFn(notApprove[index]);

  List<dynamic> cancel = [];
  void addToCancel(dynamic item) => cancel.add(item);
  void removeFromCancel(dynamic item) => cancel.remove(item);
  void removeAtIndexFromCancel(int index) => cancel.removeAt(index);
  void insertAtIndexInCancel(int index, dynamic item) =>
      cancel.insert(index, item);
  void updateCancelAtIndex(int index, Function(dynamic) updateFn) =>
      cancel[index] = updateFn(cancel[index]);

  List<LeaveHistoryStruct> leaveHistoryCYearData = [];
  void addToLeaveHistoryCYearData(LeaveHistoryStruct item) =>
      leaveHistoryCYearData.add(item);
  void removeFromLeaveHistoryCYearData(LeaveHistoryStruct item) =>
      leaveHistoryCYearData.remove(item);
  void removeAtIndexFromLeaveHistoryCYearData(int index) =>
      leaveHistoryCYearData.removeAt(index);
  void insertAtIndexInLeaveHistoryCYearData(
          int index, LeaveHistoryStruct item) =>
      leaveHistoryCYearData.insert(index, item);
  void updateLeaveHistoryCYearDataAtIndex(
          int index, Function(LeaveHistoryStruct) updateFn) =>
      leaveHistoryCYearData[index] = updateFn(leaveHistoryCYearData[index]);

  LeaveHistoryStruct? leaveHistoryCMonthData;
  void updateLeaveHistoryCMonthDataStruct(
      Function(LeaveHistoryStruct) updateFn) {
    updateFn(leaveHistoryCMonthData ??= LeaveHistoryStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getAllLeave)] action in ApproveShowPage widget.
  ApiCallResponse? getAllLeave;
  // Stores action output result for [Custom Action - convertToMonthNamberCopy] action in ApproveShowPage widget.
  String? selectMonth;
  // Stores action output result for [Custom Action - convertToMonthNamber] action in ApproveShowPage widget.
  String? selectMonthNumber;
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
