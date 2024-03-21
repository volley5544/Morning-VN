import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_styling.dart';
import 'package:mobile_application_srisawad/util/check_string_format.dart';
import 'package:mobile_application_srisawad/util/currentcy_format.dart';
import 'package:mobile_application_srisawad/widgets/base_card.dart';

import '../../../main.dart';
import '../../../util/width_until.dart';

class TopupLoanCard extends StatelessWidget {
  final BuildContext context;
  final LoanDetail loanDetail;
  final Function onPayButtonTap;
  final Function? onDetailSelected;
  final double? loanCardWidth;
  final Function onTap;
  const TopupLoanCard({
    Key? key,
    required this.context,
    required this.loanDetail,
    required this.onPayButtonTap,
    this.onDetailSelected,
    this.loanCardWidth,
    required this.onTap,
  }) : super(key: key);

  Widget content() {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
            // padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              renderLoanTypeIcon(loanDetail.contractDetails.loanTypeIcon),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          loanDetail.contractDetails.loanTypeName,
                          style: TextStyle(
                                  height: 1.51125,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(0, 48, 99, 1))
                              .merge(TextStyle(
                                  fontFamily: 'NotoSansThaiSemiBold')),
                        ),
                        Text(
                          'งวดที่ ${loanDetail.paymentDetails.currentInstallmentNumber}/${loanDetail.paymentDetails.totalInstallment} ',
                          style: size14WNormal.merge(TextStyle(
                            height: 1.6,
                          )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('ข้อมูลหลักประกัน',
                            style: TextStyle(
                                color: Color.fromRGBO(64, 64, 64, 1),
                                fontFamily: 'NotoSansThai',
                                fontSize: 14,
                                height: 1.5)),
                        Text(
                          loanDetail.contractDetails.collateralInformation,
                          style: size14WNormal.merge(TextStyle(height: 2)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 17,
                    )
                  ],
                ),
              ),
            ]),
          ),
          Container(
              height: 1, color: HexColor('#E5E5E5'), width: double.infinity),
        ],
      ),
    );
  }

  Widget buttomContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 17, 18, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ยอดปิดสัญญาเก่า',
                    style: size14WNormal,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => onPayButtonTap(),
                child: Text(
                  convertDoubleCurrentcy(
                      loanDetail.contractDetails.closingBalance),
                  style: size14WNormal.merge(
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 14, left: 14),
          child: SizedBox(
              width: double.infinity,
              child: Text('*ยอดปิดคำนวณ ณ วันเวลาที่ทำรายการ')),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: onTap,
      content: content(),
      buttomContent: buttomContent(),
      hasBorder: loanDetail.topupDetail.canTopup == "Y" ? true : null,
      width: loanCardWidth == null
          ? widthAdjuster(
              screenWidth: MediaQuery.of(context).size.width, widthMod: 0.96)
          : loanCardWidth!,
    );
  }
}
