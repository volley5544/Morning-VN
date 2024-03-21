import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/main.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  ScrollController _controller = ScrollController();
  var reachEnd = false;

  void _listener() {
    final maxScroll = _controller.position.maxScrollExtent;
    final minScroll = _controller.position.minScrollExtent;

    if (_controller.offset >= maxScroll) {
      setState(() {
        reachEnd = true;
      });
    } else if (_controller.offset <= minScroll) {
      setState(() {
        reachEnd = false;
      });
    }
  }

  @override
  void initState() {
    _controller.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
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
                  'นโยบายความเป็นส่วนตัว',
                  style: Theme.of(context).textTheme.titleLarge!.merge(TextStyle(
                      fontSize: 16, fontFamily: 'NotoSansThaiSemiBold')),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/background-image.png'),
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 31, vertical: 5),
                        child: Text(
                          'ประกาศความเป็นส่วนตัว สำหรับบุคคลที่อาจเป็นลูกค้า ลูกค้าปัจจุบัน และบุคคลที่เกี่ยวข้อง',
                          style: Theme.of(context).textTheme.titleLarge!.merge(
                              TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  height: 1.2,
                                  fontFamily: 'NotoSansThaiSemiBold')),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      FutureBuilder(
                          future:
                              rootBundle.loadString("assets/privacypolicy.md"),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              return Markdown(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 31),
                                data: snapshot.data.toString(),
                                styleSheet: MarkdownStyleSheet.fromTheme(
                                  ThemeData(
                                      textTheme: TextTheme(
                                          bodyText2: GoogleFonts.notoSansThai(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              color: HexColor('#003063')))),
                                ),
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
              )),
              reachEnd
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                      builder: (dialogContextPrivacy) =>
                                          AlertDialog(
                                            title: Center(
                                              child: Text(
                                                'คุณยืนยันที่จะปฏิเสธนโยบายความเป็นส่วนตัวการใช้งานแอปพลิเคชันใช่หรือไม่?',
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
                                                      style: GoogleFonts
                                                          .notoSansThai(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14,
                                                        color:
                                                            HexColor('#003063'),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          'คุณจะไม่สามารถเข้าใช้แอปพลิเคชันศรีสวัสดิ์ได้ทางเราต้องได้รับการยอมรับเงื่อนไขของคุณเพื่อเข้าสู่การใช้งานแอปพลิเคชัน',
                                                      style: GoogleFonts
                                                          .notoSansThai(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                        color:
                                                            HexColor('#003063'),
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                            actions: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextButton(
                                                        style:
                                                            TextButton.styleFrom(
                                                          padding:
                                                              EdgeInsets.zero,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(
                                                                  dialogContextPrivacy)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          height:
                                                              BASE_BUTTON_HEIGHT,
                                                          decoration: BoxDecoration(
                                                              color: HexColor(
                                                                  '#FCEFE4'),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          child: Center(
                                                            child: Text(
                                                              'กลับ',
                                                              style: GoogleFonts.notoSansThai(
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
                                                        style:
                                                            TextButton.styleFrom(
                                                          padding:
                                                              EdgeInsets.zero,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(
                                                                  dialogContextPrivacy)
                                                              .pushNamed(
                                                                  '/intro-page');
                                                        },
                                                        child: Container(
                                                          height:
                                                              BASE_BUTTON_HEIGHT,
                                                          decoration: BoxDecoration(
                                                              color: HexColor(
                                                                  '#DB771A'),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          child: Center(
                                                            child: Text(
                                                              'ยืนยัน',
                                                              style: GoogleFonts
                                                                  .notoSansThai(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16,
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
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: HexColor('#DB771A')),
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
                                  color: HexColor('#DB771A'),
                                  borderRadius: BorderRadius.circular(15)),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/pdpa-page');
                                },
                                child: Center(
                                  child: Text(
                                    'ยินยอม',
                                    style: GoogleFonts.notoSansThai(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                      child: Row(
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
                                      builder: (dialogContextPrivacy) =>
                                          AlertDialog(
                                            title: Center(
                                              child: Text(
                                                'คุณยืนยันที่จะปฏิเสธนโยบายความเป็นส่วนตัวการใช้งานแอปพลิเคชันใช่หรือไม่?',
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
                                                      style: GoogleFonts
                                                          .notoSansThai(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14,
                                                        color:
                                                            HexColor('#003063'),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          'คุณจะไม่สามารถเข้าใช้แอปพลิเคชันศรีสวัสดิ์ได้ทางเราต้องได้รับการยอมรับเงื่อนไขของคุณเพื่อเข้าสู่การใช้งานแอปพลิเคชัน',
                                                      style: GoogleFonts
                                                          .notoSansThai(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                        color:
                                                            HexColor('#003063'),
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                            actions: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextButton(
                                                        style:
                                                            TextButton.styleFrom(
                                                          padding:
                                                              EdgeInsets.zero,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(
                                                                  dialogContextPrivacy)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          height:
                                                              BASE_BUTTON_HEIGHT,
                                                          decoration: BoxDecoration(
                                                              color: HexColor(
                                                                  '#FCEFE4'),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          child: Center(
                                                            child: Text(
                                                              'กลับ',
                                                              style: GoogleFonts.notoSansThai(
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
                                                        style:
                                                            TextButton.styleFrom(
                                                          padding:
                                                              EdgeInsets.zero,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(
                                                                  dialogContextPrivacy)
                                                              .pop();
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                                  '/intro-page');
                                                        },
                                                        child: Container(
                                                          height:
                                                              BASE_BUTTON_HEIGHT,
                                                          decoration: BoxDecoration(
                                                              color: HexColor(
                                                                  '#DB771A'),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          child: Center(
                                                            child: Text(
                                                              'ยืนยัน',
                                                              style: GoogleFonts
                                                                  .notoSansThai(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16,
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
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: HexColor('#DB771A')),
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
                                  color: HexColor('#DB771A').withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15)),
                              child: TextButton(
                                onPressed: null,
                                child: Center(
                                  child: Text(
                                    'ยินยอม',
                                    style: GoogleFonts.notoSansThai(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
}
