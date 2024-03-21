import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../util/width_until.dart';
import '../topup_styling.dart';

class RowContent extends StatelessWidget {
  String Header;
  String Subline;
  String CarryType;

  bool addSpace;
  RowContent(
      {super.key,
      required String this.Header,
      required String this.Subline,
      required String this.CarryType,
      bool this.addSpace = true});

  @override
  Widget build(BuildContext context) {
    TextStyle rightContentStyle = TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: HexColor('#404040'),
        fontFamily: 'NotoSansThaiSemiBold');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Header,
            style: rightContentStyle,
          ),
          Text(
            Subline + (addSpace ? ' ' : '') + CarryType,
            style: rightContentStyle,
          ),
        ],
      ),
    );
  }
}

class ButtonType extends StatelessWidget {
  String NameType;
  VoidCallback onpress;
  ButtonType({super.key, required String this.NameType, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: onpress,
        child: Container(
          height: 69,
          width: widthAdjuster(
              screenWidth: MediaQuery.of(context).size.width, widthMod: 0.90),
          decoration: BoxDecoration(
              border: Border.all(
                color: HexColor('#E5E5E5'),
              ),
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/document-icon.svg'),
                      Padding(
                        padding: const EdgeInsets.only(top: 3,left: 16),
                        child: Text(
                          NameType,
                          style: size16WNormal
                              .merge(TextStyle(fontWeight: FontWeight.w500)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset('assets/caret-right-document.svg')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
