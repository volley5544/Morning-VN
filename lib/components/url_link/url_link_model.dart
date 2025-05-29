import '/flutter_flow/flutter_flow_util.dart';
import 'url_link_widget.dart' show UrlLinkWidget;
import 'package:flutter/material.dart';

class UrlLinkModel extends FlutterFlowModel<UrlLinkWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
