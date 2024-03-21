import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/check_version_response_model.dart';
import 'package:mobile_application_srisawad/models/pin_model.dart';
import 'package:mobile_application_srisawad/services/localStorage/local_storage.dart';
import 'package:mobile_application_srisawad/services/localStorage/pin_local_storage.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/widgets/dialog/force_logout_dialog.dart';
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';
import 'package:mobile_application_srisawad/widgets/text_compent.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'dart:io' show Platform, exit;
import '../connector/firestore/notify.dart';
import '../modules/version/index.dart';
import '../util/logger_service.dart';
import 'buttons/primary_button.dart';

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const StatefulWrapper({required this.onInit, required this.child});

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    inistalGetSaveData();
    widget.onInit();
    super.initState();
  }

  void inistalGetSaveData() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class MiddenSrceenLoading extends StatelessWidget {
  const MiddenSrceenLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
        onInit: () async {
          await [Permission.location].request();
          if (await Permission.location.isGranted) {
            googleMapValueHandler.determinePosition().then((value) {
              LocalStoragePrefernces localStoragePrefernces =
                  LocalStoragePrefernces();
              localStoragePrefernces.setLocalStorage(
                  'userLocation',
                  '{"lat" : "${value.latitude}", "lng" : "${value.longitude}"}',
                  'string');
            });
          }
          _getThingsOnStartup(context).then((value) {});
        },
        child: ProgressLoading());
  }

  Future _getThingsOnStartup(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    var needUpdateResult = await checkUpdateVersion();
    if (needUpdateResult.needUpdate) {
      showForceUpdateDialog(context, needUpdateResult);
    } else {
      await checkPin(context);
    }
  }

  Future<void> checkPin(BuildContext context) async {
    bool alreadySignIn = await isVaildPin();
    final user = await FirebaseAuth.instance.currentUser;
    if (alreadySignIn && user != null) {
      hashThaiId = user.uid;
      final notiClient = NotifyConnector(hashThaiId);
      var serverFCM = await notiClient.getFcmToken();
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (serverFCM == fcmToken) {
        PinStorage pin = await getPin();
        Navigator.pushNamed(context, '/pin-page', arguments: {
          'existingPin': pin.pin,
          'hashThaiId': '',
          'phoneNumber': ''
        });
      } else {
        showForceLogOutDialog(context);
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/intro-page',
        (route) => false,
      );
    }
  }

  void showForceUpdateDialog(
      BuildContext context, CheckVersionResponseModel needUpdateResult) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 25, left: 0, right: 0),
                    child: LottieBuilder.asset('assets/update.json')),
                SizedBox(
                  height: 21,
                ),
                TextTitle("กรุณาอัปเดตแอปพลิเคชัน").styleSecondary(),
                SizedBox(height: 6),
                Body("แอปพลิเคชันศรีสวัสดิ์มีเวอร์ชันใหม่\nอัปเดตเพื่อประสบการณ์การใช้งานที่ดีขึ้น",
                        TextAlign.center)
                    .styleLightGrey(),
                SizedBox(height: 18),
                PrimaryButton(
                    textButton: 'อัปเดต',
                    CallBack: () async {
                      String? storeUrl;
                      if (Platform.isIOS) {
                        storeUrl = needUpdateResult.appStoreUrl;
                      } else {
                        storeUrl = needUpdateResult.playStoreUrl;
                      }
                      try {
                        if (storeUrl != null && storeUrl.isNotEmpty) {
                          await launchUrlString(storeUrl,
                              mode: LaunchMode.externalApplication);
                        } else {
                          await launchUrlString(
                              'https://play.google.com/store/apps/details?id=com.interm.mobile_application_srisawad',
                              mode: LaunchMode.externalApplication);
                        }
                      } finally {
                        if (Platform.isIOS) {
                          exit(0);
                        } else {
                          SystemNavigator.pop();
                        }
                      }
                    },
                    padding: const EdgeInsets.only(),
                    width: double.infinity)
              ],
            ),
          );
        });
  }

  checkUpdateVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    var service = VersionRepository();
    try {
      return service.checkNeedUpdateVersion(version);
    } on RESTApiException catch (e) {
      logger.e(
          'Caught RESTApiException error in updateUserProfile :${e.cause.toString()} ');
    } catch (e) {
      logger.e(
          'Caught RESTApiException error in updateUserProfile :${e.toString()} ');
    }
  }
}
