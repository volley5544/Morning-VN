import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../widgets/text_compent.dart';

Widget mapALertWidget(
    {required BuildContext context,
    required Future<void> navigate,
    required Future<void> getUserLocation}) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    contentPadding: EdgeInsets.only(top: 22, right: 12, left: 12, bottom: 12),
    content: Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextTitle("อนุญาตให้ “ศรีสวัสดิ์” ใช้ตำแหน่งที่ตั้ง\nของคุณหรือไม่",
                TextAlign.center)
            .styleSecondary(),
        SizedBox(
          height: 9,
        ),
        Body('กรุณากดปุ่ม “อนุญาต” เพื่อให้คุณสามารถเข้าใช้งาน\nหน้า ค้นหาสาขา ได้ หากคุณปฏิเสธระบบจะไม่อนุญาต\nให้คุณเข้าถึงหน้า ค้นหาสาขา',
                TextAlign.center)
            .styleLightGrey(),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  navigate;
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: HexColor('#FCEFE4'),
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Center(
                      child: Text(
                        'ปฏิเสธ',
                        style: GoogleFonts.notoSansThai(
                            color: HexColor('#DB771A'),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  getUserLocation;
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                      color: HexColor('#DB771A'),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      'อนุญาต',
                      style: GoogleFonts.notoSansThai(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    )),
  );
}
