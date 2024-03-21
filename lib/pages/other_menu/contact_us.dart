import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/widgets/buttons/secondary_button.dart';
import 'package:mobile_application_srisawad/widgets/text_compent.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

Future<void> launchCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/header-background2.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 300),
            color: Colors.white,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<PageResultBloc>(context)
                            .add(SetButtonNavigator(true));
                        Navigator.of(context).pop();
                      },
                      icon: SvgPicture.asset(
                        'assets/back-icon.svg',
                        height: 38,
                        width: 38,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Text(
                        'ติดต่อเรา',
                        style: GoogleFonts.notoSansThai(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: HexColor('#003063')),
                      ),
                    ),
                    Container()
                  ],
                ),
              ),
              Expanded(
                child: getContent(),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Widget contactUsSectionTitle(String title) {
    return SectionTextTitle(title, Color(0xFFDB771A).withOpacity(0.5), 18);
  }

  getContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Image(
            image: AssetImage('assets/srisawad-logo.png'),
            height: 65,
          ),
          SizedBox(
            height: 36,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  contactUsSectionTitle("สำนักงานใหญ่"),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      'ศรีสวัสดิ์ เงินสดทันใจ\nเลขที่ 99/392 อาคารศรีสวัสดิ์ ชั้นที่ 4,6\nซอยแจ้งวัฒนะ 10 แยก 3(เบญจมิตร) ถนนแจ้งวัฒนะ\nแขวงทุ่งสองห้อง เขตหลักสี่ กรุงเทพมหานคร 10210',
                      style: GoogleFonts.notoSansThai(
                          color: HexColor('#003063'),
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  contactUsSectionTitle("ติดต่อบริการลูกค้าสัมพันธ์"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: SvgPicture.asset(
                                'assets/contact-icon.svg',
                                height: 28,
                                width: 29,
                              ),
                            ),
                            Text(
                              '1652',
                              style: GoogleFonts.notoSansThai(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#003063')),
                            )
                          ],
                        ),
                      ),
                      SecondaryButton(
                          width: 94,
                          height: 41,
                          raduis: 10,
                          textButton: 'โทร',
                          CallBack: () {
                            launchCall('1652');
                          })
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  contactUsSectionTitle("ช่องทางการติดต่ออื่นๆ"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'อีเมล',
                          style: GoogleFonts.notoSansThai(
                              color: HexColor('#646464'),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'callcenter.sawad@srisawadpower.com',
                          style: GoogleFonts.notoSansThai(
                            color: HexColor('#003063'),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(color: HexColor('#E5E5E5')),
                              borderRadius: BorderRadius.circular(14)),
                          child: TextButton(
                            onPressed: () async {
                              var url = "http://bit.ly/3hJ8SvG";
                              launchUrlString(url,
                                  mode: LaunchMode.externalApplication);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                      width: 28, 'assets/line-icon.svg'),
                                  Text(
                                    'ติดต่อผ่านไลน์',
                                    style: GoogleFonts.notoSansThai(
                                        color: HexColor('#003063'),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 28,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(color: HexColor('#E5E5E5')),
                              borderRadius: BorderRadius.circular(14)),
                          child: TextButton(
                            onPressed: () {
                              launchUrlString(
                                  'https://www.facebook.com/srisawadpower',
                                  mode: LaunchMode.externalApplication);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                      width: 27,
                                      'assets/icons8-facebook (2) 1.svg'),
                                  Text(
                                    'ติดต่อผ่านเฟซบุ๊ก',
                                    style: GoogleFonts.notoSansThai(
                                        color: HexColor('#003063'),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 27,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border.all(color: HexColor('#E5E5E5')),
                              borderRadius: BorderRadius.circular(14)),
                          child: TextButton(
                            onPressed: () {
                              launchUrlString('https://www.sawad.co.th/');
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                      width: 34,
                                      height: 34,
                                      'assets/srisawad-web-logo.png'),
                                  Text(
                                    'เว็บไซต์',
                                    style: GoogleFonts.notoSansThai(
                                        color: HexColor('#003063'),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 34,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
