import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/bloc/user_profile/user_profile_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/pin_model.dart';
import 'package:mobile_application_srisawad/pages/user_register/forgot_passcode.dart';
import 'package:mobile_application_srisawad/services/localStorage/pin_local_storage.dart';
import 'package:mobile_application_srisawad/widgets/bottompage.dart';
import 'package:mobile_application_srisawad/widgets/dialog/change_cancel.dart';
import 'package:mobile_application_srisawad/widgets/pin_widget.dart';

import '../util/check_string_format.dart';
import 'pin_warning_message.dart';

class PinChangeController extends StatefulWidget {
  const PinChangeController({Key? key}) : super(key: key);

  @override
  State<PinChangeController> createState() => _PinChangeControllerState();
}

class _PinChangeControllerState extends State<PinChangeController> {
  String subTitle = 'กรุณาใส่รหัสผ่านปัจจุบัน';
  int pinPageCount = 1;
  late String firstPin1 = '';
  late String firstPin2 = '';
  String warningMessage = '';
  bool showLeading = true;
  bool showCloser = false;

  void checkCurrentPin(String pin) async {
    if (pinPageCount == 1) {
      PinStorage existingPin = await getPin();
      if (existingPin.pin == pin) {
        setState(() {
          warningMessage = '';
          showCloser = true;
          showLeading = false;
          subTitle = 'ตั้งรหัสผ่านใหม่ 6 หลัก';
          firstPin1 = pin;
          pinPageCount = 2;
        });
      } else {
        setState(() {
          warningMessage = messageConfig['fail']!;
        });
      }
    } else if (pinPageCount == 2) {
      if (isStringDuplicate(pin)) {
        setState(() {
          warningMessage = messageConfig['duplicate']!;
        });
      } else
        setState(() {
          warningMessage = '';
          showLeading = true;
          subTitle = 'ยืนยันรหัสผ่านอีกครั้ง';
          firstPin2 = pin;
          pinPageCount = 3;
        });
    } else if (pinPageCount == 3) {
      if (firstPin2 == pin) {
        final UserProfileState userProfileBloc =
            BlocProvider.of<UserProfileBloc>(context).state;
        final pinRes = await setPin(pin, hashThaiId,
            userProfileBloc.userProfileData.phoneNumber.toString());
        await setBackupPin(pinRes);
        ShowBottomSvgVersion(
            context,
            'เปลี่ยนรหัสผ่านสำเร็จ',
            'assets/success-icon.svg',
            'คุณได้เปลี่ยนรหัสผ่านในการเข้า\nแอปพลิเคชันเรียบร้อยแล้ว', () {
          BlocProvider.of<PageResultBloc>(context)
              .add(SetButtonNavigator(true));
          BlocProvider.of<PageResultBloc>(context)
              .add(SetCurrentNavBarIndex(0));
          Navigator.of(context).pushNamed('/home-page');
        }, 'กลับสู่หน้าหลัก', enableDrag: false);
        setState(() {
          warningMessage = '';
        });
      } else {
        setState(() {
          warningMessage = messageConfig['fail']!;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: PinWidget(
          verifyPinCode: checkCurrentPin,
          mainTitle: 'เปลี่ยนรหัสผ่าน',
          subTitle: subTitle,
          showLeading: showLeading,
          showCloser: showCloser,
          closerButton: () async {
            changeCancellingDialog(context, () async {
              BlocProvider.of<PageResultBloc>(context)
                  .add(SetButtonNavigator(true));
              BlocProvider.of<PageResultBloc>(context)
                  .add(SetCurrentNavBarIndex(3));
              await Navigator.pushNamedAndRemoveUntil(
                context,
                '/otherpage',
                (route) => false,
              );
            });
          },
          warningMessage: warningMessage,
          onLeadButtonClick: () async {
            if (pinPageCount == 1) {
              Navigator.of(context).pop();
              BlocProvider.of<PageResultBloc>(context)
                  .add(SetButtonNavigator(true));
            } else if (pinPageCount == 3) {
              var existingPin = await getPin();
              setState(() {
                warningMessage = '';
                showCloser = true;
                showLeading = false;
                subTitle = 'ตั้งรหัสผ่านใหม่ 6 หลัก';
                firstPin1 = existingPin.pin;
                pinPageCount = 2;
              });
            }
          }),
    );
  }
}
