import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'test2_page_widget.dart' show Test2PageWidget;
import 'package:flutter/material.dart';

class Test2PageModel extends FlutterFlowModel<Test2PageWidget> {
  ///  Local state fields for this page.

  List<CalendarDataStruct> calendarData = [];
  void addToCalendarData(CalendarDataStruct item) => calendarData.add(item);
  void removeFromCalendarData(CalendarDataStruct item) =>
      calendarData.remove(item);
  void removeAtIndexFromCalendarData(int index) => calendarData.removeAt(index);
  void insertAtIndexInCalendarData(int index, CalendarDataStruct item) =>
      calendarData.insert(index, item);
  void updateCalendarDataAtIndex(
          int index, Function(CalendarDataStruct) updateFn) =>
      calendarData[index] = updateFn(calendarData[index]);

  List<dynamic> leaveTypeData = [];
  void addToLeaveTypeData(dynamic item) => leaveTypeData.add(item);
  void removeFromLeaveTypeData(dynamic item) => leaveTypeData.remove(item);
  void removeAtIndexFromLeaveTypeData(int index) =>
      leaveTypeData.removeAt(index);
  void insertAtIndexInLeaveTypeData(int index, dynamic item) =>
      leaveTypeData.insert(index, item);
  void updateLeaveTypeDataAtIndex(int index, Function(dynamic) updateFn) =>
      leaveTypeData[index] = updateFn(leaveTypeData[index]);

  List<CurrentYearStruct> currentYearData = [];
  void addToCurrentYearData(CurrentYearStruct item) =>
      currentYearData.add(item);
  void removeFromCurrentYearData(CurrentYearStruct item) =>
      currentYearData.remove(item);
  void removeAtIndexFromCurrentYearData(int index) =>
      currentYearData.removeAt(index);
  void insertAtIndexInCurrentYearData(int index, CurrentYearStruct item) =>
      currentYearData.insert(index, item);
  void updateCurrentYearDataAtIndex(
          int index, Function(CurrentYearStruct) updateFn) =>
      currentYearData[index] = updateFn(currentYearData[index]);

  List<CurrentYearStruct> nextYearData = [];
  void addToNextYearData(CurrentYearStruct item) => nextYearData.add(item);
  void removeFromNextYearData(CurrentYearStruct item) =>
      nextYearData.remove(item);
  void removeAtIndexFromNextYearData(int index) => nextYearData.removeAt(index);
  void insertAtIndexInNextYearData(int index, CurrentYearStruct item) =>
      nextYearData.insert(index, item);
  void updateNextYearDataAtIndex(
          int index, Function(CurrentYearStruct) updateFn) =>
      nextYearData[index] = updateFn(nextYearData[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getLeaveList)] action in Test2Page widget.
  ApiCallResponse? apiResult235;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
