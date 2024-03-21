import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/register_bloc/register_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/register.dart';
import 'package:mobile_application_srisawad/modules/authRegister/index.dart';
import 'package:mobile_application_srisawad/modules/service.dart';
import 'package:mobile_application_srisawad/pages/user_process/login_page.dart';
import 'package:mobile_application_srisawad/bloc/user_token/user_token_bloc.dart'
    as authenBloc;
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/device_id.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'package:mobile_application_srisawad/widgets/bottompage.dart';
import 'package:mobile_application_srisawad/widgets/dialog/login_existing_user.dart';
import 'package:mobile_application_srisawad/widgets/dialog/reject_new_customer.dart';
import 'package:mobile_application_srisawad/widgets/dialog/server_suspended_dialog.dart';
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../connector/authentication/login_function.dart';
import '../../widgets/image_to_thaiid.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterFillPage extends StatefulWidget {
  const RegisterFillPage({Key? key}) : super(key: key);

  @override
  State<RegisterFillPage> createState() => _RegisterFillPageState();
}

class _RegisterFillPageState extends State<RegisterFillPage> {
  bool alreadyEnter = false;
  bool isLoading = false;
  var phone = '';

  final thaiidcontroller = MaskedTextController(mask: '0-0000-00000-00-0');
  final phonenumbercontroller = MaskedTextController(mask: '000-000-0000');
  final thaiIdMasking = MaskTextInputFormatter(
      mask: '#-####-#####-##-#',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final phoneMasking = MaskTextInputFormatter(
      mask: '###-###-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    setState(() {
      alreadyEnter = false;
    });
  }

  @override
  void dispose() {
    thaiidcontroller.dispose();
    phonenumbercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<authenBloc.UserTokenBloc, authenBloc.UserTokenState>(
        builder: (blocContext, state) {
      return isLoading
          ? ProgressLoading()
          : Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/header-background2.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  children: [
                    SafeArea(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              Future.delayed(const Duration(milliseconds: 500),
                                  () async {
                                Navigator.of(context).pushNamed('/intro-page');
                              });
                              // Navigator.of(context).pop();
                            },
                            icon: SvgPicture.asset('assets/back-icon.svg'),
                          ),
                        ],
                      ),
                    ),
                    const Image(
                      image: AssetImage('assets/srisawad-logo.png'),
                      height: 65,
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 19),
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'สมัครสมาชิก',
                              style: GoogleFonts.notoSansThai(
                                  color: HexColor('#003063'),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                            TextField(
                              keyboardType: TextInputType.phone,
                              controller: thaiidcontroller,
                              maxLength: 17,
                              decoration: InputDecoration(
                                  counterText: '',
                                  errorText: (thaiidcontroller.text.length !=
                                                  17 ||
                                              thaiidcontroller.text.isEmpty) &&
                                          alreadyEnter
                                      ? 'กรุณากรอกหมายเลขบัตรประชาชนให้ครบ 13 หลัก'
                                      : null,
                                  errorStyle: GoogleFonts.notoSansThai().merge(
                                      TextStyle(color: HexColor('#A02802'))),
                                  // contentPadding:
                                  errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor('#A02802'))),
                                  focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: HexColor('#A02802'))),
                                  hintText: 'X-XXXX-XXXXX-XX-X',
                                  hintStyle: TextStyle(
                                      height: 2.1,
                                      color: HexColor('#DBDBDB'),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(top: 18),
                                    child: ImageToThaiid(
                                        textController: thaiidcontroller),
                                  ),
                                  label: Text(
                                    'หมายเลขบัตรประชาชน',
                                    style: GoogleFonts.notoSansThai(
                                        fontSize: 18,
                                        color: HexColor('#646464'),
                                        fontWeight: FontWeight.w400),
                                  )),
                              inputFormatters: <TextInputFormatter>[
                                thaiIdMasking,
                                // FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                phone = value;
                              },
                              controller: phonenumbercontroller,
                              maxLength: 12,
                              decoration: InputDecoration(
                                  counterText: '',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'XXX-XXX-XXXX',
                                  hintStyle: TextStyle(
                                      height: 2.1,
                                      color: HexColor('#DBDBDB'),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                  errorText: (phonenumbercontroller
                                                      .text.length !=
                                                  12 ||
                                              phonenumbercontroller
                                                  .text.isEmpty) &&
                                          alreadyEnter
                                      ? 'กรุณากรอกเบอร์โทรศัพท์มือถือให้ครบ 10 หลัก'
                                      : null,
                                  errorStyle: GoogleFonts.notoSansThai().merge(
                                      TextStyle(color: HexColor('#A02802'))),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: HexColor('#A02802'))),
                                  focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: HexColor('#A02802'))),
                                  label: Text(
                                    'เบอร์โทรศัพท์มือถือ',
                                    style: GoogleFonts.notoSansThai(
                                      fontSize: 18,
                                      color: HexColor('#646464'),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )),
                              inputFormatters: <TextInputFormatter>[
                                phoneMasking,
                                // FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    ShowBottomPngOneButtonVersion(
                                        context,
                                        'ลืมหรือเปลี่ยนเบอร์โทรศัพท์',
                                        'assets/call-contact.png',
                                        'กรุณาติดต่อศรีสวัสดิ์สาขาใกล้เคียง\nหรือติดต่อแผนกบริการลูกค้า',
                                        () {
                                      launchUrlString("tel://1652");
                                    }, 'โทรแผนกบริการลูกค้า',
                                        enableDrag: true,
                                        additionalString:
                                            '*สามารถติดต่อศรีสวัสดิ์สาขาใกล้เคียงได้ใน\nวันจันทร์-ศุกร์ เวลา 8.30-19.00 น. วันเสาร์ 8.30-15.00 น.\n(หยุดวันอาทิตย์และวันนักขัตฤกษ์)',
                                        popupHeight:
                                            MediaQuery.of(context).size.height *
                                                0.82);
                                  },
                                  child: Text(
                                    'ลืมหรือเปลี่ยนเบอร์โทรศัพท์?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .merge(TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            fontFamily:
                                                'NotoSansThaiSemiBold')),
                                  ),
                                )
                              ],
                            ),
                            TextButton(
                                onPressed: () async {
                                  try {
                                    setState(() {
                                      alreadyEnter = true;
                                      isLoading = true;
                                    });
                                    if (thaiidcontroller.text.length == 17 &&
                                        phonenumbercontroller.text.length ==
                                            12) {
                                      final String thaiId = thaiidcontroller
                                          .text
                                          .replaceAll('-', '');
                                      final String phoneNumber =
                                          phonenumbercontroller.text
                                              .replaceAll('-', '');
                                      var authaug = AuthRegister();
                                      RegisterVerfiy result =
                                          await authaug.verfiyUser(
                                        thaiId,
                                        phoneNumber,
                                      );
                                      bool isUserExists =
                                          await LoginFunction.checkIfUserExists(
                                              thaiId, false);
                                      if (isUserExists) {
                                        loginExistingUser(context, () {
                                          Navigator.pushNamed(
                                              context, '/login-page');
                                        });
                                      } else if (result.isExistingCustomer ==
                                          true) {
                                        print('true');
                                        context
                                            .read<RegisterBloc>()
                                            .state
                                            .isValidated = true;
                                        FirebaseAnalytics.instance.logEvent(
                                          name:
                                              'initial_register_srisawad_user',
                                          parameters: {
                                            'device_id': (await getId()),
                                            'device_type': '-',
                                          },
                                        );
                                        logger.d(
                                            'this from recheck page when register ${result.firstName} ${result.lastName}');
                                        context
                                            .read<authenBloc.UserTokenBloc>()
                                            .add(authenBloc.BSignin(
                                                registerVerfiy: result));
                                        otpCallbackFunction() {
                                          Navigator.pushNamed(
                                              context, '/privacy-page');
                                        }

                                        context
                                            .read<authenBloc.UserTokenBloc>()
                                            .add(authenBloc.BSignin(
                                                registerVerfiy: result));
                                        await Navigator.pushNamed(
                                            context, '/otp-page',
                                            arguments: {
                                              'callbackFunction':
                                                  otpCallbackFunction,
                                              'phoneNumber': phoneNumber,
                                            });
                                        setState(() {
                                          isLoading = false;
                                        });
                                      } else {
                                        context
                                            .read<RegisterBloc>()
                                            .state
                                            .isValidated = false;
                                        context.read<RegisterBloc>().add(
                                            GetDataFromField(
                                                thaiidcontroller.text,
                                                phonenumbercontroller.text,
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                false));
                                        otpCallbackFunction() {
                                          Navigator.pushNamed(
                                              context, '/privacy-page');
                                        }

                                        Navigator.pushNamed(
                                            context, '/otp-page',
                                            arguments: {
                                              'callbackFunction':
                                                  otpCallbackFunction,
                                              'phoneNumber': phoneNumber,
                                            });
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                      context
                                          .read<authenBloc.UserTokenBloc>()
                                          .add(authenBloc.BSignin(
                                              registerVerfiy: result));
                                    }
                                  } on RESTApiException catch (e) {
                                    // logger.e('bloc error RESTApiException :${e.cause.toString()} ');
                                    logger.e(
                                        'Register_fill_page RESTApiException error: ${e.cause.toString()}');
                                    serverSuspendedDialog(context,
                                        additionalText: e.cause.toString());
                                  } catch (e) {
                                    logger.e(
                                        'Register fill page Error!!! : ${e.toString()}');
                                    serverSuspendedDialog(
                                      context,
                                    );
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                child: Center(
                                  child: Container(
                                    height: 60,
                                    width: getActualWidth(context) * 0.9,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: HexColor('#DB771A'),
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    child: Center(
                                      child: state is authenBloc.SignInError
                                          ? Text('สมัครสมาชิก',
                                              style: GoogleFonts.notoSansThai(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.red,
                                              ))
                                          : Text('สมัครสมาชิก',
                                              style: GoogleFonts.notoSansThai(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              )),
                                    ),
                                  ),
                                )),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'มีบัญชีผู้ใช้อยู่แล้ว? ',
                                  style: GoogleFonts.notoSansThai(
                                    fontSize: 14,
                                    color: HexColor('#003063'),
                                  ).merge(
                                      TextStyle(fontFamily: 'NotoSansThai')),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginWidget()));
                                  },
                                  child: Text(
                                    'เข้าสู่ระบบ',
                                    style: GoogleFonts.notoSansThai(
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                      color: HexColor('#DB771A'),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 52,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
