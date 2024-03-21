import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '_dialog_flash.dart';
import 'top_flash.dart';

void otpFail(
    {required String title,
    required String body,
    required BuildContext context,
    required String buttonText}) {
  final Widget contents = FlashBar(
    content: Column(
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.merge(TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
        Align(
          alignment: Alignment.center,
          child: Text(
            body,
            style: TextStyle(
              fontFamily: 'NotoSansThai',
              height: 1.51071429,
              letterSpacing: 0.3,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(100, 100, 100, 1),
            ),
          ),
        ),
      ],
    ),
    showProgressIndicator: false,
  );
  showDialogFlash(
      content: contents,
      context: context,
      title: title,
      buttonText: buttonText);
}
