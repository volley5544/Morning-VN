import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/leave_calendar_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'add_leave_page_widget.dart' show AddLeavePageWidget;
import 'package:flutter/material.dart';

class AddLeavePageModel extends FlutterFlowModel<AddLeavePageWidget> {
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

  List<CurrentYearStruct> nextYearDataPage = [];
  void addToNextYearDataPage(CurrentYearStruct item) =>
      nextYearDataPage.add(item);
  void removeFromNextYearDataPage(CurrentYearStruct item) =>
      nextYearDataPage.remove(item);
  void removeAtIndexFromNextYearDataPage(int index) =>
      nextYearDataPage.removeAt(index);
  void insertAtIndexInNextYearDataPage(int index, CurrentYearStruct item) =>
      nextYearDataPage.insert(index, item);
  void updateNextYearDataPageAtIndex(
          int index, Function(CurrentYearStruct) updateFn) =>
      nextYearDataPage[index] = updateFn(nextYearDataPage[index]);

  List<dynamic> listLeaveData = [];
  void addToListLeaveData(dynamic item) => listLeaveData.add(item);
  void removeFromListLeaveData(dynamic item) => listLeaveData.remove(item);
  void removeAtIndexFromListLeaveData(int index) =>
      listLeaveData.removeAt(index);
  void insertAtIndexInListLeaveData(int index, dynamic item) =>
      listLeaveData.insert(index, item);
  void updateListLeaveDataAtIndex(int index, Function(dynamic) updateFn) =>
      listLeaveData[index] = updateFn(listLeaveData[index]);

  List<CurrentYearStruct> previousYearDataPage = [];
  void addToPreviousYearDataPage(CurrentYearStruct item) =>
      previousYearDataPage.add(item);
  void removeFromPreviousYearDataPage(CurrentYearStruct item) =>
      previousYearDataPage.remove(item);
  void removeAtIndexFromPreviousYearDataPage(int index) =>
      previousYearDataPage.removeAt(index);
  void insertAtIndexInPreviousYearDataPage(int index, CurrentYearStruct item) =>
      previousYearDataPage.insert(index, item);
  void updatePreviousYearDataPageAtIndex(
          int index, Function(CurrentYearStruct) updateFn) =>
      previousYearDataPage[index] = updateFn(previousYearDataPage[index]);

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (getLeaveList)] action in AddLeavePage widget.
  ApiCallResponse? apiResultLeaveList;
  // State field(s) for leaveTime widget.
  String? leaveTimeValue;
  FormFieldController<String>? leaveTimeValueController;
  // Model for LeaveCalendarComponent component.
  late LeaveCalendarComponentModel leaveCalendarComponentModel;
  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  // State field(s) for reasonToLeave widget.
  FocusNode? reasonToLeaveFocusNode;
  TextEditingController? reasonToLeaveTextController;
  String? Function(BuildContext, String?)? reasonToLeaveTextControllerValidator;
  bool isDataUploading_uploadMedia59b = false;
  List<FFUploadedFile> uploadedLocalFiles_uploadMedia59b = [];

  // Stores action output result for [Custom Action - uploadMultipleFileFirebaseStorage] action in leaveFile widget.
  List<String>? firebaseuploadoutput;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Backend Call - API (saveLeave)] action in Button widget.
  ApiCallResponse? leaveRequestAPIOutput;

  @override
  void initState(BuildContext context) {
    leaveCalendarComponentModel =
        createModel(context, () => LeaveCalendarComponentModel());
  }

  @override
  void dispose() {
    leaveCalendarComponentModel.dispose();
    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    reasonToLeaveFocusNode?.dispose();
    reasonToLeaveTextController?.dispose();
  }
}
