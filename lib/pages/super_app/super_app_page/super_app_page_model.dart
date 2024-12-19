import '/flutter_flow/flutter_flow_util.dart';
import 'super_app_page_widget.dart' show SuperAppPageWidget;
import 'package:flutter/material.dart';

class SuperAppPageModel extends FlutterFlowModel<SuperAppPageWidget> {
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
  // Stores action output result for [Custom Action - a1] action in ListTile widget.
  bool? checkDeviceLocSerLogout;
  // Stores action output result for [Custom Action - a2] action in ListTile widget.
  bool? checkDeviceLocPerLogout;
  // Stores action output result for [Custom Action - a8] action in ListTile widget.
  bool? checkLatLngLogout;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
