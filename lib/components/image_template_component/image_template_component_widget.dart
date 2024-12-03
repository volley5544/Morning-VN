import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'image_template_component_model.dart';
export 'image_template_component_model.dart';

class ImageTemplateComponentWidget extends StatefulWidget {
  const ImageTemplateComponentWidget({super.key});

  @override
  State<ImageTemplateComponentWidget> createState() =>
      _ImageTemplateComponentWidgetState();
}

class _ImageTemplateComponentWidgetState
    extends State<ImageTemplateComponentWidget> {
  late ImageTemplateComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ImageTemplateComponentModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'assets/images/ARUN-PLAYSTORE-ICON-Logo_(1).png',
          width: 300.0,
          height: 200.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
