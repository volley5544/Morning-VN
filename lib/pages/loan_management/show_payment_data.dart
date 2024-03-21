import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/models/payment_detail.dart';
import 'dart:math' as math;
import 'package:mobile_application_srisawad/util/currentcy_format.dart';
import 'package:mobile_application_srisawad/util/loan_icon.dart';

import '../../util/check_string_format.dart';

class ShowPayMentData extends StatelessWidget {
  final String contractName;
  final String loanIcon;
  final String contractNo;
  final String contractCreateDate;
  final double currentInstallmentAmount;
  final String collateralInformation;
  // final String collateralInformation;

  const ShowPayMentData({
    required this.contractName,
    required this.contractNo,
    required this.contractCreateDate,
    required this.currentInstallmentAmount,
    required this.collateralInformation,
    required this.loanIcon,
    // required this.collateralInformation,
  });

  @override
  Widget build(BuildContext context) {
    // TextStyle titleTextStyle =
    return Container(
      color: Colors.white,
      child: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 10, 24, 0),
          child: Column(
            children: [
              Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: renderLoanTypeIcon(this.loanIcon),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: Text(
                                  this.contractName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .merge(TextStyle(
                                          fontFamily: 'NotoSansThaiSemiBold')),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('เลขที่สัญญา',
                                  style: TextStyle(
                                      color: Color.fromRGBO(64, 64, 64, 1),
                                      fontFamily: 'NotoSansThai',
                                      fontSize: 14,
                                      height: 1.5)),
                              Text(
                                contractNo.trim(),
                                style: const TextStyle(
                                    color: Color.fromRGBO(64, 64, 64, 1),
                                    fontFamily: 'NotoSansThai',
                                    fontSize: 14,
                                    height: 1.5),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('ข้อมูล ณ วันที่',
                                  style: TextStyle(
                                      color: Color.fromRGBO(64, 64, 64, 1),
                                      fontFamily: 'NotoSansThai',
                                      fontSize: 14,
                                      height: 1.5)),
                              Text(formateBudDate(contractCreateDate),
                                  style: const TextStyle(
                                      color: Color.fromRGBO(64, 64, 64, 1),
                                      fontFamily: 'NotoSansThai',
                                      fontSize: 14,
                                      height: 1.5))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'ข้อมูลหลักประกัน',
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'NotoSansThai',
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ), // Figma Flutter Generator VborderWidget - VECTOR
                          Text(
                            collateralInformation,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .merge(TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'NotoSansThaiSemiBold')),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: HexColor('#F0F0F0'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'จำนวนเงินค่างวด',
                          style: TextStyle(
                              color: Color.fromRGBO(100, 100, 100, 1),
                              fontFamily: 'NotoSansThai',
                              fontSize: 12,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        Text(
                          convertDoubleCurrentcy(
                            currentInstallmentAmount,
                          ),
                          style: Theme.of(context).textTheme.titleMedium!.merge(
                              TextStyle(fontFamily: 'NotoSansThaiSemiBold')),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
