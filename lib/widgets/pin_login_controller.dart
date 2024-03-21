import 'dart:async';
import 'dart:math';
import 'package:devicelocale/devicelocale.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/services/localStorage/pin_local_storage.dart';
import 'package:mobile_application_srisawad/services/notification.dart';
import 'package:mobile_application_srisawad/widgets/bottompage.dart';
import 'package:mobile_application_srisawad/widgets/dialog/enable_local_authentication_dialog.dart';
import 'package:mobile_application_srisawad/widgets/main_bottom_navigation_v2.dart';
import 'package:mobile_application_srisawad/widgets/pin_widget.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import '../bloc/register_bloc/register_bloc.dart';
import '../connector/firestore/notify.dart';
import '../models/notify_model.dart';
import '../models/register.dart';
import '../modules/authLogin/index.dart';
import '../modules/authRegister/index.dart';
import '../services/localStorage/penalty_storage.dart';
import '../util/authentication_type.dart';
import '../util/check_string_format.dart';
import '../util/custom_exception.dart';
import '../util/logger_service.dart';
import '../util/time.dart';
import 'dialog/incorrect_pin.dart';
import 'dialog/open_app_setting_dialog.dart';
import 'dialog/penalty_countdown.dart';
import 'dialog/progress_box_dialog.dart';
import 'dialog/server_suspended_dialog.dart';
import 'flash/notify_top_flash.dart';
import '../../services/localStorage/local_storage.dart' as localStorage;
import 'pin_warning_message.dart';

class PinLoginController extends StatefulWidget {
  String existingPin;
  String hashThaiId;
  String phoneNumber;
  bool? isRegister;

  PinLoginController(
      {Key? key,
      this.existingPin = '',
      this.hashThaiId = '',
      this.phoneNumber = '',
      this.isRegister})
      : super(key: key);

  @override
  State<PinLoginController> createState() => _PinLoginControllerState();
}

class _PinLoginControllerState extends State<PinLoginController> {
  var localStorageObject = localStorage.LocalStoragePrefernces();
  var userLogin = UserLogin();
  String subTitle =
      'กรุณาตั้งค่ารหัสผ่านสำหรับใช้เข้า\nแอปพลิเคชันครั้งถัดไป'; // 'กรุณาใส่รหัสผ่านเพื่อเข้าสู่แอปพลิเคชัน';
  String MainTitle = 'ตั้งค่ารหัสผ่าน'; // 'ใส่รหัสผ่าน';
  String firstPin = '';
  String warningMessage = '';
  bool isSecondPage = false;
  bool showLeading = false;
  bool showCloser = false;
  final maxCounter = 3;
  bool alreadyShowPenalty = false;
  bool showAuthenticationButton = false;

  bool _lockPin = false;
  int _failedCounter = 1;
  int _timer = 0;
  int _nextPenaltyTime = 0;
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void dispose() {
    warningMessage = '';
    super.dispose();
  }

  initialPenalty() async {
    final pnt = await getPenalty();
    setState(() {
      final tmpTimer = pnt.nextPenaltyTime - getCurrentSecond() as int;
      if (pnt.lockPin && tmpTimer > 0) {
        penaltyCountDown(context, tmpTimer);
        Future.delayed(Duration(seconds: tmpTimer), () {
          setState(() {
            _failedCounter += 1;
            _lockPin = false;
          });

          setPenalty(false, _failedCounter, _timer, _nextPenaltyTime);
        });
        _lockPin = pnt.lockPin;
        Timer.periodic(new Duration(seconds: 1), (timer) {
          if (_timer == 1) {
            timer.cancel();
          }
          setState(() {
            _timer = _timer - 1;
          });
        });
      }

      // _lockPin = pnt.lockPin;
      _failedCounter = pnt.failedCounter;
      _timer = pnt.timer;
      _nextPenaltyTime = pnt.nextPenaltyTime;
    });
  }

  void tokenListener() {
    FirebaseAuth.instance.idTokenChanges().listen((user) async {
      try {
        String userToken = await user!.getIdToken(true);
        localStorageObject.setLocalStorage('userToken', userToken, 'string');
      } catch (e) {
        logger.e('Token chagned error!: ${e}');
      }
    });
  }

  Future<void> checkVerify() async {
    try {
      dynamic userIdFromLocalStorage =
          await localStorageObject.getLocalStorage('userId', 'string');
      dynamic phoneNumberFromLocalStorage =
          await localStorageObject.getLocalStorage('phoneNumber', 'string');
      var authaug = AuthRegister();
      RegisterVerfiy result = await authaug.verfiyUser(
        userIdFromLocalStorage.toString(),
        phoneNumberFromLocalStorage.toString(),
      );
      context.read<RegisterBloc>().state.isValidated =
          result.isExistingCustomer;
      if (widget.existingPin.isEmpty) {
        Navigator.of(context, rootNavigator: true).pop();
        await ShowBottomSvgVersion(
          context,
          widget.isRegister! ? 'สมัครสมาชิกสำเร็จ' : 'ตั้งค่ารหัสผ่านสำเร็จ',
          'assets/success-icon.svg',
          widget.isRegister!
              ? 'คุณได้ทำการสมัครสมาชิก\nแอปพลิเคชันศรีสวัสดิ์เรียบร้อยแล้ว'
              : 'คุณได้ทำการตั้งค่ารหัสผ่านสำหรับเข้า\nแอปพลิเคชันศรีสวัสดิ์เรียบร้อยแล้ว',
          () async {
            BlocProvider.of<PageResultBloc>(context)
                .add(SetButtonNavigator(true));
            BlocProvider.of<PageResultBloc>(context)
                .add(SetCurrentNavBarIndex(0));
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/home-page',
              (route) => false,
            );
          },
          'เข้าสู่แอปพลิเคชัน',
          enableDrag: false,
        );
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
        BlocProvider.of<PageResultBloc>(context).add(SetCurrentNavBarIndex(0));
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/home-page',
          (route) => false,
        );
      }
    } on RESTApiException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      logger.e(
          'Caught error in verfiyUser(RESTApiException) :${e.cause.toString()} ');
      serverSuspendedDialog(context);
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      logger.e('Caught error in verfiyUser :${e.toString()} ');
      serverSuspendedDialog(context);
    }
  }

  @override
  void initState() {
    super.initState();
    initialPenalty();
    if (widget.existingPin.isNotEmpty) {
      setState(() {
        MainTitle = 'ใส่รหัสผ่าน';
        subTitle = 'กรุณาใส่รหัสผ่านเพื่อเข้าสู่แอปพลิเคชัน';
        isSecondPage = true;
        firstPin = widget.existingPin;
      });
      checkLocalAuthentication();
    }
    tokenListener();
    super.initState();
  }

  void checkCurrentPin(String textInput) async {
    if (_lockPin) {
      final res = _nextPenaltyTime - getCurrentSecond() as int;
      setState(() {
        warningMessage = messageConfig['fail']!;
      });
      penaltyCountDown(context, res);
      return;
    }

    if (!isSecondPage) {
      if (isStringDuplicate(textInput)) {
        setState(() {
          warningMessage = messageConfig['duplicate']!;
        });
      } else
        setState(() {
          showLeading = true;
          warningMessage = '';
          isSecondPage = true;
          firstPin = textInput;
          MainTitle = 'ยืนยันตั้งค่ารหัสผ่าน';
          subTitle = 'กรุณายืนยันรหัสผ่านสำหรับใช้เข้า\nแอปพลิเคชันครั้งถัดไป';
        });
    } else if (isSecondPage) {
      if (firstPin != textInput) {
        setState(() {
          warningMessage = messageConfig['fail']!;
        });
        if (widget.existingPin.isNotEmpty) {
          if (_failedCounter >= 3) {
            int _increaseTime = (pow(2, _failedCounter - 3) as int) * 60;
            final cr = getCurrentSecond();
            _nextPenaltyTime = cr + _increaseTime;
            _timer = _increaseTime;
            int countTime = _nextPenaltyTime - cr as int;
            if (_timer > 1) {
              setPenalty(true, _failedCounter, _increaseTime, _nextPenaltyTime);
              Timer.periodic(new Duration(seconds: 1), (timer) {
                if (_timer == 1) {
                  timer.cancel();
                }
                if (!mounted) {
                  timer.cancel();
                  return;
                }
                setState(() {
                  _timer = _timer - 1;
                });
              });
              // with exising Pin but Fail
              penaltyCountDown(context, countTime);
              _lockPin = true;
              Future.delayed(Duration(seconds: _timer), () {
                _lockPin = false;
                setPenalty(false, _failedCounter, _timer, _nextPenaltyTime);
              });
            }
          } else {
            inCorrectPin(context, () {
              setPenalty(true, _failedCounter, _timer, _nextPenaltyTime);
              Navigator.of(context, rootNavigator: true).pop('dialog');
              // penaltyCountDown(context, _timer);
            }, maxCounter - _failedCounter);
          }
          setState(() {
            _failedCounter += 1;
          });
        }
      } else if (firstPin == textInput) {
        showProgressBoxDialog(context: context);
        setState(() {
          warningMessage = '';
        });
        final user = await FirebaseAuth.instance.currentUser;
        await user!.getIdTokenResult();
        hashThaiId = user.uid;
        createNotificationReciever(user.uid);

        final pinRes =
            await setPin(textInput, widget.hashThaiId, widget.phoneNumber);
        await setBackupPin(pinRes);
        await setPenalty(false, 1, 0, 0);
        // if (widget.existingPin.isEmpty) {
        //   await ShowBottomSvgVersion(
        //     context,
        //     widget.isRegister! ? 'สมัครสมาชิกสำเร็จ' : 'ตั้งค่ารหัสผ่านสำเร็จ',
        //     'assets/success-icon.svg',
        //     widget.isRegister!
        //         ? 'คุณได้ทำการสมัครสมาชิก\nแอปพลิเคชันศรีสวัสดิ์เรียบร้อยแล้ว'
        //         : 'คุณได้ทำการตั้งค่ารหัสผ่านสำหรับเข้า\nแอปพลิเคชันศรีสวัสดิ์เรียบร้อยแล้ว',
        //     () async {
        //       navigateToHome();
        //     },
        //     'เข้าสู่แอปพลิเคชัน',
        //     enableDrag: false,
        //   );
        // } else {
        navigateToHome();
        //}
      }
    }
    ;
  }

  Future<void> navigateToHome() async {
    await checkVerify();
  }

  @override
  Widget build(BuildContext context) {
    return PinWidget(
        verifyPinCode: checkCurrentPin,
        mainTitle: MainTitle,
        subTitle: subTitle,
        closerButton: () {
          if (isSecondPage && widget.existingPin.isEmpty) {
            setState(() {
              isSecondPage = false;
              showLeading = false;
              firstPin = '';
              subTitle =
                  'กรุณาตั้งค่ารหัสผ่านสำหรับใช้เข้า\nแอปพลิเคชันครั้งถัดไป';
              MainTitle = 'ตั้งค่ารหัสผ่าน';
            });
          }
        },
        warningMessage: warningMessage,
        showLeading: showLeading,
        showCloser: showCloser,
        showResetPasscode: widget.existingPin.isNotEmpty,
        onLeadButtonClick: () {
          if (widget.existingPin.isEmpty) {
            setState(() {
              isSecondPage = false;
              showLeading = false;
              firstPin = '';
              subTitle =
                  'กรุณาตั้งค่ารหัสผ่านสำหรับใช้เข้า\nแอปพลิเคชันครั้งถัดไป';
              MainTitle = 'ตั้งค่ารหัสผ่าน';
            });
          }
        },
        authenticationType: authenticationType,
        onClickAuthenticationButton: () async {
          bool? enableLocalAuthentication =
              await userLogin.checkEnableLocalAuthentication();
          if (enableLocalAuthentication != null && enableLocalAuthentication) {
            callAuthentication();
          } else {
            showEnableLocalAuthenticationDialog();
          }
        });
  }

  var authenticationType = AuthenticationType.None;

  Future<void> checkLocalAuthentication() async {
    // await removeLocalAuthenticationLocalStorage();
    final bool isDeviceSupported = await auth.isDeviceSupported();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    if (isDeviceSupported && canAuthenticateWithBiometrics) {
      var availableBiometrics = await auth.getAvailableBiometrics();
      if (availableBiometrics.isNotEmpty) {
        setState(() {
          if (availableBiometrics.contains(BiometricType.strong)) {
            authenticationType = AuthenticationType.FaceAndTouch;
          } else if (availableBiometrics.contains(BiometricType.fingerprint) &&
                  (availableBiometrics.contains(BiometricType.face)) ||
              availableBiometrics.contains(BiometricType.iris)) {
            authenticationType = AuthenticationType.FaceAndTouch;
          } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
            authenticationType = AuthenticationType.Touch;
          } else if (availableBiometrics.contains(BiometricType.face) ||
              availableBiometrics.contains(BiometricType.iris)) {
            authenticationType = AuthenticationType.Face;
          }
        });
        bool? enableLocalAuthentication =
            await userLogin.checkEnableLocalAuthentication();
        if (enableLocalAuthentication != null) {
          if (enableLocalAuthentication) {
            callAuthentication();
          }
        } else {
          showEnableLocalAuthenticationDialog();
        }
      }
    }
  }

  Future<void> showEnableLocalAuthenticationDialog() async {
    enableLocalAuthenticationDialog(context, authenticationType, (isEnable) {
      saveEnableLocalAuthentication(isEnable);
    });
  }

  Future<void> saveEnableLocalAuthentication(bool isEnable) async {
    await userLogin.setEnableLocalAuthentication(isEnable);
    if (isEnable) {
      callAuthentication();
    }
  }

  Future<void> callAuthentication() async {
    var availableBiometrics = await auth.getAvailableBiometrics();
    try {
      var reasonString = await getLocalizedReason();
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: reasonString,
          options: const AuthenticationOptions(biometricOnly: true));
      if (didAuthenticate) {
        showProgressBoxDialog(context: context);
        final user = await FirebaseAuth.instance.currentUser;
        await user!.getIdTokenResult();
        hashThaiId = user.uid;
        bool isPinExist = await isVaildPin();
        if (!isPinExist) {
          final backupPin = await getBackupPin(user.uid);
          await setPin(
              backupPin.pin, backupPin.hashThaiId, backupPin.phoneNumber);
        }

        createNotificationReciever(user.uid);
        logger.i('and user id =  enter services called! >${user.uid}<');

        navigateToHome();
      }
    } on PlatformException catch (e) {
      logger.e("PlatformException code:" + e.code);
      logger.e("PlatformException message:" + e.message.toString());
      if (e.code == auth_error.notAvailable &&
          authenticationType == AuthenticationType.Face &&
          availableBiometrics.isEmpty) {
        openFaceIDSettingDialog();
      }
    }
  }

  Future<String> getLocalizedReason() async {
    var locale = await Devicelocale.currentLocale;
    if (locale.toString().toUpperCase().contains("TH")) {
      return "กรุณายืนยันตัวตนเพื่อเข้าใช้งานแอปพลิเคชัน";
    } else {
      return "Please authenticate to access an application";
    }
  }

  void openFaceIDSettingDialog() {
    openAppSettingDialog(
        context: context,
        title: "ต้องการเปิดการใช้งานสแกนใบหน้า\nหรือไม่?",
        icon: SvgPicture.asset('assets/face-id-icon.svg', width: 48),
        detail:
            "เพื่ออนุญาตให้ใช้งานสแกนใบหน้าคุณจำเป็นต้องไปที่ตั้งค่าและกดเปิด Face ID");
  }
}
