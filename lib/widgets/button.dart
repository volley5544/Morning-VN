import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Button extends StatelessWidget {
  final String textButton;
  final String color;
  final bool isTextBlack;
  // final double width;
  final double height;
  final Function buttonCallBack;

  const Button(
      {required this.color,
      required this.isTextBlack,
      // required this.width,
      required this.height,
      required this.textButton,
      required this.buttonCallBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: GestureDetector(
        onTap: () => buttonCallBack(),
        child: Container(
            height: height,
            // width: width,
            decoration: BoxDecoration(
              color: Color(int.parse('0xff$color')),
              borderRadius: const BorderRadius.all(Radius.circular(14)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Center(
                  child: Text(textButton,
                      style: TextStyle(
                          color:
                              isTextBlack ? HexColor('#DB771A') : Colors.white,
                          fontFamily: 'NotoSansThaiSemiBold',
                          fontSize: 16,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600,
                          height: 1)
                      // style:

                      //     TextStyle(color: isTextBlack ? Colors.black : Colors.white,),
                      )),
            )),
      ),
    );
  }
}
