import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'leave_show_page_widget.dart' show LeaveShowPageWidget;
import 'package:flutter/material.dart';

class LeaveShowPageModel extends FlutterFlowModel<LeaveShowPageWidget> {
  ///  Local state fields for this page.

  List<LeaveHistoryNewStruct> leaveHistoryCYearData = [];
  void addToLeaveHistoryCYearData(LeaveHistoryNewStruct item) =>
      leaveHistoryCYearData.add(item);
  void removeFromLeaveHistoryCYearData(LeaveHistoryNewStruct item) =>
      leaveHistoryCYearData.remove(item);
  void removeAtIndexFromLeaveHistoryCYearData(int index) =>
      leaveHistoryCYearData.removeAt(index);
  void insertAtIndexInLeaveHistoryCYearData(
          int index, LeaveHistoryNewStruct item) =>
      leaveHistoryCYearData.insert(index, item);
  void updateLeaveHistoryCYearDataAtIndex(
          int index, Function(LeaveHistoryNewStruct) updateFn) =>
      leaveHistoryCYearData[index] = updateFn(leaveHistoryCYearData[index]);

  LeaveHistoryNewStruct? leaveHistoryCMonthData;
  void updateLeaveHistoryCMonthDataStruct(
      Function(LeaveHistoryNewStruct) updateFn) {
    updateFn(leaveHistoryCMonthData ??= LeaveHistoryNewStruct());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getLeaveHistory)] action in leaveShowPage widget.
  ApiCallResponse? leaveHistoryListAPIOutput;
  // Stores action output result for [Custom Action - convertToMonthNamberCopy] action in leaveShowPage widget.
  String? selectMonth;
  // Stores action output result for [Custom Action - convertToMonthNamber] action in leaveShowPage widget.
  String? selectMonthNumber;
  // State field(s) for monthSelect widget.
  String? monthSelectValue;
  FormFieldController<String>? monthSelectValueController;
  // Stores action output result for [Custom Action - convertToMonthNamber] action in monthSelect widget.
  String? monthNamber;
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
