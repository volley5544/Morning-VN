import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'branch_view_camera_component_model.dart';
export 'branch_view_camera_component_model.dart';

class BranchViewCameraComponentWidget extends StatefulWidget {
  const BranchViewCameraComponentWidget({
    super.key,
    required this.addFileToList,
    required this.currentFileAmount,
  });

  final Future Function(FFUploadedFile fileOutput)? addFileToList;
  final int? currentFileAmount;

  @override
  State<BranchViewCameraComponentWidget> createState() =>
      _BranchViewCameraComponentWidgetState();
}

class _BranchViewCameraComponentWidgetState
    extends State<BranchViewCameraComponentWidget> {
  late BranchViewCameraComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BranchViewCameraComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        if (widget.currentFileAmount! >= 5) {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return WebViewAware(
                child: AlertDialog(
                  content: Text(() {
                    if (FFLocalizations.of(context).languageCode == 'th') {
                      return 'อัปโหลดรูปได้สูงสุด 5 รูป';
                    } else if (FFLocalizations.of(context).languageCode ==
                        'en') {
                      return 'อัปโหลดรูปได้สูงสุด 5 รูป';
                    } else if (FFLocalizations.of(context).languageCode ==
                        'vi') {
                      return 'อัปโหลดรูปได้สูงสุด 5 รูป';
                    } else {
                      return 'อัปโหลดรูปได้สูงสุด 5 รูป';
                    }
                  }()),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext),
                      child: Text('Ok'),
                    ),
                  ],
                ),
              );
            },
          );
          return;
        }
        final selectedMedia = await selectMediaWithSourceBottomSheet(
          context: context,
          maxWidth: 1920.00,
          maxHeight: 1920.00,
          imageQuality: 50,
          allowPhoto: true,
        );
        if (selectedMedia != null &&
            selectedMedia
                .every((m) => validateFileFormat(m.storagePath, context))) {
          safeSetState(
              () => _model.isDataUploading_uploadDataBranchViewCamera = true);
          var selectedUploadedFiles = <FFUploadedFile>[];

          try {
            selectedUploadedFiles = selectedMedia
                .map((m) => FFUploadedFile(
                      name: m.storagePath.split('/').last,
                      bytes: m.bytes,
                      height: m.dimensions?.height,
                      width: m.dimensions?.width,
                      blurHash: m.blurHash,
                      originalFilename: m.originalFilename,
                    ))
                .toList();
          } finally {
            _model.isDataUploading_uploadDataBranchViewCamera = false;
          }
          if (selectedUploadedFiles.length == selectedMedia.length) {
            safeSetState(() {
              _model.uploadedLocalFile_uploadDataBranchViewCamera =
                  selectedUploadedFiles.first;
            });
          } else {
            safeSetState(() {});
            return;
          }
        }

        if (!((_model.uploadedLocalFile_uploadDataBranchViewCamera.bytes
                    ?.isNotEmpty ??
                false))) {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return WebViewAware(
                child: AlertDialog(
                  content: Text(() {
                    if (FFLocalizations.of(context).languageCode == 'th') {
                      return 'เลือกไฟล์ล้มเหลว';
                    } else if (FFLocalizations.of(context).languageCode ==
                        'en') {
                      return 'เลือกไฟล์ล้มเหลว';
                    } else if (FFLocalizations.of(context).languageCode ==
                        'vi') {
                      return 'เลือกไฟล์ล้มเหลว';
                    } else {
                      return 'เลือกไฟล์ล้มเหลว';
                    }
                  }()),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(alertDialogContext),
                      child: Text('Ok'),
                    ),
                  ],
                ),
              );
            },
          );
          return;
        }
        await widget.addFileToList?.call(
          _model.uploadedLocalFile_uploadDataBranchViewCamera,
        );
        safeSetState(() {
          _model.isDataUploading_uploadDataBranchViewCamera = false;
          _model.uploadedLocalFile_uploadDataBranchViewCamera = FFUploadedFile(
              bytes: Uint8List.fromList([]), originalFilename: '');
        });

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              () {
                if (FFLocalizations.of(context).languageCode == 'th') {
                  return 'เลือกรูปสำเร็จ!';
                } else if (FFLocalizations.of(context).languageCode == 'en') {
                  return 'Select Image Success!';
                } else if (FFLocalizations.of(context).languageCode == 'vi') {
                  return 'Chọn hình ảnh thành công!';
                } else {
                  return 'เลือกรูปสำเร็จ!';
                }
              }(),
              style: TextStyle(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
            ),
            duration: Duration(milliseconds: 3000),
            backgroundColor: Color(0xCB000000),
          ),
        );
      },
      child: Icon(
        Icons.camera_alt_rounded,
        color: FlutterFlowTheme.of(context).secondaryBackground,
        size: 30.0,
      ),
    );
  }
}
