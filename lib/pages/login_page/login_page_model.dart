import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart'
    show TutorialCoachMark;
import 'package:flutter/material.dart';

class LoginPageModel extends FlutterFlowModel<LoginPageWidget> {
  ///  State fields for stateful widgets in this page.

  TutorialCoachMark? loginController;
  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - getBuildVersion] action in loginPage widget.
  String? getBuildVersion;
  // State field(s) for username widget.
  FocusNode? usernameFocusNode;
  TextEditingController? usernameController;
  String? Function(BuildContext, String?)? usernameControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  // Stores action output result for [Custom Action - backgroundLocationCheck] action in Button widget.
  bool? backgroundLocationCheck;
  // Stores action output result for [Custom Action - backgroundLocationPermission] action in Button widget.
  bool? permissionRequestOutput;
  // Stores action output result for [Custom Action - checkGpsServiceEnable] action in Button widget.
  bool? checkGpsEnable;
  // Stores action output result for [Custom Action - checkGpsServiceEnable] action in Button widget.
  bool? checkGpsEnable2;
  // Stores action output result for [Backend Call - API (authenAPI)] action in Button widget.
  ApiCallResponse? authAPIOutput;
  // Stores action output result for [Custom Action - checkFirebase] action in Button widget.
  String? customFirebaseAuthen;
  // Stores action output result for [Custom Action - checkUserFirebase] action in Button widget.
  String? userUID;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  UserCustomRecord? createdUserCustom;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
  }

  @override
  void dispose() {
    loginController?.finish();
    unfocusNode.dispose();
    usernameFocusNode?.dispose();
    usernameController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();
  }
}
