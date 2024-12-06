import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'check_in_status_page_widget.dart' show CheckInStatusPageWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class CheckInStatusPageModel extends FlutterFlowModel<CheckInStatusPageWidget> {
  ///  Local state fields for this page.

  List<CheckinDataStruct> checkinHistoryCurrentMonthData = [];
  void addToCheckinHistoryCurrentMonthData(CheckinDataStruct item) =>
      checkinHistoryCurrentMonthData.add(item);
  void removeFromCheckinHistoryCurrentMonthData(CheckinDataStruct item) =>
      checkinHistoryCurrentMonthData.remove(item);
  void removeAtIndexFromCheckinHistoryCurrentMonthData(int index) =>
      checkinHistoryCurrentMonthData.removeAt(index);
  void insertAtIndexInCheckinHistoryCurrentMonthData(
          int index, CheckinDataStruct item) =>
      checkinHistoryCurrentMonthData.insert(index, item);
  void updateCheckinHistoryCurrentMonthDataAtIndex(
          int index, Function(CheckinDataStruct) updateFn) =>
      checkinHistoryCurrentMonthData[index] =
          updateFn(checkinHistoryCurrentMonthData[index]);

  List<CheckinDataStruct> checkinHistoryLastMonthData = [];
  void addToCheckinHistoryLastMonthData(CheckinDataStruct item) =>
      checkinHistoryLastMonthData.add(item);
  void removeFromCheckinHistoryLastMonthData(CheckinDataStruct item) =>
      checkinHistoryLastMonthData.remove(item);
  void removeAtIndexFromCheckinHistoryLastMonthData(int index) =>
      checkinHistoryLastMonthData.removeAt(index);
  void insertAtIndexInCheckinHistoryLastMonthData(
          int index, CheckinDataStruct item) =>
      checkinHistoryLastMonthData.insert(index, item);
  void updateCheckinHistoryLastMonthDataAtIndex(
          int index, Function(CheckinDataStruct) updateFn) =>
      checkinHistoryLastMonthData[index] =
          updateFn(checkinHistoryLastMonthData[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (workCheckHistoryAPI)] action in CheckInStatusPage widget.
  ApiCallResponse? workCheckHistoryApiOutput;
  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    expandableExpandableController.dispose();
    tabBarController?.dispose();
  }
}
