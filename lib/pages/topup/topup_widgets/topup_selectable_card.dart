import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_styling.dart';

import '../../../bloc/topup_bloc/topup_bloc.dart';
import '../../../util/currentcy_format.dart';
import '../../../util/width_until.dart';

class TopupSelectableCard extends StatelessWidget {
  final int installmentNumber;
  final double amountPerInstallment;
  final bool isCardSelected;
  const TopupSelectableCard(
      {Key? key,
      required this.installmentNumber,
      required this.amountPerInstallment,
      required this.isCardSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthAdjuster(
          screenWidth: MediaQuery.of(context).size.width, widthMod: 0.87),
      height: 66,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Color.fromRGBO(255, 255, 255, 1),
        border: Border.all(
          color: isCardSelected
              ? HexColor('#DB771A')
              : Color.fromRGBO(229, 229, 229, 1),
          width: 1,
        ),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.only(left: 18, top: 3),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            isCardSelected
                ? SvgPicture.asset('assets/SelectedEclipseOption.svg')
                : SvgPicture.asset('assets/UnselectedEclipseOption.svg'),
            Padding(
              padding: const EdgeInsets.only(left: 14.2),
              child: Text(
                '${this.installmentNumber.toString()} งวด',
                style: size16CBlackBlue
                    .merge(TextStyle(fontWeight: FontWeight.w500)),
              ),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, top: 5),
          child: Text(
              '฿${convertDoubleCurrentcy(this.amountPerInstallment)} บาท/เดือน',
              style: size16WNormal),
        )
      ]),
    );
  }
}
