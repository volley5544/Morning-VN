import '/flutter_flow/flutter_flow_util.dart';
import 'show_checkin_image_widget.dart' show ShowCheckinImageWidget;
import 'package:flutter/material.dart';

class ShowCheckinImageModel extends FlutterFlowModel<ShowCheckinImageWidget> {
  ///  State fields for stateful widgets in this component.

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
