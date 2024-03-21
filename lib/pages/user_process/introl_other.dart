import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/widgets/text_compent.dart';

class IntrolOther extends StatefulWidget {
  const IntrolOther({super.key});

  @override
  State<IntrolOther> createState() => _IntrolOtherState();
}

class _IntrolOtherState extends State<IntrolOther> {
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
          Container(
            child: Image.asset(
              imgList[0],
              width: 248,
              height: 248,
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
          Container(
            child: Image.asset(
              imgList[1],
              width: 248,
              height: 248,
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
          Container(
            child: Image.asset(
              imgList[2],
              width: 248,
              height: 248,
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<PageResultBloc>(context)
                .add(SetButtonNavigator(true));
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset('assets/back-icon.svg'),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: TextTitle(
          'วิธีการใช้งานแอปพลิเคชัน',
          TextAlign.center,
        ).styleSecondary(),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: CarouselSlider(
                items: introductionItem,
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 0.9 / 1,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
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
            SizedBox(
              height: 72,
            ),
          ],
        ),
      ),
    );
  }
}
