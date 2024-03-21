import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_styling.dart';

import '../../../main.dart';
import '../../../util/check_string_format.dart';
import '../../../util/width_until.dart';

class BackAccountInfomation extends StatelessWidget {
  // final LoanDetail loanDetail;
  final String branchImage;
  final String contractBankBrandname;
  final String contractBankAccount;
  const BackAccountInfomation({
    Key? key,
    required this.branchImage,
    required this.contractBankBrandname,
    required this.contractBankAccount,
  }) : super(key: key);

  Widget bankHandler(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Row(
        children: [
          ClipRRect(
              child: SvgPicture.asset(
                'assets/BankImgEror.svg',
                width: 48,
                height: 48,
              ),
              borderRadius: BorderRadius.circular(48 / 2)),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 3),
                  child: Container(
                    width: widthAdjuster(
                        screenWidth: MediaQuery.of(context).size.width,
                        widthMod: 0.7),
                    child: Text(
                      'ไม่พบข้อมูลบัญชีธนาคารของคุณ\nกรุณาติดต่อศรีสวัสดิ์สาขาใกล้คุณ',
                      style: size14WNormal.merge(
                          TextStyle(height: 1.5, color: HexColor('#8B99A7'))),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget bankComponent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Row(
        children: [
          ClipRRect(
              child: Image.memory(
                getdDtaUrlImage(branchImage),
                width: 48,
                height: 48,
              ),
              borderRadius: BorderRadius.circular(48 / 2)),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 3),
                  child: Container(
                    width: widthAdjuster(
                        screenWidth: MediaQuery.of(context).size.width,
                        widthMod: 0.7),
                    child: Text(
                      '${contractBankBrandname.bankName()}',
                      style: size16CBlackBlueW600.merge(TextStyle(
                          fontFamily: 'NotoSansThaiSemiBold', height: 1.21)),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                        '${contractBankAccount.replaceAllMapped(RegExp(r'(\d{3})(\d{1})(\d{5})(\d+)'), (Match m) => "${m[1]}-${m[2]}-${m[3]}-${m[4]}")}',
                        style: size16CBlackBlueW600.merge(TextStyle(
                            color: HexColor('#404040'),
                            letterSpacing: 0,
                            fontFamily: 'NotoSansThai')))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget renderBankCompoenent(BuildContext context) {
    bool isBankEmpty = branchImage == '' ||
        contractBankAccount == '' ||
        contractBankBrandname == '';
    if (!isBankEmpty) {
      return bankComponent(context);
    } else {
      return bankHandler(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 21, bottom: 6),
              child: Text(
                'เลขที่บัญชี',
                style: (TextStyle(color: HexColor('#646464'))),
              ),
            )),
        Container(
          width: widthAdjuster(
              screenWidth: MediaQuery.of(context).size.width, widthMod: 0.9),
          height: 84,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            border: Border.all(
              color: Color.fromRGBO(229, 229, 229, 1),
              width: 1,
            ),
          ),
          child: renderBankCompoenent(context),
        )
      ],
    );
  }
}
