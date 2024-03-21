import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class LeadButton extends StatelessWidget {
  final String text;
  final String backgroundColor;
  final Function buttonCallBack;
  final bool isEnable;

  const LeadButton(
      {required this.text,
        required this.buttonCallBack,
        required this.backgroundColor,
        required this.isEnable});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: GestureDetector(
        onTap: () {
          if (isEnable) {
            buttonCallBack.call();
          }
        },
        child: Opacity(
          opacity: getOpacity(),
          child: Container(
              decoration: BoxDecoration(
                color: HexColor(backgroundColor),
                borderRadius: const BorderRadius.all(Radius.circular(14)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Text(text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSansThai(
                      fontSize: 16,
                      color: HexColor('#FFFFFF'),
                      fontWeight: FontWeight.w600,
                    )
                  // style:

                  //     TextStyle(color: isTextBlack ? Colors.black : Colors.white,),
                ),
              )),
        ),
      ),
    );
  }

  double getOpacity() {
    if (isEnable) {
      return 1;
    } else {
      return 0.5;
    }
  }
}
