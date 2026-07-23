import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'detail_collection_page_widget.dart' show DetailCollectionPageWidget;
import 'package:flutter/material.dart';

class DetailCollectionPageModel
    extends FlutterFlowModel<DetailCollectionPageWidget> {
  ///  Local state fields for this page.

  List<CollectionDataModelStruct> dataCollectionPage = [];
  void addToDataCollectionPage(CollectionDataModelStruct item) =>
      dataCollectionPage.add(item);
  void removeFromDataCollectionPage(CollectionDataModelStruct item) =>
      dataCollectionPage.remove(item);
  void removeAtIndexFromDataCollectionPage(int index) =>
      dataCollectionPage.removeAt(index);
  void insertAtIndexInDataCollectionPage(
          int index, CollectionDataModelStruct item) =>
      dataCollectionPage.insert(index, item);
  void updateDataCollectionPageAtIndex(
          int index, Function(CollectionDataModelStruct) updateFn) =>
      dataCollectionPage[index] = updateFn(dataCollectionPage[index]);

  List<bool> selectedList = [];
  void addToSelectedList(bool item) => selectedList.add(item);
  void removeFromSelectedList(bool item) => selectedList.remove(item);
  void removeAtIndexFromSelectedList(int index) => selectedList.removeAt(index);
  void insertAtIndexInSelectedList(int index, bool item) =>
      selectedList.insert(index, item);
  void updateSelectedListAtIndex(int index, Function(bool) updateFn) =>
      selectedList[index] = updateFn(selectedList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (get data person)] action in detailCollectionPage widget.
  ApiCallResponse? apiResultl77;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for Checkbox widget.
  Map<CollectionDataModelStruct, bool> checkboxValueMap = {};
  List<CollectionDataModelStruct> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  // Stores action output result for [Custom Action - translateLanguage2] action in Icon widget.
  String? errorPhoneNumber2;
  // Stores action output result for [Custom Action - translateLanguage2] action in Icon widget.
  String? summitPhoneNumber2;
  // Stores action output result for [Custom Action - open3CXAction] action in Icon widget.
  bool? call3CXAction;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
