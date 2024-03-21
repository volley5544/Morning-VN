import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobile_application_srisawad/bloc/user_token/user_token_bloc.dart'
    as authenBloc;
import 'package:mobile_application_srisawad/modules/userProfile/index.dart'
    as userProfileRepo;
import 'package:mobile_application_srisawad/modules/userProfile/index.dart';
import 'package:mobile_application_srisawad/widgets/bottompage.dart';
import 'package:mobile_application_srisawad/widgets/dialog/server_suspended_dialog.dart';
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../widgets/image_to_thaiid.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool alreadyEnter = false;
  bool isLoggedIn = false;
  String name = '';

  @override
  void initState() {
    setState(() {
      alreadyEnter = false;
    });
    super.initState();
    autoLogIn();
  }

  userProfileRepo.UserProfile userProfile = userProfileRepo.UserProfile();
  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('user');

    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        name = userId;
      });
      return;
    }
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', '');

    setState(() {
      name = '';
      isLoggedIn = false;
    });
  }

  Future<Null> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', thaiIdController.text);

    setState(() {
      name = thaiIdController.text;
      isLoggedIn = true;
    });
    thaiIdController.clear();
  }

  final phoneNumberController = MaskedTextController(mask: '000-000-0000');
  final thaiIdController = MaskedTextController(mask: '0-0000-00000-00-0');
  final thaiIdMasking = MaskTextInputFormatter(
      mask: '#-####-#####-##-#',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  final phoneMasking = MaskTextInputFormatter(
      mask: '###-###-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  void dispose() {
    thaiIdController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<authenBloc.UserTokenBloc, authenBloc.UserTokenState>(
        builder: (blocContext, state) {
          return state is authenBloc.LoginLoading
              ? ProgressLoading()
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/header-background2.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SafeArea(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                Future.delayed(
                                    const Duration(milliseconds: 500),
                                    () async {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/intro-page', (route) => false);
                                });
                              },
                              icon: SvgPicture.asset(
                                'assets/back-icon.svg',
                                height: 38,
                                width: 38,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage('assets/srisawad-logo.png'),
                              height: 65,
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 19),
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(1, 1)),
                                  ],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'เข้าสู่ระบบ',
                                      style: GoogleFonts.notoSansThai(
                                        color: HexColor('#003063'),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextField(
                                      maxLengthEnforcement: MaxLengthEnforcement
                                          .truncateAfterCompositionEnds,
                                      keyboardType: TextInputType.phone,
                                      controller: thaiIdController,
                                      maxLength: 17,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        errorText: (thaiIdController
                                                            .text.length !=
                                                        17 ||
                                                    thaiIdController
                                                        .text.isEmpty) &&
                                                alreadyEnter
                                            ? 'กรุณากรอกหมายเลขบัตรประชาชนให้ครบ 13 หลัก'
                                            : null,
                                        errorStyle: GoogleFonts.notoSansThai()
                                            .merge(TextStyle(
                                                color: HexColor('#A02802'))),
                                        errorBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: HexColor('#A02802'))),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color:
                                                        HexColor('#A02802'))),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        hintText: 'X-XXXX-XXXXX-XX-X',
                                        hintStyle: TextStyle(
                                            height: 2.1,
                                            color: HexColor('#DBDBDB'),
                                            fontSize: 16),
                                        suffixIcon: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 18),
                                          child: ImageToThaiid(
                                              textController: thaiIdController),
                                        ),
                                        label: Text(
                                          'หมายเลขบัตรประชาชน',
                                          style: GoogleFonts.notoSansThai(
                                              fontSize: 18,
                                              color: HexColor('#646464'),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      inputFormatters: [
                                        thaiIdMasking
                                        // FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      keyboardType: TextInputType.phone,
                                      controller: phoneNumberController,
                                      maxLength: 13,
                                      decoration: InputDecoration(
                                          counterText: '',
                                          errorText: (phoneNumberController.text.length != 12 ||
                                                      phoneNumberController
                                                          .text.isEmpty) &&
                                                  alreadyEnter
                                              ? 'กรุณากรอกเบอร์โทรศัพท์มือถือให้ครบ 10 หลัก'
                                              : null,
                                          errorStyle: GoogleFonts.notoSansThai()
                                              .merge(TextStyle(
                                                  color: HexColor('#A02802'))),
                                          errorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: HexColor('#A02802'))),
                                          focusedErrorBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: HexColor('#A02802'))),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          hintText: 'XXX-XXX-XXXX',
                                          hintStyle: TextStyle(
                                              height: 2.1,
                                              color: HexColor('#DBDBDB'),
                                              fontSize: 16),
                                          label: Text(
                                            'เบอร์โทรศัพท์มือถือ',
                                            style: GoogleFonts.notoSansThai(
                                                fontSize: 18,
                                                color: HexColor('#646464'),
                                                fontWeight: FontWeight.w400),
                                          )),
                                      inputFormatters: <TextInputFormatter>[
                                        phoneMasking
                                        // FilteringTextInputFormatter.digitsOnly
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
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.82);
                                          },
                                          child: Text(
                                            'ลืมหรือเปลี่ยนเบอร์โทรศัพท์?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .merge(TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    decoration: TextDecoration
                                                        .underline,
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
                                          setState(() {
                                            alreadyEnter = true;
                                          });
                                          try {
                                            FocusScope.of(context).unfocus();
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 500),
                                                () async {
                                              UserProfile userProfile =
                                                  UserProfile();
                                              var logger = Logger();
                                              logger.d('Log is working!');
                                              if (thaiIdController
                                                          .text.length ==
                                                      17 &&
                                                  phoneNumberController
                                                          .text.length ==
                                                      12) {
                                                context
                                                    .read<
                                                        authenBloc
                                                            .UserTokenBloc>()
                                                    .add(
                                                      authenBloc
                                                          .LoginUserToTheSysytem(
                                                              thaiIdController
                                                                  .text
                                                                  .replaceAll(
                                                                      "-", ""),
                                                              phoneNumberController
                                                                  .text
                                                                  .replaceAll(
                                                                      "-", ""),
                                                              context,
                                                              userProfile),
                                                    );
                                              }
                                            });
                                          } catch (e) {
                                            serverSuspendedDialog(context);
                                          }
                                        },
                                        child: Center(
                                          child: Container(
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 10),
                                            decoration: BoxDecoration(
                                              color: HexColor('#DB771A'),
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'เข้าสู่ระบบ',
                                                style: GoogleFonts.notoSansThai(
                                                    fontSize: 16,
                                                    color: HexColor('#FFFFFF'),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        )),
                                    Spacer(),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 24),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'ยังไม่มีบัญชีผู้ใช้? ',
                                            style: GoogleFonts.notoSansThai(
                                                color: HexColor('#003063')),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .pushNamed('/term-and-con');
                                              },
                                              child: Text(
                                                'สมัครสมาชิก',
                                                style: GoogleFonts.notoSansThai(
                                                    fontWeight: FontWeight.w600,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontSize: 16,
                                                    color: HexColor('#DB771A')),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
