// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:collection';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:mime/mime.dart';

class InappWebViewWidget extends StatefulWidget {
  const InappWebViewWidget(
      {super.key,
      this.width,
      this.height,
      this.webUrl,
      required this.onFinishedLoading,
      required this.closeWebviewAction,
      required this.openLoadingComponent,
      required this.closeLoadingComponent});

  final double? width;
  final double? height;
  final String? webUrl;
  final Future Function(bool isCaptured) onFinishedLoading;
  final Future Function() closeWebviewAction;
  final Future Function() openLoadingComponent;
  final Future Function() closeLoadingComponent;

  @override
  State<InappWebViewWidget> createState() => _InappWebViewWidgetState();
}

class _InappWebViewWidgetState extends State<InappWebViewWidget> {
  late InAppWebViewController _webViewController;
  late bool isDone = false;

  Future<String> convertImageToString(XFile? file) async {
    try {
      if (file != null) {
        List<int> imageBytes = await file.readAsBytes();
        final lookupType = lookupMimeType(file.path);
        String base64Image = base64Encode(imageBytes);
        return 'data:$lookupType;base64,$base64Image';
      } else {
        return '';
      }
    } catch (err) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    print('frome');
    return PopScope(
      canPop: false,
      child: Container(
        width: widget.width,
        height: widget.height,
        child: Column(children: <Widget>[
          Expanded(
            child: Container(
              child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri(widget
                        .webUrl!), // https://vcall.swpfin.com:8888/self-room
                  ),
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    print('shouldOverrideUrlLoading');
                    var uri = navigationAction.request.url;
                    print(uri);
                    if (uri != null && uri.scheme == "tel") {
                      try {
                        print('in tel');

                        await open3CXAction('${'${uri}'.split(':').last}');
                      } catch (e) {
                        print("Could not launch ${uri.toString()}: $e");
                      }
                      return NavigationActionPolicy
                          .CANCEL; // Stop WebView from trying to open it
                    }
                    return NavigationActionPolicy.ALLOW;
                  },
                  initialSettings: InAppWebViewSettings(
                    mediaPlaybackRequiresUserGesture: false,
                    useShouldOverrideUrlLoading: true,
                    geolocationEnabled: true,
                    cacheEnabled: true,
                    clearCache: false,
                    javaScriptEnabled: true,
                    javaScriptCanOpenWindowsAutomatically: true,
                    allowFileAccess: true,
                    allowsInlineMediaPlayback: true,
                    useHybridComposition: true, // For Android
                    allowFileAccessFromFileURLs: true,
                    allowUniversalAccessFromFileURLs: true,
                    //debuggingEnabled: true,
                  ),
                  onWebViewCreated: (InAppWebViewController controller) async {
                    _webViewController = controller;
                    isDone = false;
                    await widget.onFinishedLoading(true);
                    // await clearSession();
                  },
                  onGeolocationPermissionsShowPrompt:
                      (controller, origin) async {
                    return GeolocationPermissionShowPromptResponse(
                        origin: origin, allow: true, retain: true);
                  },
                  onConsoleMessage: (controller, message) async {
                    // if (message.message == 'DoneLoadingVolley5544Web'){
                    //   Navigator.of(context, rootNavigator: true).pop(); // Use `context` directly to close the dialog
                    //   print(message.message);
                    // }
                    if (message.message.contains('VersionOfVolley5544WebIs:')) {
                      print(message.message);
                      // int clientWebVersion =
                      //     int.parse('${message.message.split(':')[1]}');
                      // int latestWebVersion = FFAppState().isProduction
                      //     ? int.parse(
                      //         '${FFAppState().appConfig['web_latest_version']}')
                      //     : int.parse(
                      //         '${FFAppState().appConfig['web_latest_version_uat']}');
                      // print('weblatestWebVersion:${latestWebVersion}');
                      // if (clientWebVersion < latestWebVersion) {
                      //   _webViewController = controller;
                      //   clearSession();
                      //   _webViewController.reload();
                      // } else {
                      //   isDone = true;
                      // }
                      // if (isDone) {
                      await widget.onFinishedLoading(false);
                      // setState(() {
                      //   AppState().isShowAppBarWebviewPage = false;
                      // });
                      // safeSetState((){});
                      Navigator.of(context, rootNavigator: true)
                          .pop(); // Use `context` directly to close the dialog
                      // }
                    }
                    if (message.message
                        .contains('openTableauBrowserVolley5544')) {
                      print(message.message);
                      String webUrl =
                          '${message.message.split('Volley5544')[1]}';

                      await openTableauBrowser('', '${webUrl}', true);
                    }
                    if (message.message.contains('LaunchUrlInAppVolley5544')) {
                      print(message.message);
                      String webUrl =
                          '${message.message.split('Volley5544')[1]}';

                      await launchURL('${webUrl}');
                    }

                    if (message.message.contains('shareLinkVolley5544')) {
                      List<String> paramFromWeb =
                          message.message.split('Volley5544');
                      DateTime currentDateTime = DateTime.now();
                      String linkTextShare = paramFromWeb[1];

                      final params = ShareParams(
                        text: '${linkTextShare}', // ${paramFromWeb[0]}
                        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
                      );

                      final result = await SharePlus.instance.share(params);
                      if (result.status == ShareResultStatus.success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Thank you for sharing the QR code!")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Sharing canceled or failed.")),
                        );
                      }
                    }

                    if (message.message.contains('ShareImageInAppVolley5544')) {
                      List<String> paramFromWeb =
                          message.message.split('ShareImageInAppVolley5544');
                      DateTime currentDateTime = DateTime.now();
                      String base64Output = paramFromWeb[1];
                      Uint8List imageBytes =
                          await compute(base64Decode, base64Output);

                      // final result1 = await ImageGallerySaver.saveImage(
                      //   Uint8List.fromList(imgBytes!),
                      //   quality: 100,
                      //   name: "QR-img_${currentDateTime}",
                      // );

                      final xfile = XFile.fromData(
                        imageBytes,
                        mimeType: 'image/png',
                        name: 'qr_refer_share.png',
                      );

                      final params = ShareParams(
                        text: '${paramFromWeb[0]}', // ${paramFromWeb[0]}
                        files: [xfile],
                        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
                      );

                      final result = await SharePlus.instance.share(params);
                      if (result.status == ShareResultStatus.success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Thank you for sharing the QR code!")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Sharing canceled or failed.")),
                        );
                      }
                    }

                    if (message.message.contains('CameraAction5544')) {
                      // await openTableauBrowser(
                      //     '', 'https://genshin.hoyoverse.com/en/gift', true);
                      print('triggersss');
                      print('${message.message.split('CameraAction5544')[1]}');
                      XFile? text5544 = null;
                      if ('${message.message.split('CameraAction5544')[1]}' ==
                              'normal' ||
                          '${message.message.split('CameraAction5544')[1]}' ==
                              '') {
                        // File? _vehicle;
                        // File? _circleTag;
                        final ImagePicker _picker = ImagePicker();

                        final pickedFile = await _picker.pickImage(
                            source: ImageSource.camera,
                            imageQuality: 50,
                            maxWidth: 1920,
                            maxHeight: 1920);
                        safeSetState(() {
                          text5544 = pickedFile;
                        });
                      } else {
                        // await showDialog(
                        //   barrierDismissible: false,
                        //   context: context,
                        //   builder: (dialogContext) {
                        //     return Dialog(
                        //       elevation: 0,
                        //       insetPadding: EdgeInsets.zero,
                        //       backgroundColor: Colors.transparent,
                        //       alignment: AlignmentDirectional(0.0, 0.0)
                        //           .resolve(Directionality.of(context)),
                        //       child: GestureDetector(
                        //         onTap: () {
                        //           FocusScope.of(dialogContext).unfocus();
                        //           FocusManager.instance.primaryFocus?.unfocus();
                        //         },
                        //         child: CapturePictureSelfieIdcard(
                        //           width: 300,
                        //           height: 500,
                        //           imagesType:
                        //               '${message.message.split('CameraAction5544')[1]}',
                        //         ),
                        //       ),
                        //     );
                        //   },
                        // ).then((value) => safeSetState(() => text5544 = value));
                      }

                      // await Navigator.pushNamed(context, '/capture-picture-page',
                      //     arguments: {'imagesType': 'idCard'});
                      print('CameraAction5544');
                      if (text5544 != null) {
                        _webViewController = controller;
                        String idCardBase64 =
                            await convertImageToString(text5544);

                        // idCardBase64 = '${message.message.split('CameraAction5544')[0]}' + idCardBase64;

                        //                     await _webViewController.evaluateJavascript(
                        //                         source: """
                        //   window.dispatchEvent(new CustomEvent('fromFlutterMobile', { detail: {}'${idCardBase64}',actionName: '${message.message.split('CameraAction5544')[0]}' }));
                        // """
                        //                     );
                        await _webViewController.evaluateJavascript(source: """
    window.dispatchEvent(new CustomEvent('fromFlutterMobile', { 
      detail: { 
        dataBase64: '${idCardBase64}', 
        actionName: '${message.message.split('CameraAction5544')[0]}'
      } 
    }));
  """, contentWorld: ContentWorld.PAGE);
                      }
                    }

                    if (message.message ==
                        ('CloseWebviewPageFromVolley5544Web')) {
                      await widget.closeWebviewAction();
                    }
                  },
                  onDownloadStartRequest: (controller, url) async {
                    print('onDownloadWebview : ${url}');
                    if ('${url.url}'.contains('base64')) {
                      DateTime currentDateTime = DateTime.now();
                      Uint8List? imgBytes = await convertBase64ToFileBytes(
                          '${url.url}', 'QR-img_${currentDateTime}');
                      final result1 = await ImageGallerySaverPlus.saveImage(
                        Uint8List.fromList(imgBytes!),
                        quality: 100,
                        name: "QR-img_${currentDateTime}",
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Thank you for sharing the picture!',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context).secondary,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor:
                              FlutterFlowTheme.of(context).primaryText,
                        ),
                      );
                    } else {
                      await launchURL('${url}');
                    }
                  },
                  onPermissionRequest: (controller, request) async {
                    return await PermissionResponse(
                        resources: request.resources,
                        action: PermissionResponseAction.GRANT);
                    // }),
                    // try {
                    //   var cameraStatus = await Permission.camera.request();
                    //   var micStatus = await Permission.microphone.request();
                    //   if (cameraStatus.isDenied) {
                    //     await Permission.camera.request();
                    //   }
                    //   return PermissionResponse(
                    //       action: PermissionResponseAction.GRANT,
                    //       resources: [
                    //         PermissionResourceType
                    //             .CAMERA_AND_MICROPHONE,
                    //       ]);
                    // } catch (e) {
                    //   return PermissionResponse(
                    //       action: PermissionResponseAction.PROMPT,
                    //       resources: [
                    //         PermissionResourceType
                    //             .CAMERA_AND_MICROPHONE,
                    //       ]);
                    // }
                    // return await PermissionResponse(
                    //     resources: [
                    //       PermissionResourceType.CAMERA_AND_MICROPHONE,
                    //       PermissionResourceType.CAMERA,
                    //       PermissionResourceType.MICROPHONE,
                    //       PermissionResourceType.FILE_READ_WRITE,
                    //       PermissionResourceType.GEOLOCATION,
                    //     ],
                    //     action: PermissionResponseAction.GRANT);
                  }),
              // onPermissionRequest: (InAppWebViewController controller,
              //     String origin, List<String> resources) async {
              //   return PermissionRequestResponse(
              //       resources: resources,
              //       action: PermissionRequestResponseAction.GRANT);
              // }),
            ),
          ),
        ]),
      ),
    );
  }
}

Future<Uint8List?> convertBase64ToFileBytes(
    String? imageBase64, String? index) async {
  // Add your function code here!
  String base64Output = imageBase64!.split(',')[1];

  Uint8List imageBytes = await compute(base64Decode, base64Output);

  // final mimeType = lookupMimeType('', headerBytes: imageBytes);
  // final fileExtension = extensionFromMime(mimeType!);
  //
  // print('MIME type: $mimeType');
  // print('File extension: $fileExtension');

  return imageBytes;
}

Future<void> clearSession() async {
  await InAppWebViewController.clearAllCache(includeDiskFiles: true);
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
