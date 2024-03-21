import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_srisawad/services/localStorage/pin_local_storage.dart';
import 'package:mobile_application_srisawad/widgets/bottompage.dart';
import 'package:mobile_application_srisawad/widgets/dialog/change_cancel.dart';
import 'package:mobile_application_srisawad/widgets/pin_widget.dart';

import '../bloc/page_result/page_result_bloc.dart';
import '../services/localStorage/penalty_storage.dart';
import '../util/check_string_format.dart';
import 'pin_warning_message.dart';

class PinForgotController extends StatefulWidget {
  final String phoneNumber;
  final String thaiId;
  const PinForgotController(
      {Key? key, required this.phoneNumber, required this.thaiId})
      : super(key: key);

  @override
  State<PinForgotController> createState() => _PinForgotControllerState();
}

class _PinForgotControllerState extends State<PinForgotController> {
  String mainTile = 'ตั้งค่ารหัสผ่าน';
  String subTitle = 'ตั้งรหัสผ่านใหม่ 6 หลัก';

  String firstPin = '';
  String warningMessage = '';
  bool isShowLeadButton = false;
  void checkCurrentPin(String pin) async {
    if (firstPin == '') {
      if (isStringDuplicate(pin)) {
        setState(() {
          warningMessage = messageConfig['duplicate']!;
        });
      } else
        setState(() {
          isShowLeadButton = true;
          warningMessage = '';
          mainTile = 'ยืนยันตั้งค่ารหัสผ่าน';
          subTitle = 'ยืนยันรหัสผ่านอีกครั้ง';
          firstPin = pin;
        });
    } else if (firstPin != pin) {
      setState(() {
        warningMessage = messageConfig['fail']!;
      });
    } else if (firstPin == pin) {
      final pinRes = await setPin(
          pin,
          sha256.convert(utf8.encode(widget.thaiId ?? '')).toString(),
          widget.phoneNumber.toString());
      await setBackupPin(pinRes);
      await setPenalty(false, 1, 0, 0);
      await ShowBottomSvgVersion(
        context,
        'ตั้งค่ารหัสผ่านสำเร็จ',
        'assets/success-icon.svg',
        'คุณได้ทำการตั้งค่ารหัสผ่านสำหรับเข้า\nแอปพลิเคชันศรีสวัสดิ์เรียบร้อยแล้ว',
        () {
          Navigator.of(context).pushNamed('/pin-page', arguments: {
            'existingPin': pin,
            'hashThaiId': '',
            'phoneNumber': '',
            'isRegister': false
          });
        },
        'เข้าสู่แอปพลิเคชัน',
        enableDrag: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PinWidget(
      verifyPinCode: checkCurrentPin,
      mainTitle: mainTile,
      subTitle: subTitle,
      showLeading: isShowLeadButton,
      closerButton: () {
        if (isShowLeadButton) {
          setState(() {
            isShowLeadButton = false;
            warningMessage = '';
            mainTile = 'ตั้งค่ารหัสผ่าน';
            subTitle = 'ตั้งรหัสผ่านใหม่ 6 หลัก';
            firstPin = '';
          });
        } else {
          changeCancellingDialog(context, () async {
            final pinObj = await getPin();
            Navigator.of(context).pushNamed('/pin-page', arguments: {
              'existingPin': pinObj.pin,
              'hashThaiId': '',
              'phoneNumber': '',
              'isRegister': false
            });
            BlocProvider.of<PageResultBloc>(context)
                .add(SetButtonNavigator(false));
          });
        }
      },
      warningMessage: warningMessage,
      onLeadButtonClick: () {
        setState(() {
          isShowLeadButton = false;
          warningMessage = '';
          mainTile = 'ตั้งค่ารหัสผ่าน';
          subTitle = 'ตั้งรหัสผ่านใหม่ 6 หลัก';
          firstPin = '';
        });
      },
    );
  }
}
