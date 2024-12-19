import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'test_calendar_widget.dart' show TestCalendarWidget;
import 'package:flutter/material.dart';

class TestCalendarModel extends FlutterFlowModel<TestCalendarWidget> {
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

  List<LeaveTypeDataStruct> leaveTypeDataPage = [];
  void addToLeaveTypeDataPage(LeaveTypeDataStruct item) =>
      leaveTypeDataPage.add(item);
  void removeFromLeaveTypeDataPage(LeaveTypeDataStruct item) =>
      leaveTypeDataPage.remove(item);
  void removeAtIndexFromLeaveTypeDataPage(int index) =>
      leaveTypeDataPage.removeAt(index);
  void insertAtIndexInLeaveTypeDataPage(int index, LeaveTypeDataStruct item) =>
      leaveTypeDataPage.insert(index, item);
  void updateLeaveTypeDataPageAtIndex(
          int index, Function(LeaveTypeDataStruct) updateFn) =>
      leaveTypeDataPage[index] = updateFn(leaveTypeDataPage[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getLeaveList)] action in testCalendar widget.
  ApiCallResponse? apiResult235;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
