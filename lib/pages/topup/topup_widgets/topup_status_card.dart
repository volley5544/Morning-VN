import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/topup_bloc/topup_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_widgets/timeline_card.dart';
import 'package:mobile_application_srisawad/util/check_string_format.dart';
import 'package:mobile_application_srisawad/util/currentcy_format.dart';
import 'package:timelines/timelines.dart';

import '../../../util/width_until.dart';

class TopupListCard extends StatelessWidget {
  final BuildContext context;
  String loanTypeName;
  double request_topup_amount;
  String statusCode;
  String collateralInformation;
  String requestDate;
  String loanTypeIcon;

  TopupListCard({
    Key? key,
    required this.context,
    required this.loanTypeName,
    required this.request_topup_amount,
    required this.statusCode,
    required this.collateralInformation,
    required this.requestDate,
    required this.loanTypeIcon,
  }) : super(key: key);

  Widget cardListContent(
    String loanTypeName,
    double request_topup_amount,
    String statusCode,
    String collateralInformation,
    String requestDate,
  ) {
    return Container(
      height: 187,
      width: widthAdjuster(
          screenWidth: MediaQuery.of(context).size.width, widthMod: 0.90),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(10, 0, 0, 0),
                offset: Offset(1, 1),
                // spreadRadius: 1,
                blurRadius: 10),
          ],
          color: Colors.white),
      child: Column(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: renderLoanTypeIcon(loanTypeIcon),
                // child: SvgPicture.asset('assets/CarLoan.svg'),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loanTypeName,
                        style: GoogleFonts.notoSansThai(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: HexColor('#003063'))),
                    SizedBox(height: 4),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ข้อมูลหลักประกัน',
                          style: GoogleFonts.notoSansThai(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: HexColor('#646464')),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 11),
                          child: Text(
                            collateralInformation,
                            style: GoogleFonts.notoSansThai(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: HexColor('#404040')),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 5,
            thickness: 1,
            color: HexColor('#E5E5E5'),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ยอดจัดสินเชื่อ',
                  style: GoogleFonts.notoSansThai(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: HexColor('#646464'),
                  ),
                ),
                Text(
                  '${convertDoubleCurrentcy(request_topup_amount)}',
                  style: Theme.of(context).textTheme.subtitle2?.merge(
                        TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: HexColor('#404040')),
                      ),
                )
              ],
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'วันที่ขอสินเชื่อ',
                  style: GoogleFonts.notoSansThai(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: HexColor('#646464'),
                  ),
                ),
                Text(
                  formateBudDate(requestDate),
                  style: Theme.of(context).textTheme.subtitle2?.merge(
                        TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: HexColor('#404040')),
                      ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TimelineCard(
                  statusCode: statusCode,
                ),
                Text(
                  statusCode,
                  style: Theme.of(context).textTheme.subtitle2?.merge(
                        TextStyle(
                            color: colorSected(statusCode),
                            fontWeight: FontWeight.w600),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return cardListContent(loanTypeName, request_topup_amount, statusCode,
        collateralInformation, requestDate);
  }

  colorSected(String statusCode) {
    if (statusCode == 'รออนุมัติ') {
      return HexColor('#E8903E');
    }
    if (statusCode == 'โอนเงินสำเร็จ') {
      return HexColor('#1A9F3F');
    }
    if (statusCode == 'ไม่ผ่านการตรวจสอบ') {
      return HexColor('#646464');
    }
    if (statusCode == 'รอตรวจสอบและโอนเงิน') {
      return HexColor('#1D71B8');
    }
    if (statusCode == 'อยู่ระหว่างดำเนินการ') {
      return HexColor('#404040');
    }
  }
}
