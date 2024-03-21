import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/user_token/user_token_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/register.dart';
import 'package:mobile_application_srisawad/modules/authRegister/index.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';

import '../../connector/authentication/login_function.dart';
import '../../services/localStorage/penalty_storage.dart';
import '../../services/localStorage/pin_local_storage.dart';
import '../../util/logger_service.dart';
import '../../util/time.dart';
import '../../widgets/dialog/login_error.dart';
import '../../widgets/dialog/penalty_countdown.dart';
import '../../widgets/dialog/server_suspended_dialog.dart';

class ForgotPasscode extends StatefulWidget {
  const ForgotPasscode({Key? key}) : super(key: key);

  @override
  State<ForgotPasscode> createState() => _ForgotPasscodeState();
}

var phone = '';

final thaiidcontroller = MaskedTextController(mask: '0-0000-00000-00-0');
final phonenumbercontroller = MaskedTextController(mask: '000-000-0000');

class _ForgotPasscodeState extends State<ForgotPasscode> {
  onBackPress() async {
    final pnt = await getPenalty();
    final tmpTimer = pnt.nextPenaltyTime - getCurrentSecond() as int;
    if (pnt.lockPin && tmpTimer > 0) {
      late String existingPin = '';
      final bool _isValidPin = await isVaildPin();
      if (_isValidPin) {
        existingPin = (await getPin()).pin;
      } else {
        final backupPin = await getBackupPin(hashThaiId);
        if (backupPin.pin != 'null') {
          existingPin = backupPin.pin;
        }
      }
      Navigator.pushNamed(context, '/pin-page', arguments: {
        'existingPin': existingPin,
        'hashThaiId': hashThaiId,
        'phoneNumber': '',
        'isRegister': false
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ลืมรหัสผ่าน',
          style: GoogleFonts.notoSansThai(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: HexColor('#003063'),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            await onBackPress();
          },
          icon: SvgPicture.asset(
            'assets/back-icon.svg',
            height: 38,
            width: 38,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'กรุณากรอกข้อมูลเพื่อยืนยันตัวตนในการตั้งค่า\nรหัสผ่านใหม่',
              style: GoogleFonts.notoSansThai(
                color: HexColor('#003063'),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: thaiidcontroller,
                  // maxLength: 13,
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'X-XXXX-XXXXX-XX-X',
                      hintStyle: TextStyle(
                          height: 2.1,
                          color: HexColor('#DBDBDB'),
                          fontSize: 16),
                      label: Text(
                        'หมายเลขบัตรประชาชน',
                        style: GoogleFonts.notoSansThai(
                            fontSize: 18,
                            color: HexColor('#646464'),
                            fontWeight: FontWeight.w400),
                      )),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                TextField(
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    phone = value;
                  },
                  controller: phonenumbercontroller,
                  // maxLength: 10,
                  decoration: InputDecoration(
                      counterText: '',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: 'XXX-XXX-XXXX',
                      hintStyle: TextStyle(
                          height: 2.1,
                          color: HexColor('#DBDBDB'),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      errorText: phonenumbercontroller.text.length == 12 ||
                              thaiidcontroller.text.isEmpty
                          ? null
                          : 'กรุณากรอกเบอร์โทรศัพท์มือถือให้ครบ 10 หลัก',
                      label: Text(
                        'เบอร์โทรศัพท์มือถือ',
                        style: GoogleFonts.notoSansThai(
                            fontSize: 18,
                            color: HexColor('#646464'),
                            fontWeight: FontWeight.w400),
                      )),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        width: MediaQuery.of(context).size.width * 0.90,
        height: 60,
        decoration: BoxDecoration(
            color: HexColor('#DB771A'),
            borderRadius: BorderRadius.circular(14)),
        child: BlocBuilder<UserTokenBloc, UserTokenState>(
          builder: (context, state) {
            return TextButton(
              onPressed: () async {
                FirebaseAnalytics.instance.logEvent(
                  name: ' reset_passcode_success',
                  parameters: {},
                );
                if (thaiidcontroller.text.length == 17 &&
                    phonenumbercontroller.text.length == 12) {
                  try {
                    final String thaiId =
                        thaiidcontroller.text.replaceAll('-', '');
                    final String phoneNumber =
                        phonenumbercontroller.text.replaceAll('-', '');
                    final authaug = AuthRegister();
                    RegisterVerfiy result = await authaug.verfiyUser(
                      thaiId,
                      phoneNumber,
                    );
                    bool docExists =
                        await LoginFunction.checkIfUserExists(thaiId, false);
                    if (result.isExistingCustomer == true && docExists) {
                      otpCallbackFunction() {
                        Navigator.pushNamed(context, '/pinotpsetup',
                            arguments: {
                              'phoneNumber': phoneNumber,
                              'thaiId': thaiId
                            });
                      }

                      Navigator.pushNamed(context, '/otp-page', arguments: {
                        'callbackFunction': otpCallbackFunction,
                        'phoneNumber': phoneNumber,
                      });
                      phonenumbercontroller.text = '';
                      thaiidcontroller.text = '';
                    } else {
                      loginWithErrorDialog(context);
                    }
                  } on RESTApiException catch (e) {
                    logger.e(
                        'forgot_passcode RESTApiException erorr ${e.cause.toString()}');
                    serverSuspendedDialog(context,
                        additionalText: e.cause.toString());
                  } catch (e) {
                    logger.e('forgot_passcode erorr ${e.toString()}');
                    serverSuspendedDialog(context);
                  }
                } else {
                  // TODO Add waring : Red front .
                }
              },
              child: Text(
                'ยืนยัน',
                style: GoogleFonts.notoSansThai(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: HexColor('#FFFFFF'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
