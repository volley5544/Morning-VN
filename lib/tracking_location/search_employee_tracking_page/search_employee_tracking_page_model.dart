import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'search_employee_tracking_page_widget.dart'
    show SearchEmployeeTrackingPageWidget;
import 'package:flutter/material.dart';

class SearchEmployeeTrackingPageModel
    extends FlutterFlowModel<SearchEmployeeTrackingPageWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetEmployeeListApi)] action in SearchEmployeeTrackingPage widget.
  ApiCallResponse? apiUserOutput;
  DateTime? datePicked;
  // Stores action output result for [Backend Call - API (GetLocationEmployeeAPI)] action in Button widget.
  ApiCallResponse? getUserLocations;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
