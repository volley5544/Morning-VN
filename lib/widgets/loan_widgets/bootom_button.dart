import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_application_srisawad/widgets/button.dart';
import 'package:mobile_application_srisawad/widgets/button.dart';

import '../../main.dart';

class BootomButton extends StatelessWidget {
  final Function onButtonTap;
  final String title;
  final bool? isOpacity;
  final bool? decoration;
  final double? width;
  BootomButton(
      {required this.onButtonTap,
      required this.title,
      this.isOpacity,
      this.decoration,
      this.width});

  BoxDecoration defaultDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
            offset: Offset(0, 1),
            blurRadius: 10)
      ],
      color: Color.fromRGBO(255, 255, 255, 1),
    );
  }

  BoxDecoration setBoxDecoration(bool? decorate) {
    if (decorate != null) {
      if (decorate) {
        return BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
                offset: Offset(0, 1),
                blurRadius: 10)
          ],
        );
      }
      return BoxDecoration();
    }
    return defaultDecoration();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isOpacity != null
          ? isOpacity!
              ? 0.5
              : 1
          : 1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22),
        width: width ?? getActualWidth(context),
        height: 118,
        decoration: setBoxDecoration(decoration),
        child: Column(
          children: [
            Button(
              buttonCallBack: onButtonTap,
              color: 'DB771A',
              height: 60,
              isTextBlack: false,
              textButton: title,
            ),
          ],
        ),
      ),
    );
  }
}
