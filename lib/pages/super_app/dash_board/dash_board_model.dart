import '/flutter_flow/flutter_flow_util.dart';
import 'dash_board_widget.dart' show DashBoardWidget;
import 'package:flutter/material.dart';

class DashBoardModel extends FlutterFlowModel<DashBoardWidget> {
  ///  State fields for stateful widgets in this page.

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
