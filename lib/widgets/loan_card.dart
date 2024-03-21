import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/util/currentcy_format.dart';
import 'package:mobile_application_srisawad/widgets/base_card.dart';

import '../main.dart';
import '../util/check_string_format.dart';

class LoanCard extends StatelessWidget {
  final BuildContext context;
  final LoanDetail loanDetail;
  final Function onPayButtonTap;
  final bool? isDetail;
  final Function? onDetailSelected;
  final double? loanCardWidth;
  final bool? isCurrentLoan;
  final String loanTypeIcon;
  const LoanCard(
      {Key? key,
      required this.context,
      required this.loanDetail,
      required this.onPayButtonTap,
      this.isDetail,
      this.onDetailSelected,
      this.loanCardWidth,
      this.isCurrentLoan,
      required this.loanTypeIcon})
      : super(key: key);

  Widget Content() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          renderLoanTypeIcon(loanTypeIcon),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          loanDetail.contractDetails.loanTypeName, //
                          style: TextStyle(
                                  height: 1.51125,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(0, 48, 99, 1))
                              .merge(TextStyle(
                                  fontFamily: 'NotoSansThaiSemiBold')),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('ข้อมูลหลักประกัน',
                            style: TextStyle(
                                color: Color.fromRGBO(64, 64, 64, 1),
                                fontFamily: 'NotoSansThai',
                                fontSize: 14,
                                height: 1)),
                        Text(
                          loanDetail.contractDetails.collateralInformation
                              .trim(),
                          style: TextStyle(
                              color: Color.fromRGBO(64, 64, 64, 1),
                              fontFamily: 'NotoSansThai',
                              fontSize: 14,
                              height: 1),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('ชำระภายในวันที่',
                          style: TextStyle(
                              color: Color.fromRGBO(138, 152, 167, 1),
                              fontFamily: 'NotoSansThai',
                              fontSize: 12,
                              height: 1.5)),
                      Text(
                          formateBudDate(
                              loanDetail.paymentDetails.payBeforeDate),
                          // DateFormat.yMd().format(
                          //     DateTime.parse(loanDetail.paymentDetails.latestPaidDate)),
                          style: TextStyle(
                              color: Color.fromRGBO(138, 152, 167, 1),
                              fontFamily: 'NotoSansThai',
                              fontSize: 12,
                              height: 1.5))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget oldLoanContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      renderLoanTypeIcon(loanTypeIcon),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    loanDetail.contractDetails.loanTypeName,
                                    style: TextStyle(
                                            height: 1.51125,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(0, 48, 99, 1))
                                        .merge(TextStyle(
                                            fontFamily:
                                                'NotoSansThaiSemiBold')),
                                  ),
                                  Text(
                                    loanDetail
                                        .contractDetails.collateralInformation
                                        .trim(),
                                    style: TextStyle(
                                        color: Color.fromRGBO(64, 64, 64, 1),
                                        fontFamily: 'NotoSansThai',
                                        fontSize: 14,
                                        height: 1.51125),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('ยอดจัดสินเชื่อ',
                                      style: TextStyle(
                                          color: HexColor('#646464'),
                                          fontFamily: 'NotoSansThai',
                                          fontSize: 14,
                                          height: 1.51125)),
                                  Text(
                                    convertDoubleCurrentcy(loanDetail
                                            .contractDetails.creditLimit)
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: HexColor('#404040'),
                                        height: 1.51125),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ]),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                    height: 1,
                    color: HexColor('#E5E5E5'),
                    width: getActualWidth(context) * 0.95),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget oldLoanbottomContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 14, 13),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(top: 16, bottom: 10),
            // color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'เลขที่สัญญา',
                  style: TextStyle(
                      color: HexColor('#646464'),
                      fontFamily: 'NotoSansThai',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                Text(
                  loanDetail.contractNo,
                  style: const TextStyle(
                      color: Color.fromRGBO(64, 64, 64, 1),
                      fontFamily: 'NotoSansThai',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                      height: 1),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'วันที่ทำสัญญา',
                style: TextStyle(
                    color: HexColor('#646464'),
                    fontFamily: 'NotoSansThai',
                    fontSize: 14,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
              Text(
                formateBudDate(loanDetail.contractCreateDate),
                style: const TextStyle(
                    color: Color.fromRGBO(64, 64, 64, 1),
                    fontFamily: 'NotoSansThai',
                    fontSize: 14,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                    height: 1),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'วันที่ปิดบัญชี',
                  style: TextStyle(
                      color: Color.fromRGBO(100, 100, 100, 1),
                      fontFamily: 'NotoSansThai',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                Text(
                  formateBudDate(loanDetail.contractCloseDate),
                  style: const TextStyle(
                      color: Color.fromRGBO(64, 64, 64, 1),
                      fontFamily: 'NotoSansThai',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600,
                      height: 1),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buttomContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ยอดครบกำหนดชำระ',
                  style: TextStyle(
                      color: Color.fromRGBO(100, 100, 100, 1),
                      fontFamily: 'NotoSansThai',
                      fontSize: 12,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                Text(
                  '${convertDoubleCurrentcy(loanDetail.paymentDetails.currentInstallmentAmount)} บาท',
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => onPayButtonTap(),
            child: Container(
                width: 94,
                height: 41,
                // color: Colors.amber,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(219, 119, 26, 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: const Center(
                    child: Text(
                      'ชำระเงิน',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'NotoSansThaiSemiBold',
                          fontSize: 14,
                          letterSpacing: 0,
                          height: 1),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget renderCardComponent() {
    if (onDetailSelected != null && isCurrentLoan!) {
      return BaseCard(
        onTap: () => onDetailSelected!(),
        content: Content(),
        buttomContent: buttomContent(),
        width: getActualWidth(context) * 0.95,
      );
    } else {
      return BaseCard(
        content: oldLoanContent(),
        buttomContent: oldLoanbottomContent(),
        width: loanCardWidth!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: () {
        if (onDetailSelected != null && isCurrentLoan!) {
          onDetailSelected!();
        }
      },
      content: (isCurrentLoan != null && isCurrentLoan!)
          ? Content()
          : oldLoanContent(),
      buttomContent: (isCurrentLoan != null && isCurrentLoan!)
          ? buttomContent()
          : oldLoanbottomContent(),
      width: loanCardWidth == null
          ? getActualWidth(context) * 0.95
          : loanCardWidth!,
    );
  }
}
