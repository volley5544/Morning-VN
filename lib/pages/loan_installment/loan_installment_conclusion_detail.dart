import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/models/loan_installment_detail.dart';
import 'package:mobile_application_srisawad/models/payment_detail.dart';
import 'dart:math' as math;
import 'package:mobile_application_srisawad/util/currentcy_format.dart';

import '../../main.dart';

class LoanInstallmentConclusionDetail extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;
  final String leftContent;
  final String rightContent;
  final double? cardWidth;
  const LoanInstallmentConclusionDetail(
      {required this.leftTitle,
      required this.rightTitle,
      required this.leftContent,
      required this.rightContent,
      this.cardWidth});

  @override
  Widget build(BuildContext context) {
    TextStyle historyContentText = TextStyle(
        color: Color.fromRGBO(64, 64, 64, 1),
        fontFamily: 'NotoSansThai',
        fontSize: MediaQuery.of(context).textScaleFactor != 1 ? 14 : 16,
        letterSpacing: 0,
        fontWeight: FontWeight.w600,
        height: 1.5);
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Container(
        height: 74,
        width: cardWidth ?? getActualWidth(context),
        // color: Colors.white,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(cardWidth == null ? 0 : 14),
          ),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        child: Center(
          child: SizedBox(
            width: getActualWidth(context) * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                leftTitle, // วันที่ชำระ
                                style: const TextStyle(
                                    color: Color.fromRGBO(64, 64, 64, 1),
                                    fontFamily: 'NotoSansThai',
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Text(
                                  leftContent,
                                  style: cardWidth != null
                                      ? historyContentText
                                      : Theme.of(context).textTheme.titleMedium,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isWidthTooLong != true)
                  Container(
                    width: 10,
                  ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      width: 1,
                      height: 32,
                      color: HexColor('#F0F0F0'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        rightTitle,
                        style: TextStyle(
                            color: Color.fromRGBO(64, 64, 64, 1),
                            fontFamily: 'NotoSansThai',
                            fontSize: 12,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                      Text(
                        rightContent,
                        style: cardWidth != null
                            ? historyContentText
                            : Theme.of(context).textTheme.titleMedium,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
