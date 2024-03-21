import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/models/payment_detail.dart';
import 'dart:math' as math;
import 'package:mobile_application_srisawad/util/currentcy_format.dart';

class OptionModel {
  bool loanDetail = true;
  bool paymentDetail = false;
  bool historylist = false;
  OptionModel(
      {required this.loanDetail,
      required this.paymentDetail,
      required this.historylist});
}

class SlidingLoanOptions extends StatelessWidget {
  final String optionName;
  final String focusedOption;
  final Function onLoanOptionSelected;
  const SlidingLoanOptions(
      {required this.onLoanOptionSelected,
      required this.optionName,
      required this.focusedOption});

  Widget renderSelectableOption() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
      child: GestureDetector(
        onTap: () => onLoanOptionSelected(optionName),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.16),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: focusedOption == optionName
                ? HexColor('003063')
                : HexColor('#FFFFFF'),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Center(
              child: Text(
                optionName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: focusedOption == optionName
                        ? HexColor('#FFFFFF')
                        : HexColor('003063'),
                    fontFamily: 'NotoSansThaiSemiBold',
                    fontSize: 16,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                    height: 1.5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return renderSelectableOption();
  }
}
