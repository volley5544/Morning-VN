import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:math' as math;

import '../../util/check_string_format.dart';

class LoanInstallPaymentDetail extends StatelessWidget {
  // final LoanDetail loanDetail;
  final String contractName;
  final String contractCreateDate;
  final String contractNo;
  final String loanTypeIcon;
  final String? subTitle;

  const LoanInstallPaymentDetail(
      {required this.contractName,
      required this.contractCreateDate,
      required this.contractNo,
      required this.loanTypeIcon,
      this.subTitle,
      te});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor('#FFFFFF'),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: renderLoanTypeIcon(loanTypeIcon)
                // child: SvgPicture.asset('assets/MotorLoanIcon.svg'),
                ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      this.contractName,
                      style: Theme.of(context).textTheme.titleMedium!.merge(
                          TextStyle(
                              fontWeight: FontWeight.w600,
                              fontFamily: 'NotoSansThaiSemiBold')),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('เลขที่สัญญา',
                            style: TextStyle(
                                color: Color.fromRGBO(64, 64, 64, 1),
                                fontFamily: 'NotoSansThai',
                                fontSize: 14,
                                height: 1.5)),
                        Text(
                          this.contractNo.trim(),
                          style: const TextStyle(
                              color: Color.fromRGBO(64, 64, 64, 1),
                              fontFamily: 'NotoSansThai',
                              fontSize: 14,
                              height: 1.5),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(subTitle ?? 'ชำระภายในวันที่',
                            style: TextStyle(
                                color: Color.fromRGBO(64, 64, 64, 1),
                                fontFamily: 'NotoSansThai',
                                fontSize: 14,
                                height: 1.5)),
                        Text(
                            (subTitle == null
                                ? formateBudDate(this.contractCreateDate)
                                : this.contractCreateDate.trim()),
                            style: const TextStyle(
                                color: Color.fromRGBO(64, 64, 64, 1),
                                fontFamily: 'NotoSansThai',
                                fontSize: 14,
                                height: 1.5)),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
