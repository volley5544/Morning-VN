import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'tab_collection_page_widget.dart' show TabCollectionPageWidget;
import 'package:flutter/material.dart';

class TabCollectionPageModel extends FlutterFlowModel<TabCollectionPageWidget> {
  ///  Local state fields for this page.

  List<CountCollectionDataModelStruct> dataCount = [];
  void addToDataCount(CountCollectionDataModelStruct item) =>
      dataCount.add(item);
  void removeFromDataCount(CountCollectionDataModelStruct item) =>
      dataCount.remove(item);
  void removeAtIndexFromDataCount(int index) => dataCount.removeAt(index);
  void insertAtIndexInDataCount(
          int index, CountCollectionDataModelStruct item) =>
      dataCount.insert(index, item);
  void updateDataCountAtIndex(
          int index, Function(CountCollectionDataModelStruct) updateFn) =>
      dataCount[index] = updateFn(dataCount[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Read Document] action in tabCollectionPage widget.
  UrlStorageRecord? urlCollection;
  // Stores action output result for [Backend Call - API (get data count)] action in tabCollectionPage widget.
  ApiCallResponse? apiResult1wx;
  // Stores action output result for [Custom Action - translateLanguage2] action in Text widget.
  String? translateOutput;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
