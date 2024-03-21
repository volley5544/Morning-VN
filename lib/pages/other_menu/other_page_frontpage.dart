import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/bloc/user_profile/user_profile_bloc.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'package:mobile_application_srisawad/widgets/dialog/logout_pop.dart';
import 'package:mobile_application_srisawad/widgets/text_compent.dart';
import 'package:package_info_plus/package_info_plus.dart';

class OtherPageFrontPage extends StatefulWidget {
  const OtherPageFrontPage({Key? key}) : super(key: key);

  @override
  State<OtherPageFrontPage> createState() => _OtherPageFrontPageState();
}

class _OtherPageFrontPageState extends State<OtherPageFrontPage> {
  bool isVersionLoaded = false;
  String currentVersion = '';

  Future<void> getApplicationCurrentVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    setState(() {
      isVersionLoaded = true;
      currentVersion = version;
    });
  }

  @override
  void initState() {
    getApplicationCurrentVersion();
    super.initState();
  }

  String phoneNumberSafty(String phoneNumber) {
    try {
      return phoneNumber.substring(0, 3) + 'XXX' + phoneNumber.substring(6, 10);
    } catch (e) {
      logger.e(
          'Caught error in otherpage menu phonenumber is empty:${e.toString()} ');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F5F5F5'),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<PageResultBloc>(context)
                  .add(const SetButtonNavigator(false));
              Navigator.pushNamed(context, '/settings/profile',
                  arguments: {'registerSuccess': false});
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: const BoxDecoration(
                  image: const DecorationImage(
                      image: const AssetImage('assets/header-background2.png'),
                      fit: BoxFit.fitWidth)),
              child: BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (userContext, state) {
                  if (state is UserProfileLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color.fromRGBO(219, 119, 26, 1),
                      ),
                    );
                  }
                  return Container(
                    padding: EdgeInsets.only(left: 20, top: 40),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(232, 144, 62, 1),
                              width: 1,
                            ),
                            image: DecorationImage(
                                image: AssetImage('assets/user-default.png'),
                                fit: BoxFit.fitWidth),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(32)),
                          ),
                          child: ClipRRect(
                            child: Image.memory(
                              Uint8List.fromList(state.imageFile),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(60 / 2),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 82.5,
                            // color: Colors.amber,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'คุณ${state.userProfileData.firstName} ${state.userProfileData.lastName}',
                                    style: GoogleFonts.notoSansThai(
                                        fontSize: 20,
                                        color: HexColor('#003063'),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  state is UserProfileError
                                      ? Container()
                                      : Text(
                                          MaskedTextController(
                                                  mask: '000-XXX-0000',
                                                  text: phoneNumberSafty(state
                                                      .userProfileData
                                                      .phoneNumber))
                                              .text,
                                          // state.userProfileData.phoneNumber,
                                          style: GoogleFonts.notoSansThai(
                                              fontSize: 16,
                                              color: HexColor('#003063'),
                                              fontWeight: FontWeight.w500),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 54.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('ดูข้อมูลของฉัน',
                                            style: GoogleFonts.notoSansThai(
                                                    color: HexColor('#DB771A'),
                                                    fontSize: 14,
                                                    decoration: TextDecoration
                                                        .underline)
                                                .merge(TextStyle(
                                                    fontFamily:
                                                        'NotoSansThaiSemiBold'))),
                                        SvgPicture.asset(
                                          'assets/caret-right.svg',
                                          color: HexColor('#DB771A'),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 12, bottom: 6),
                            child: SectionTextTitle("เมนูอื่นๆ"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 6),
                            child: Container(
                              // height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  builldButtonOther(
                                      context,
                                      'assets/passcode-setting-icon.svg',
                                      'เปลี่ยนรหัสผ่าน',
                                      'assets/carRightVector.svg', () {
                                    BlocProvider.of<PageResultBloc>(context)
                                        .add(SetButtonNavigator(false));
                                    Navigator.pushNamed(
                                      context,
                                      '/pin-change-controller',
                                    );
                                  }),
                                  builldButtonOther(
                                      context,
                                      'assets/condition-icon.svg',
                                      'ข้อกำหนดและเงื่อนไข',
                                      'assets/carRightVector.svg', () {
                                    BlocProvider.of<PageResultBloc>(context)
                                        .add(SetButtonNavigator(false));
                                    Navigator.pushNamed(
                                        context, '/argeement-page');
                                  }),
                                  builldButtonOther(
                                      context,
                                      'assets/privacy-icon.svg',
                                      'นโยบายความเป็นส่วนตัว',
                                      'assets/carRightVector.svg', () {
                                    BlocProvider.of<PageResultBloc>(context)
                                        .add(SetButtonNavigator(false));
                                    Navigator.pushNamed(
                                        context, '/privacy-other-page');
                                  }),
                                  builldButtonOther(
                                      context,
                                      'assets/help-icon.svg',
                                      'คำถามที่พบบ่อย',
                                      'assets/carRightVector.svg', () {
                                    BlocProvider.of<PageResultBloc>(context)
                                        .add(SetButtonNavigator(false));
                                    Navigator.pushNamed(context, '/faq-page');
                                  }),
                                  builldButtonOther(
                                      context,
                                      'assets/user-manual-icon.svg',
                                      'วิธีการใช้งานแอปพลิเคชัน',
                                      'assets/carRightVector.svg', () {
                                    BlocProvider.of<PageResultBloc>(context)
                                        .add(SetButtonNavigator(false));
                                    Navigator.pushNamed(
                                        context, '/intro-other');
                                  }),
                                  builldButtonOther(
                                      context,
                                      'assets/about-icon.svg',
                                      'เกี่ยวกับเรา',
                                      'assets/carRightVector.svg', () {
                                    BlocProvider.of<PageResultBloc>(context)
                                        .add(SetButtonNavigator(false));
                                    Navigator.pushNamed(
                                        context, '/aboutus-page');
                                  }),
                                  builldButtonOther(
                                    context,
                                    'assets/contact-icon.svg',
                                    'ติดต่อเรา',
                                    'assets/carRightVector.svg',
                                    () {
                                      BlocProvider.of<PageResultBloc>(context)
                                          .add(SetButtonNavigator(false));
                                      Navigator.pushNamed(
                                          context, '/contactus-page');
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      decoration: BoxDecoration(
                                          color: HexColor('#F0F0F0'),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextButton(
                                          onPressed: () {
                                            logOutPop(context);
                                          },
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/logout-icon.svg'),
                                                //  icon: SvgPicture.asset('assets/back-icon.svg'),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8),
                                                  child: Text(
                                                    'ออกจากระบบ',
                                                    style: GoogleFonts
                                                        .notoSansThai(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          HexColor('#404040'),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 21,
                                  ),
                                  isVersionLoaded
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 9.0),
                                          child:
                                              Text('เวอร์ชัน $currentVersion'),
                                        )
                                      : Text('')
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

builldButtonOther(BuildContext context, String imageWidget, String menuName,
    String imageIconSvg, Function buttonHit) {
  return Container(
    child: TextButton(
      onPressed: () => buttonHit(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Row(
              children: [
                SvgPicture.asset(imageWidget),
                Padding(
                  padding: const EdgeInsets.only(left: 23),
                  child: Text(
                    menuName,
                    style: GoogleFonts.notoSansThai(
                        color: HexColor('#003063'),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )),
            Container(
              child: Row(
                children: [
                  SvgPicture.asset(imageIconSvg,
                      color: Color.fromRGBO(71, 71, 71, 1))
                ],
                // children: [SvgPicture.asset('assets/caret-right.svg')],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
