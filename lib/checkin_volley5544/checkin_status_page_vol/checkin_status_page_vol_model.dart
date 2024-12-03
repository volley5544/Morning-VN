import '/flutter_flow/flutter_flow_util.dart';
import 'checkin_status_page_vol_widget.dart' show CheckinStatusPageVolWidget;
import 'package:flutter/material.dart';

class CheckinStatusPageVolModel
    extends FlutterFlowModel<CheckinStatusPageVolWidget> {
  ///  State fields for stateful widgets in this page.

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
