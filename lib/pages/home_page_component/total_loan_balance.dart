import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/util/check_string_format.dart';

import '../../util/currentcy_format.dart';

class TotleLoanBalance extends StatelessWidget {
  double sumedAmount;
  String latestUpdatedDate;
  bool isLoading;
  TotleLoanBalance(
      {Key? key,
      required this.sumedAmount,
      required this.latestUpdatedDate,
      required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 51,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
            bottomLeft: Radius.circular(14),
            bottomRight: Radius.circular(14),
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
                offset: Offset(0, 4),
                blurRadius: 10)
          ],
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                text: 'ยอดหนี้คงเหลือทุกสัญญา',
                style: GoogleFonts.notoSansThai(
                  color: HexColor('#646464'),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                      text:
                          '\nข้อมูลวันที่ ${formateBudDate(latestUpdatedDate)} เวลา ${formateTime(latestUpdatedDate)} น.',
                      // text: '\nข้อมูลวันที่ 14/06/2565 เวลา 20.43 น.',
                      style: GoogleFonts.notoSansThai(
                          color: HexColor('#8B99A7'),
                          height: 1.1,
                          fontWeight: FontWeight.w400,
                          fontSize: 10.0))
                ],
              )),
              Center(
                child: Text(
                  isLoading ? '-' : '${convertDoubleCurrentcy(sumedAmount)}',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
