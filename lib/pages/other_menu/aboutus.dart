import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      child: Container(
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
                          'เกี่ยวกับเรา',
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
                  child: SingleChildScrollView(
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ศรีสวัสดิ์ เงินสดทันใจ',
                                  style: GoogleFonts.notoSansThai(
                                    color: HexColor('#003063'),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'ให้บริการสินเชื่อหลากหลายรูปแบบ อาทิ',
                                  style: GoogleFonts.notoSansThai(
                                      color: HexColor('#003063'),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Icon(
                                        Icons.circle,
                                        size: 7,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: Text(
                                        'สินเชื่อทะเบียนรถมอเตอร์ไซค์',
                                        style: GoogleFonts.notoSansThai(
                                            color: HexColor('#003063'),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Icon(
                                        Icons.circle,
                                        size: 7,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: Text(
                                        'สินเชื่อทะเบียนรถยนต์',
                                        style: GoogleFonts.notoSansThai(
                                            color: HexColor('#003063'),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Icon(
                                        Icons.circle,
                                        size: 7,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: Text(
                                        'สินเชื่อทะเบียนรถบรรทุก',
                                        style: GoogleFonts.notoSansThai(
                                            color: HexColor('#003063'),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Icon(
                                        Icons.circle,
                                        size: 7,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: Text(
                                        'สินเชื่อทะเบียนรถเพื่อการเกษตร',
                                        style: GoogleFonts.notoSansThai(
                                            color: HexColor('#003063'),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Icon(
                                        Icons.circle,
                                        size: 7,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: Text(
                                        'สินเชื่อบ้าน/ที่ดิน',
                                        style: GoogleFonts.notoSansThai(
                                            color: HexColor('#003063'),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Icon(
                                        Icons.circle,
                                        size: 7,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7),
                                      child: Text(
                                        'สินเชื่อเรือ',
                                        style: GoogleFonts.notoSansThai(
                                            color: HexColor('#003063'),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'นอกจากนี้ให้บริการตัวแทนนายหน้าทั้งประกันชีวิต\nและประกันภัยประเภทอื่น ๆ ปัจจุบันบริษัทมีสาขาให้\nบริการกว่า 5,500 สาขาทั่วประเทศไทย',
                                  style: GoogleFonts.notoSansThai(
                                      color: HexColor('#003063'),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
