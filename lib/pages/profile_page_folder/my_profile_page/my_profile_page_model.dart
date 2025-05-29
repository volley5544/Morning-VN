import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'my_profile_page_widget.dart' show MyProfilePageWidget;
import 'package:flutter/material.dart';

class MyProfilePageModel extends FlutterFlowModel<MyProfilePageWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadProfileImageAction = false;
  FFUploadedFile uploadedLocalFile_uploadProfileImageAction =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Custom Action - uploadFileFirebaseStorage] action in IconButton widget.
  String? uploadFirebaseStorageAction;
  // Stores action output result for [Custom Action - checkImageIsAvailable] action in IconButton widget.
  bool? checkProfileImgIsAvailable;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
