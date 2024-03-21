import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/user_token/user_token_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/otp_model.dart';
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';

import '../../modules/otp/index.dart';
import '../../util/color_util.dart';
import '../../util/time.dart';
import '../../widgets/dialog/otp_fail.dart';
import '../../widgets/dialog/server_suspended_dialog.dart';

const int COOLDOWN_TIME = 30;

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  final Function callbackFunction;

  OtpPage(OtpPageModel otpPageModel,
      {Key? key, required this.phoneNumber, required this.callbackFunction})
      : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int _delayTime = 0;
  bool _isLock = false;
  int _timer = 0;
  bool isValidOtp = false;
  bool shouldShowKeyboard = true;
  bool forceFocusLastDigit = false;
  bool isPinTextFieldFocus = true;

//
  late OtpAuth _otpAuth = OtpAuth(
    code: '',
    create_date: 1668485594187,
    ref: '',
  );
  bool isLoadingNewOtp = true;
  bool isOnSuccessLoading = false;

  fetchOtp() async {
    try {
      verfiyOtp(widget.phoneNumber).then((value) {
        setState(() {
          _otpAuth = value;
          isLoadingNewOtp = false;
        });
      }).catchError((e) {
        serverSuspendedDialog(context);
        Navigator.of(context).pop();
        setState(() {
          isLoadingNewOtp = false;
        });
      });
    } catch (e) {
      serverSuspendedDialog(context);
      Navigator.of(context).pop();
      setState(() {
        isLoadingNewOtp = false;
      });
    }
  }

  @override
  void initState() {
    fetchOtp();
    super.initState();
  }

  final pinController = TextEditingController(
    text: '',
  );

  String getInputPin() {
    return pinController.text;
  }

  @override
  Widget build(BuildContext contexts) {
    return BlocBuilder<UserTokenBloc, UserTokenState>(
      builder: (context, state) {
        final phoneNumberController = MaskedTextController(
            mask: '000-XXX-0000',
            text: widget.phoneNumber.substring(0, 3) +
                'XXX' +
                widget.phoneNumber.substring(6, 10));
        return isOnSuccessLoading
            ? ProgressLoading()
            : WillPopScope(
                onWillPop: () async {
                  return false;
                },
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: SvgPicture.asset('assets/back-icon.svg'),
                    ),
                    systemOverlayStyle: SystemUiOverlayStyle.dark,
                  ),
                  resizeToAvoidBottomInset: false,
                  body: isLoadingNewOtp
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : SafeArea(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 24,
                              horizontal: 20,
                            ),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    'กรุณายืนยันรหัส OTP',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .merge(TextStyle(
                                            fontFamily:
                                                'NotoSansThaiSemiBold')),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Center(
                                    child: Text(
                                  'กรุณาใส่รหัสยืนยันตัวตนที่ถูกส่ง\nไปยังหมายเลข',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.w500)),
                                  textAlign: TextAlign.center,
                                )),
                                SizedBox(
                                  height: 14,
                                ),
                                TextField(
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  controller: phoneNumberController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .merge(TextStyle(fontSize: 20)),
                                ),
                                Text(
                                  'หมายเลขอ้างอิง' + ' ' + _otpAuth.ref,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .merge(TextStyle(
                                          fontSize: 12, height: 1.58666667)),
                                ),
                                SizedBox(
                                  height: 22,
                                ),
                                Stack(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _textFieldOTP(index: 0),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        _textFieldOTP(index: 1),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        _textFieldOTP(index: 2),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        _textFieldOTP(index: 3),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        _textFieldOTP(index: 4),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        _textFieldOTP(
                                            index: 5,
                                            forceFocus: forceFocusLastDigit),
                                        Focus(
                                          child: SizedBox(),
                                        ),
                                        Focus(
                                          child: SizedBox(),
                                        )
                                      ],
                                    ),
                                    Opacity(
                                      opacity: 0,
                                      child: Container(
                                        height: 66,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: FocusScope(
                                          child: Focus(
                                            onFocusChange: (focus) {
                                              setState(() {
                                                isPinTextFieldFocus = focus;
                                                if (focus &&
                                                    pinController.text.length ==
                                                        6) {
                                                  forceFocusLastDigit = true;
                                                } else {
                                                  forceFocusLastDigit = false;
                                                }
                                              });
                                            },
                                            child: TextField(
                                              autofocus: shouldShowKeyboard,
                                              controller: pinController,
                                              onChanged: (value) {
                                                setState(() {
                                                  if (value.length == 6) {
                                                    isValidOtp = true;
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  } else {
                                                    isValidOtp = false;
                                                  }
                                                  forceFocusLastDigit = false;
                                                });
                                              },
                                              maxLength: 6,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (!_isLock) {
                                      setState(() {
                                        _timer = COOLDOWN_TIME;
                                        _delayTime =
                                            getCurrentSecond() + COOLDOWN_TIME;
                                        _isLock = true;
                                        isLoadingNewOtp = true;
                                      });
                                      Timer.periodic(new Duration(seconds: 1),
                                          (timer) {
                                        if (_timer <= 1) {
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
                                      Future.delayed(
                                          Duration(seconds: COOLDOWN_TIME), () {
                                        setState(() {
                                          _isLock = false;
                                        });
                                      });
                                      fetchOtp();
                                    }
                                  },
                                  child: Text(
                                    'ขอรหัสยืนยันอีกครั้ง ${_isLock ? '(${_timer})' : ''}',
                                    style: GoogleFonts.notoSansThai(
                                      decoration: TextDecoration.underline,
                                      color: _isLock
                                          ? Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.4)
                                          : Theme.of(context).primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 60,
                                  width: getActualWidth(context),
                                  decoration: BoxDecoration(
                                      color: isValidOtp
                                          ? HexColor('#DB771A')
                                          : HexColor('#FCEFE4'),
                                      borderRadius: BorderRadius.circular(14)),
                                  child: isValidOtp
                                      ? TextButton(
                                          onPressed: () async {
                                            setState(() {
                                              isOnSuccessLoading = true;
                                            });
                                            try {
                                              final String inputPin =
                                                  getInputPin();
                                              if (_otpAuth.code == inputPin &&
                                                  inputPin.length == 6) {
                                                await widget.callbackFunction();
                                                setState(() {
                                                  shouldShowKeyboard = false;
                                                  isOnSuccessLoading = false;
                                                });
                                              } else {
                                                setState(() {
                                                  isOnSuccessLoading = false;
                                                  shouldShowKeyboard = false;
                                                });
                                                await otpFailDialog(context);
                                              }
                                            } catch (e) {
                                              serverSuspendedDialog(context);
                                              setState(() {
                                                shouldShowKeyboard = false;
                                                isOnSuccessLoading = false;
                                              });
                                            }
                                          },
                                          child: Text(
                                            'ยืนยัน',
                                            style: GoogleFonts.notoSansThai(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        )
                                      : TextButton(
                                          onPressed: null,
                                          child: Text(
                                            'ยืนยัน',
                                            style: GoogleFonts.notoSansThai(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                )
                              ],
                            ),
                          ),
                        ),
                ),
              );
      },
    );
  }

  _textFieldOTP({required int index, bool forceFocus = false}) {
    final pinText = pinController.text;
    final isFocus =
        (pinText.length == index || forceFocus) && isPinTextFieldFocus;
    final pin =
        pinText.length > index ? pinText.characters.elementAt(index) : null;
    return Container(
      width: 44,
      height: 66,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: isFocus ? Colors.black12 : HexColor('#F0F0F0'),
            ),
            color: HexColor('#F6F6F6'),
          ),
          child: Center(
            child: Text(pin ?? "",
                style: GoogleFonts.notoSansThai(
                  color: HexColor(ColorUtil.SECONDARY),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  height: 1.4,
                )),
          ),
        ),
      ),
    );
  }
}
