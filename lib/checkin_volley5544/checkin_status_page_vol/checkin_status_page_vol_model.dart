import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/checkin_volley5544/checkin_data_table_component/checkin_data_table_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'checkin_status_page_vol_widget.dart' show CheckinStatusPageVolWidget;
import 'package:flutter/material.dart';

class CheckinStatusPageVolModel
    extends FlutterFlowModel<CheckinStatusPageVolWidget> {
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

  // Stores action output result for [Backend Call - API (workCheckHistoryAPI)] action in CheckinStatusPageVol widget.
  ApiCallResponse? workCheckHistoryApiOutput;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Model for CheckinDataTableComponent component.
  late CheckinDataTableComponentModel checkinDataTableComponentModel1;
  // Model for CheckinDataTableComponent component.
  late CheckinDataTableComponentModel checkinDataTableComponentModel2;

  @override
  void initState(BuildContext context) {
    checkinDataTableComponentModel1 =
        createModel(context, () => CheckinDataTableComponentModel());
    checkinDataTableComponentModel2 =
        createModel(context, () => CheckinDataTableComponentModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    checkinDataTableComponentModel1.dispose();
    checkinDataTableComponentModel2.dispose();
  }
}
