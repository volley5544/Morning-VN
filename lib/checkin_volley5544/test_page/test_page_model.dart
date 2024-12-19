import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'test_page_widget.dart' show TestPageWidget;
import 'package:flutter/material.dart';

class TestPageModel extends FlutterFlowModel<TestPageWidget> {
  ///  Local state fields for this page.

  List<CalendarDataStruct> holidayDataPage = [];
  void addToHolidayDataPage(CalendarDataStruct item) =>
      holidayDataPage.add(item);
  void removeFromHolidayDataPage(CalendarDataStruct item) =>
      holidayDataPage.remove(item);
  void removeAtIndexFromHolidayDataPage(int index) =>
      holidayDataPage.removeAt(index);
  void insertAtIndexInHolidayDataPage(int index, CalendarDataStruct item) =>
      holidayDataPage.insert(index, item);
  void updateHolidayDataPageAtIndex(
          int index, Function(CalendarDataStruct) updateFn) =>
      holidayDataPage[index] = updateFn(holidayDataPage[index]);

  List<LeaveTypeDataStruct> leaveTypeData = [];
  void addToLeaveTypeData(LeaveTypeDataStruct item) => leaveTypeData.add(item);
  void removeFromLeaveTypeData(LeaveTypeDataStruct item) =>
      leaveTypeData.remove(item);
  void removeAtIndexFromLeaveTypeData(int index) =>
      leaveTypeData.removeAt(index);
  void insertAtIndexInLeaveTypeData(int index, LeaveTypeDataStruct item) =>
      leaveTypeData.insert(index, item);
  void updateLeaveTypeDataAtIndex(
          int index, Function(LeaveTypeDataStruct) updateFn) =>
      leaveTypeData[index] = updateFn(leaveTypeData[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getLeaveList)] action in TestPage widget.
  ApiCallResponse? apiResult235;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
