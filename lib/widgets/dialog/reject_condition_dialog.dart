import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/main.dart';

rejectConditionDialog({required BuildContext context}) {
  showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentPadding: EdgeInsets.only(top: 10, right: 20, left: 20),
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
                          Navigator.of(dialogContext).pop();
                        },
                        child: Container(
                          height: BASE_BUTTON_HEIGHT,
                          decoration: BoxDecoration(
                              color: HexColor('#FCEFE4'),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              'กลับ',
                              style: GoogleFonts.notoSansThai(
                                  color: HexColor('#DB771A'),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
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
                          Navigator.of(dialogContext).pop();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: BASE_BUTTON_HEIGHT,
                          decoration: BoxDecoration(
                              color: HexColor('#DB771A'),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              'ยืนยัน',
                              style: GoogleFonts.notoSansThai(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
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
}
