import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/pages/user_process/termandcon.dart';

import '../../widgets/dialog/incorrect_pin.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'assets/intro-page1.png',
      'assets/intro-page2.png',
      'assets/intro-page3.png'
    ];
    final List<String> header = [
      'ดูข้อมูลบัญชีตัวเองได้ ตลอด 24 ชม.',
      'ขอเพิ่มวงเงินออนไลน์ง่ายๆแค่ปลายนิ้ว',
      'อัพเดตข่าวสารและโปรโมชั่น',
    ];

    final List<String> subheader = [
      'ดูความเคลื่อนไหวบัญชี ค่างวดคงค้าง\nวันกำหนดชำระ และชำระค่างวดได้ทันทีด้วย QR',
      'ต้องการเงินเพิ่ม? ไม่ใช่ปัญหา\nขอวงเงินสินเชื่อเพิ่มได้ง่ายๆ ได้ทันที',
      'ไม่พลาดทุกข่าวสาร\nและโปรโมชั่นสำหรับลูกค้าศรีสวัสดิ์ เงินสดทันใจ'
    ];

    final List<Widget> introductionItem = [
      Column(
        children: [
          SizedBox(
            height: getSlideMarginTop(),
          ),
          Expanded(
            child: Image.asset(
              imgList[0],
            ),
          ),
          SizedBox(
            height: 51,
          ),
          Text(
            header[0],
            style: GoogleFonts.notoSansThai(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: HexColor('#003063')),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            subheader[0],
            style: GoogleFonts.notoSansThai(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: HexColor('##8B99A7')),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      Column(
        children: [
          SizedBox(
            height: getSlideMarginTop(),
          ),
          Expanded(
            child: Image.asset(
              imgList[1],
            ),
          ),
          SizedBox(
            height: 51,
          ),
          Text(
            header[1],
            style: GoogleFonts.notoSansThai(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: HexColor('#003063')),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            subheader[1],
            style: GoogleFonts.notoSansThai(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: HexColor('##8B99A7')),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      Column(
        children: [
          SizedBox(
            height: getSlideMarginTop(),
          ),
          Expanded(
            child: Image.asset(
              imgList[2],
            ),
          ),
          SizedBox(
            height: 51,
          ),
          Text(
            header[2],
            style: GoogleFonts.notoSansThai(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: HexColor('#003063')),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            subheader[2],
            style: GoogleFonts.notoSansThai(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: HexColor('##8B99A7')),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CarouselSlider(
                    items: introductionItem,
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: true,
                        height: getSliderHeight(),
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Row(
                          children: [
                            Container(
                                width: _current == entry.key ? 28.0 : 8,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: _current == entry.key
                                        ? HexColor('#DB771A').withOpacity(
                                            _current == entry.key ? 1 : 0.4)
                                        : HexColor('#E5E5E5'))),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: HexColor('#DB771A'),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/term-and-con');
                            },
                            child: Text('สมัครสมาชิก',
                                style: GoogleFonts.notoSansThai(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'มีบัญชีผู้ใช้อยู่แล้ว? ',
                            style: GoogleFonts.notoSansThai(
                                    color: HexColor('#003063'),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300)
                                .merge(TextStyle(fontFamily: 'NotoSansThai')),
                          ),

                          TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 0)),
                            onPressed: () {
                              Navigator.pushNamed(context, '/login-page');
                            },
                            child: Text(
                              'เข้าสู่ระบบ',
                              style: GoogleFonts.notoSansThai(
                                color: HexColor('#DB771A'),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getSliderHeight() {
    if (isWidthTooLong(context)) {
      return getActualWidth(context) * 1.5;
    } else {
      return MediaQuery.of(context).size.height * 0.55;
    }
  }

  getSlideMarginTop() {
    if (isWidthTooLong(context)) {
      return MediaQuery.of(context).size.height * 0.2;
    } else {
      return MediaQuery.of(context).size.height * 0.1;
    }
  }
}
