import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/widgets/dialog/reject_condition_dialog.dart';
import 'package:mobile_application_srisawad/widgets/text_compent.dart';

class TermAndCon extends StatefulWidget {
  const TermAndCon({
    Key? key,
  }) : super(key: key);

  @override
  State<TermAndCon> createState() => _TermAndConState();
}

class _TermAndConState extends State<TermAndCon> {
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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: HexColor('#DB771A'),
            ),
          ),
          centerTitle: true,
          title: Text(
            'ข้อกำหนดและเงื่อนไข',
            style: Theme.of(context).textTheme.titleLarge!.merge(
                TextStyle(fontSize: 16, fontFamily: 'NotoSansThaiSemiBold')),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background-image.png'),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Largetitle(
                                  'เงื่อนไขและข้อตกลงในการใช้บริการ แอปพลิเคชัน ศรีสวัสดิ์ เงินสดทันใจ')
                              .styleSecondary(),
                        ),
                        FutureBuilder(
                            future:
                                rootBundle.loadString("assets/termwithcon.md"),
                            builder: (BuildContext context,
                                AsyncSnapshot<String> snapshot) {
                              if (snapshot.hasData) {
                                return Markdown(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
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
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Color.fromRGBO(219, 119, 26, 1),
                                  ),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
                reachEnd
                    ? Container(
                        margin: EdgeInsets.only(bottom: 16),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: HexColor('#FCEFE4'),
                                    borderRadius: BorderRadius.circular(15)),
                                height: BASE_BUTTON_HEIGHT,
                                child: TextButton(
                                  onPressed: () {
                                    rejectConditionDialog(context: context);
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (dialogContext) => AlertDialog(
                                    //           title: Center(
                                    //             child: Column(
                                    //               children: [
                                    //                 Text(
                                    //                   'คุณยืนยันที่จะปฏิเสธข้อกำหนดและเงื่อนไขการใช้งานแอปพลิเคชันใช่หรือไม่?',
                                    //                   style: GoogleFonts
                                    //                       .notoSansThai(
                                    //                           fontWeight:
                                    //                               FontWeight
                                    //                                   .w600,
                                    //                           fontSize: 16,
                                    //                           color: HexColor(
                                    //                               '#003063')),
                                    //                   textAlign:
                                    //                       TextAlign.center,
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //           shape: RoundedRectangleBorder(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(
                                    //                       20)),
                                    //           contentPadding: EdgeInsets.only(
                                    //               top: 10, right: 20, left: 20),
                                    //           content: RichText(
                                    //             textAlign: TextAlign.center,
                                    //             text: TextSpan(
                                    //                 text: 'หากคุณ ',
                                    //                 style: GoogleFonts
                                    //                     .notoSansThai(
                                    //                   fontWeight:
                                    //                       FontWeight.w400,
                                    //                   fontSize: 14,
                                    //                   color:
                                    //                       HexColor('#003063'),
                                    //                 ),
                                    //                 children: [
                                    //                   TextSpan(
                                    //                     text: '"ปฏิเสธ"',
                                    //                     style: GoogleFonts
                                    //                         .notoSansThai(
                                    //                       fontWeight:
                                    //                           FontWeight.w700,
                                    //                       fontSize: 14,
                                    //                       color: HexColor(
                                    //                           '#003063'),
                                    //                     ),
                                    //                   ),
                                    //                   TextSpan(
                                    //                     text:
                                    //                         'คุณจะไม่สามารถเข้าใช้แอปพลิเคชันศรีสวัสดิ์ได้ทางเราต้องได้รับการยอมรับเงื่อนไขของคุณเพื่อเข้าสู่การใช้งานแอปพลิเคชัน',
                                    //                     style: GoogleFonts
                                    //                         .notoSansThai(
                                    //                       fontWeight:
                                    //                           FontWeight.w400,
                                    //                       fontSize: 14,
                                    //                       color: HexColor(
                                    //                           '#003063'),
                                    //                     ),
                                    //                   ),
                                    //                 ]),
                                    //           ),
                                    //           actions: [
                                    //             Padding(
                                    //               padding:
                                    //                   const EdgeInsets.only(
                                    //                       left: 8,
                                    //                       right: 8,
                                    //                       bottom: 8,
                                    //                       top: 12),
                                    //               child: Row(
                                    //                 children: [
                                    //                   Expanded(
                                    //                     child: TextButton(
                                    //                       style: TextButton
                                    //                           .styleFrom(
                                    //                         padding:
                                    //                             EdgeInsets.zero,
                                    //                       ),
                                    //                       onPressed: () {
                                    //                         Navigator.of(
                                    //                                 dialogContext)
                                    //                             .pop();
                                    //                       },
                                    //                       child: Container(
                                    //                         height:
                                    //                             BASE_BUTTON_HEIGHT,
                                    //                         decoration: BoxDecoration(
                                    //                             color: HexColor(
                                    //                                 '#FCEFE4'),
                                    //                             borderRadius:
                                    //                                 BorderRadius
                                    //                                     .circular(
                                    //                                         15)),
                                    //                         child: Center(
                                    //                           child: Text(
                                    //                             'กลับ',
                                    //                             style: GoogleFonts.notoSansThai(
                                    //                                 color: HexColor(
                                    //                                     '#DB771A'),
                                    //                                 fontSize:
                                    //                                     16,
                                    //                                 fontWeight:
                                    //                                     FontWeight
                                    //                                         .w600),
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                   SizedBox(
                                    //                     width: 8,
                                    //                   ),
                                    //                   Expanded(
                                    //                     child: TextButton(
                                    //                       style: TextButton
                                    //                           .styleFrom(
                                    //                         padding:
                                    //                             EdgeInsets.zero,
                                    //                       ),
                                    //                       onPressed: () {
                                    //                         Navigator.of(
                                    //                                 dialogContext)
                                    //                             .pop();
                                    //                         Navigator.of(
                                    //                                 context)
                                    //                             .pushNamed(
                                    //                                 '/intro-page');
                                    //                       },
                                    //                       child: Container(
                                    //                         height:
                                    //                             BASE_BUTTON_HEIGHT,
                                    //                         decoration: BoxDecoration(
                                    //                             color: HexColor(
                                    //                                 '#DB771A'),
                                    //                             borderRadius:
                                    //                                 BorderRadius
                                    //                                     .circular(
                                    //                                         15)),
                                    //                         child: Center(
                                    //                           child: Text(
                                    //                             'ยืนยัน',
                                    //                             style: GoogleFonts.notoSansThai(
                                    //                                 color: Colors
                                    //                                     .white,
                                    //                                 fontWeight:
                                    //                                     FontWeight
                                    //                                         .bold),
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //             )
                                    //           ],
                                    //         ));
                                  },
                                  child: Text(
                                    'ปฏิเสธ',
                                    style: GoogleFonts.notoSansThai(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: HexColor('#DB771A'),
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
                                decoration: BoxDecoration(
                                    color: HexColor('#DB771A'),
                                    borderRadius: BorderRadius.circular(15)),
                                height: BASE_BUTTON_HEIGHT,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/register-fill-page');
                                  },
                                  child: Text(
                                    'ยอมรับ',
                                    style: GoogleFonts.notoSansThai(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(bottom: 16),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: HexColor('#FCEFE4'),
                                    borderRadius: BorderRadius.circular(15)),
                                height: BASE_BUTTON_HEIGHT,
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () {
                                    rejectConditionDialog(context: context);
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (dialogContext) => AlertDialog(
                                    //           title: Center(
                                    //             child: Column(
                                    //               children: [
                                    //                 Text(
                                    //                   'คุณยืนยันที่จะปฏิเสธข้อกำหนดและเงื่อนไขการใช้งานแอปพลิเคชันใช่หรือไม่?',
                                    //                   style: GoogleFonts
                                    //                       .notoSansThai(
                                    //                           fontWeight:
                                    //                               FontWeight
                                    //                                   .w600,
                                    //                           fontSize: 16,
                                    //                           color: HexColor(
                                    //                               '#003063')),
                                    //                   textAlign:
                                    //                       TextAlign.center,
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //           shape: RoundedRectangleBorder(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(
                                    //                       20)),
                                    //           contentPadding: EdgeInsets.only(
                                    //               top: 10, right: 20, left: 20),
                                    //           content: RichText(
                                    //             textAlign: TextAlign.center,
                                    //             text: TextSpan(
                                    //                 text: 'หากคุณ ',
                                    //                 style: GoogleFonts
                                    //                     .notoSansThai(
                                    //                   fontWeight:
                                    //                       FontWeight.w400,
                                    //                   fontSize: 14,
                                    //                   color:
                                    //                       HexColor('#003063'),
                                    //                 ),
                                    //                 children: [
                                    //                   TextSpan(
                                    //                     text: '"ปฏิเสธ"',
                                    //                     style: GoogleFonts
                                    //                         .notoSansThai(
                                    //                       fontWeight:
                                    //                           FontWeight.w700,
                                    //                       fontSize: 14,
                                    //                       color: HexColor(
                                    //                           '#003063'),
                                    //                     ),
                                    //                   ),
                                    //                   TextSpan(
                                    //                     text:
                                    //                         'คุณจะไม่สามารถเข้าใช้แอปพลิเคชันศรีสวัสดิ์ได้ทางเราต้องได้รับการยอมรับเงื่อนไขของคุณเพื่อเข้าสู่การใช้งานแอปพลิเคชัน',
                                    //                     style: GoogleFonts
                                    //                         .notoSansThai(
                                    //                       fontWeight:
                                    //                           FontWeight.w400,
                                    //                       fontSize: 14,
                                    //                       color: HexColor(
                                    //                           '#003063'),
                                    //                     ),
                                    //                   ),
                                    //                 ]),
                                    //           ),
                                    //           actions: [
                                    //             Padding(
                                    //               padding:
                                    //                   const EdgeInsets.only(
                                    //                       left: 8,
                                    //                       right: 8,
                                    //                       bottom: 8,
                                    //                       top: 12),
                                    //               child: Row(
                                    //                 children: [
                                    //                   Expanded(
                                    //                     child: TextButton(
                                    //                       style: TextButton
                                    //                           .styleFrom(
                                    //                         padding:
                                    //                             EdgeInsets.zero,
                                    //                       ),
                                    //                       onPressed: () {
                                    //                         Navigator.of(
                                    //                                 dialogContext)
                                    //                             .pop();
                                    //                       },
                                    //                       child: Container(
                                    //                         height:
                                    //                             BASE_BUTTON_HEIGHT,
                                    //                         decoration: BoxDecoration(
                                    //                             color: HexColor(
                                    //                                 '#FCEFE4'),
                                    //                             borderRadius:
                                    //                                 BorderRadius
                                    //                                     .circular(
                                    //                                         15)),
                                    //                         child: Center(
                                    //                           child: Text(
                                    //                             'กลับ',
                                    //                             style: GoogleFonts.notoSansThai(
                                    //                                 color: HexColor(
                                    //                                     '#DB771A'),
                                    //                                 fontSize:
                                    //                                     16,
                                    //                                 fontWeight:
                                    //                                     FontWeight
                                    //                                         .w600),
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                   SizedBox(
                                    //                     width: 8,
                                    //                   ),
                                    //                   Expanded(
                                    //                     child: TextButton(
                                    //                       style: TextButton
                                    //                           .styleFrom(
                                    //                         padding:
                                    //                             EdgeInsets.zero,
                                    //                       ),
                                    //                       onPressed: () {
                                    //                         Navigator.of(
                                    //                                 dialogContext)
                                    //                             .pop();
                                    //                         Navigator.of(
                                    //                                 context)
                                    //                             .pushNamed(
                                    //                                 '/intro-page');
                                    //                       },
                                    //                       child: Container(
                                    //                         height:
                                    //                             BASE_BUTTON_HEIGHT,
                                    //                         decoration: BoxDecoration(
                                    //                             color: HexColor(
                                    //                                 '#DB771A'),
                                    //                             borderRadius:
                                    //                                 BorderRadius
                                    //                                     .circular(
                                    //                                         15)),
                                    //                         child: Center(
                                    //                           child: Text(
                                    //                             'ยืนยัน',
                                    //                             style: GoogleFonts.notoSansThai(
                                    //                                 fontSize:
                                    //                                     16,
                                    //                                 color: Colors
                                    //                                     .white,
                                    //                                 fontWeight:
                                    //                                     FontWeight
                                    //                                         .w600),
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //             )
                                    //           ],
                                    //         ));
                                  },
                                  child: Text(
                                    'ปฏิเสธ',
                                    style: GoogleFonts.notoSansThai(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: HexColor('#DB771A'),
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
                                decoration: BoxDecoration(
                                    color: HexColor('#DB771A').withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15)),
                                height: BASE_BUTTON_HEIGHT,
                                child: TextButton(
                                  onPressed: null,
                                  child: Text(
                                    'ยอมรับ',
                                    style: GoogleFonts.notoSansThai(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
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
        ));
  }
}
