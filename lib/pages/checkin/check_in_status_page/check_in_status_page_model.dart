import '/flutter_flow/flutter_flow_util.dart';
import 'check_in_status_page_widget.dart' show CheckInStatusPageWidget;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class CheckInStatusPageModel extends FlutterFlowModel<CheckInStatusPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Expandable widget.
  late ExpandableController expandableExpandableController;

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    expandableExpandableController.dispose();
    tabBarController?.dispose();
  }
}
