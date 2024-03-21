import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile_application_srisawad/main.dart';

import '../button.dart';

class DuoButton extends StatelessWidget {
  final Function onRightButtonTap;
  final Function onLeftButtonTap;
  final String leftTitle;
  final String rightTitle;
  final bool? isOpacity;
  const DuoButton(
      {Key? key,
      required this.onRightButtonTap,
      required this.rightTitle,
      this.isOpacity,
      required this.leftTitle,
      required this.onLeftButtonTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isOpacity != null
          ? isOpacity!
              ? 0.5
              : 1
          : 1,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 118,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
                offset: Offset(0, 1),
                blurRadius: 10)
          ],
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Button(
                  buttonCallBack: onLeftButtonTap,
                  color: 'FCEFE4',
                  height: 60,
                  isTextBlack: true,
                  textButton: leftTitle,
                  // width: getActualWidth(context) * 0.325,
                  // width: 160,
                ),
              ),
              Container(
                width: 11,
              ),
              Expanded(
                child: Button(
                  buttonCallBack: onRightButtonTap,
                  color: 'DB771A',
                  height: 60,
                  isTextBlack: false,
                  textButton: rightTitle,
                  // width: getActualWidth(context) * 0.325,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
