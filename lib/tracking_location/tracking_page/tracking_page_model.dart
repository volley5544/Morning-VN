import '/flutter_flow/flutter_flow_util.dart';
import '/tracking_location/poly_map_widget_component/poly_map_widget_component_widget.dart';
import '/index.dart';
import 'tracking_page_widget.dart' show TrackingPageWidget;
import 'package:flutter/material.dart';

class TrackingPageModel extends FlutterFlowModel<TrackingPageWidget> {
  ///  Local state fields for this page.

  String? dateIndex;

  ///  State fields for stateful widgets in this page.

  // Model for PolyMapWidgetComponent component.
  late PolyMapWidgetComponentModel polyMapWidgetComponentModel;

  @override
  void initState(BuildContext context) {
    polyMapWidgetComponentModel =
        createModel(context, () => PolyMapWidgetComponentModel());
  }

  @override
  void dispose() {
    polyMapWidgetComponentModel.dispose();
  }
}
