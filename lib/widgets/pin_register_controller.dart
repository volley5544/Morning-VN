import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:mobile_application_srisawad/bloc/user_token/user_token_bloc.dart';
import 'package:mobile_application_srisawad/services/localStorage/pin_local_storage.dart';
import 'package:mobile_application_srisawad/widgets/bottompage.dart';
import 'package:mobile_application_srisawad/widgets/pin_widget.dart';

import '../util/check_string_format.dart';
import 'pin_warning_message.dart';

class PinController extends StatefulWidget {
  const PinController({Key? key}) : super(key: key);

  @override
  State<PinController> createState() => _PinControllerState();
}

class _PinControllerState extends State<PinController> {
  String subTitle = 'กรุณาตั้งค่ารหัสผ่านสำหรับใช้เข้า\nแอปพลิเคชันครั้งถัดไป';
  String MainTitle = 'ตั้งค่ารหัสผ่าน';
  String firstPin = '';
  String warningMessage = '';
  bool isShowLeadButton = false;

  void checkCurrentPin(String textInput) async {
    if (firstPin == '') {
      if (isStringDuplicate(textInput)) {
        setState(() {
          warningMessage = messageConfig['duplicate']!;
        });
      } else
        setState(() {
          isShowLeadButton = true;
          warningMessage = '';
          firstPin = textInput;
          MainTitle = 'ยืนยันตั้งค่ารหัสผ่าน';
        });
    } else if (firstPin != textInput) {
      setState(() {
        warningMessage = messageConfig['fail']!;
      });
    } else if (firstPin == textInput) {
      setState(() {
        warningMessage = '';
        isShowLeadButton = false;
      });

      final UserTokenState userTokenBloc =
          BlocProvider.of<UserTokenBloc>(context).state;
      // state.registerVerfiy.phoneNumber
      // TODO : Get hash-thai-id to set Pin below
      final pinRes = await setPin(
          textInput,
          sha256
              .convert(utf8.encode(userTokenBloc.registerVerfiy.thaiId ?? ''))
              .toString(),
          userTokenBloc.registerVerfiy.phoneNumber.toString());
      await setBackupPin(pinRes);
      ShowBottomSvgVersion(
          context,
          'สมัครสมาชิกสำเร็จ',
          'assets/success-icon.svg',
          'คุณได้ทำการสมัครสมาชิก\nแอปพลิเคชันศรีสวัสดิ์เรียบร้อยแล้ว', () {
        Navigator.pushNamed(context, '/user-detail');
      }, 'เข้าสู่แอปพลิเคชัน', enableDrag: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PinWidget(
      verifyPinCode: checkCurrentPin,
      mainTitle: MainTitle,
      subTitle: subTitle,
      closerButton: () {
        if (isShowLeadButton) {
          setState(() {
            subTitle =
                'กรุณาตั้งค่ารหัสผ่านสำหรับใช้เข้า\nแอปพลิเคชันครั้งถัดไป';
            MainTitle = 'ตั้งค่ารหัสผ่าน';
            firstPin = '';
            warningMessage = '';
            isShowLeadButton = false;
          });
        }
      },
      showLeading: isShowLeadButton,
      warningMessage: warningMessage,
      showCloser: false,
      onLeadButtonClick: () {
        setState(() {
          subTitle = 'กรุณาตั้งค่ารหัสผ่านสำหรับใช้เข้า\nแอปพลิเคชันครั้งถัดไป';
          MainTitle = 'ตั้งค่ารหัสผ่าน';
          firstPin = '';
          warningMessage = '';
          isShowLeadButton = false;
        });
      },
    );
  }
}
