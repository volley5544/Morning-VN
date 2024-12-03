import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'question_mask_icon_component_model.dart';
export 'question_mask_icon_component_model.dart';

class QuestionMaskIconComponentWidget extends StatefulWidget {
  const QuestionMaskIconComponentWidget({super.key});

  @override
  State<QuestionMaskIconComponentWidget> createState() =>
      _QuestionMaskIconComponentWidgetState();
}

class _QuestionMaskIconComponentWidgetState
    extends State<QuestionMaskIconComponentWidget> {
  late QuestionMaskIconComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuestionMaskIconComponentModel());
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
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          FlutterFlowIconButton(
            borderColor: FlutterFlowTheme.of(context).primary,
            borderRadius: 20.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            fillColor: const Color(0xFFFF9000),
            icon: const Icon(
              Icons.question_mark_sharp,
              color: Colors.white,
              size: 24.0,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
        ],
      ),
    );
  }
}
