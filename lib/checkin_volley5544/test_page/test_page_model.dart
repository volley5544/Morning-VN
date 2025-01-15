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

  List<CurrentYearStruct> currentYearDataPage = [];
  void addToCurrentYearDataPage(CurrentYearStruct item) =>
      currentYearDataPage.add(item);
  void removeFromCurrentYearDataPage(CurrentYearStruct item) =>
      currentYearDataPage.remove(item);
  void removeAtIndexFromCurrentYearDataPage(int index) =>
      currentYearDataPage.removeAt(index);
  void insertAtIndexInCurrentYearDataPage(int index, CurrentYearStruct item) =>
      currentYearDataPage.insert(index, item);
  void updateCurrentYearDataPageAtIndex(
          int index, Function(CurrentYearStruct) updateFn) =>
      currentYearDataPage[index] = updateFn(currentYearDataPage[index]);

  List<OtherYearStruct> otherYearDataPage = [];
  void addToOtherYearDataPage(OtherYearStruct item) =>
      otherYearDataPage.add(item);
  void removeFromOtherYearDataPage(OtherYearStruct item) =>
      otherYearDataPage.remove(item);
  void removeAtIndexFromOtherYearDataPage(int index) =>
      otherYearDataPage.removeAt(index);
  void insertAtIndexInOtherYearDataPage(int index, OtherYearStruct item) =>
      otherYearDataPage.insert(index, item);
  void updateOtherYearDataPageAtIndex(
          int index, Function(OtherYearStruct) updateFn) =>
      otherYearDataPage[index] = updateFn(otherYearDataPage[index]);

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

  // Stores action output result for [Backend Call - API (getLeaveList)] action in TestPage widget.
  ApiCallResponse? apiResult235;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
