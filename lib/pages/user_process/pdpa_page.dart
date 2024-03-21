import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/util/color_util.dart';

import '../../bloc/register_bloc/register_bloc.dart';

class PdpaPage extends StatefulWidget {
  const PdpaPage({Key? key}) : super(key: key);

  @override
  State<PdpaPage> createState() => _PdpaPageState();
}

class _PdpaPageState extends State<PdpaPage> {
  ScrollController _controller = ScrollController();

  var reachEnd = false;

  void _listener() {
    final maxScroll = _controller.position.maxScrollExtent;
    final minScroll = _controller.position.minScrollExtent;
    if (_controller.offset >= maxScroll) {
      setState(() {
        reachEnd = true;
      });
    }

    if (_controller.offset <= minScroll) {
      setState(() {
        reachEnd = false;
      });
    }
  }

  @override
  void initState() {
    _controller.addListener(_listener);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkReachBottomFirstTime();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  'ข้อมูล PDPA',
                  style: GoogleFonts.notoSansThai(
                      color: HexColor('#003063'),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 19,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background-image.png'),
                          fit: BoxFit.cover)),
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 31),
                          child: Text(
                            'ความยินยอมสำหรับข้อมูลส่วนบุคคลของคุณ',
                            style: GoogleFonts.notoSansThai(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: HexColor(ColorUtil.SECONDARY)),
                          ),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Center(
                          child: SvgPicture.asset('assets/pdpa icon.svg',
                              width: getActualWidth(context) / 2),
                        ),
                        FutureBuilder(
                            future: rootBundle
                                .loadString("assets/pdpanewversion.md"),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Markdown(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(33),
                                  styleSheet: MarkdownStyleSheet.fromTheme(
                                    ThemeData(
                                        textTheme: TextTheme(
                                            bodyText2: GoogleFonts.notoSansThai(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400,
                                                color: HexColor('#003063')))),
                                  ),
                                  data: snapshot.data.toString(),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Color.fromRGBO(219, 119, 26, 1),
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: BASE_BUTTON_HEIGHT,
                        decoration: BoxDecoration(
                            color: HexColor('#FCEFE4'),
                            borderRadius: BorderRadius.circular(15)),
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (dialogContextPdpa) => AlertDialog(
                                      title: Center(
                                        child: Text(
                                          'คุณยืนยันที่จะปฏิเสธข้อความยินยอมสำหรับข้อมูลส่วนบุคคลในการใช้งานแอปพลิเคชันใช่หรือไม่?',
                                          style: GoogleFonts.notoSansThai(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: HexColor('#003063')),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      contentPadding: EdgeInsets.only(
                                          top: 10, right: 20, left: 20),
                                      content: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            text: 'หากคุณ ',
                                            style: GoogleFonts.notoSansThai(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: HexColor('#003063'),
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '"ปฏิเสธ"',
                                                style: GoogleFonts.notoSansThai(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: HexColor('#003063'),
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    'คุณจะไม่สามารถเข้าใช้แอปพลิเคชันศรีสวัสดิ์ได้ทางเราต้องได้รับการยอมรับเงื่อนไขของคุณเพื่อเข้าสู่การใช้งานแอปพลิเคชัน',
                                                style: GoogleFonts.notoSansThai(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: HexColor('#003063'),
                                                ),
                                              ),
                                            ]),
                                      ),
                                      actions: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(
                                                            dialogContextPdpa)
                                                        .pop();
                                                  },
                                                  child: Container(
                                                    height: BASE_BUTTON_HEIGHT,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            HexColor('#FCEFE4'),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Center(
                                                      child: Text(
                                                        'กลับ',
                                                        style: GoogleFonts
                                                            .notoSansThai(
                                                                color: HexColor(
                                                                    '#DB771A'),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Expanded(
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(
                                                            dialogContextPdpa)
                                                        .pop();
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            '/intro-page');
                                                  },
                                                  child: Container(
                                                    height: BASE_BUTTON_HEIGHT,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            HexColor('#DB771A'),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Center(
                                                      child: Text(
                                                        'ยืนยัน',
                                                        style: GoogleFonts
                                                            .notoSansThai(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ));
                          },
                          child: Center(
                            child: Text(
                              'ไม่ยินยอม',
                              style: GoogleFonts.notoSansThai(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: HexColor('#DB771A'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Expanded(
                      child: Container(
                        height: BASE_BUTTON_HEIGHT,
                        decoration: BoxDecoration(
                            color: reachEnd
                                ? HexColor('#DB771A')
                                : HexColor('#DB771A').withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15)),
                        child: TextButton(
                          onPressed: () {
                            context.read<RegisterBloc>().state.isValidated ==
                                    true
                                ? Navigator.pushNamed(context, '/pinsetup')
                                : Navigator.pushNamed(
                                    context, '/register-profile');
                          },
                          child: Center(
                            child: Text(
                              'ยินยอม',
                              style: GoogleFonts.notoSansThai(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 21,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkReachBottomFirstTime() async {
    await Future.delayed(Duration(milliseconds: 100));
    final maxScroll = _controller.position.maxScrollExtent;
    if (_controller.offset >= maxScroll) {
      setState(() {
        reachEnd = true;
      });
    }
  }
}
