import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'history_collection_page_widget.dart' show HistoryCollectionPageWidget;
import 'package:flutter/material.dart';

class HistoryCollectionPageModel
    extends FlutterFlowModel<HistoryCollectionPageWidget> {
  ///  Local state fields for this page.

  List<HistoryCollectionDataModelStruct> historyData = [];
  void addToHistoryData(HistoryCollectionDataModelStruct item) =>
      historyData.add(item);
  void removeFromHistoryData(HistoryCollectionDataModelStruct item) =>
      historyData.remove(item);
  void removeAtIndexFromHistoryData(int index) => historyData.removeAt(index);
  void insertAtIndexInHistoryData(
          int index, HistoryCollectionDataModelStruct item) =>
      historyData.insert(index, item);
  void updateHistoryDataAtIndex(
          int index, Function(HistoryCollectionDataModelStruct) updateFn) =>
      historyData[index] = updateFn(historyData[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (get data history)] action in historyCollectionPage widget.
  ApiCallResponse? apiResulti1b;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
