import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'super_app_page_widget.dart' show SuperAppPageWidget;
import 'package:flutter/material.dart';

class SuperAppPageModel extends FlutterFlowModel<SuperAppPageWidget> {
  ///  Local state fields for this page.

  List<bool> boolList = [false, false, true, false, false];
  void addToBoolList(bool item) => boolList.add(item);
  void removeFromBoolList(bool item) => boolList.remove(item);
  void removeAtIndexFromBoolList(int index) => boolList.removeAt(index);
  void insertAtIndexInBoolList(int index, bool item) =>
      boolList.insert(index, item);
  void updateBoolListAtIndex(int index, Function(bool) updateFn) =>
      boolList[index] = updateFn(boolList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (getUserProfileAPI)] action in superAppPage widget.
  ApiCallResponse? apiResultGetProfile;
  // State field(s) for PageViewBanner widget.
  PageController? pageViewBannerController;

  int get pageViewBannerCurrentIndex => pageViewBannerController != null &&
          pageViewBannerController!.hasClients &&
          pageViewBannerController!.page != null
      ? pageViewBannerController!.page!.round()
      : 0;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
