import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'approve_show_page_widget.dart' show ApproveShowPageWidget;
import 'package:flutter/material.dart';

class ApproveShowPageModel extends FlutterFlowModel<ApproveShowPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for monthSelect widget.
  String? monthSelectValue;
  FormFieldController<String>? monthSelectValueController;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
