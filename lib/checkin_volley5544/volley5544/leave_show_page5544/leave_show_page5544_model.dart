import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'leave_show_page5544_widget.dart' show LeaveShowPage5544Widget;
import 'package:flutter/material.dart';

class LeaveShowPage5544Model extends FlutterFlowModel<LeaveShowPage5544Widget> {
  ///  Local state fields for this page.

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

  List<dynamic> leaveHistoryList = [];
  void addToLeaveHistoryList(dynamic item) => leaveHistoryList.add(item);
  void removeFromLeaveHistoryList(dynamic item) =>
      leaveHistoryList.remove(item);
  void removeAtIndexFromLeaveHistoryList(int index) =>
      leaveHistoryList.removeAt(index);
  void insertAtIndexInLeaveHistoryList(int index, dynamic item) =>
      leaveHistoryList.insert(index, item);
  void updateLeaveHistoryListAtIndex(int index, Function(dynamic) updateFn) =>
      leaveHistoryList[index] = updateFn(leaveHistoryList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getLeaveHistory)] action in leaveShowPage5544 widget.
  ApiCallResponse? leaveHistoryListAPIOutput;
  // Stores action output result for [Custom Action - convertToMonthNamberCopy] action in leaveShowPage5544 widget.
  String? selectMonth;
  // Stores action output result for [Custom Action - convertToMonthNamber] action in leaveShowPage5544 widget.
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
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
