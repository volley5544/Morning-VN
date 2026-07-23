import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'show_checkin_image_new_model.dart';
export 'show_checkin_image_new_model.dart';

class ShowCheckinImageNewWidget extends StatefulWidget {
  const ShowCheckinImageNewWidget({
    super.key,
    this.leaveImage,
  });

  final String? leaveImage;

  @override
  State<ShowCheckinImageNewWidget> createState() =>
      _ShowCheckinImageNewWidgetState();
}

class _ShowCheckinImageNewWidgetState extends State<ShowCheckinImageNewWidget> {
  late ShowCheckinImageNewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShowCheckinImageNewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: FlutterFlowExpandedImageView(
                  image: Image.network(
                    functions.convertStringToImgPath(widget.leaveImage)!,
                    fit: BoxFit.contain,
                  ),
                  allowRotation: false,
                  tag: functions.convertStringToImgPath(widget.leaveImage)!,
                  useHeroAnimation: true,
                ),
              ),
            );
          },
          child: Hero(
            tag: functions.convertStringToImgPath(widget.leaveImage)!,
            transitionOnUserGestures: true,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                functions.convertStringToImgPath(widget.leaveImage)!,
                width: double.infinity,
                height: 600.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        FlutterFlowIconButton(
          borderRadius: 30.0,
          buttonSize: 75.0,
          icon: Icon(
            Icons.cancel_outlined,
            color: Color(0xFFFF0000),
            size: 35.0,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
