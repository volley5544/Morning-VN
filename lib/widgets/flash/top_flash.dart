import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

void showTopFlash(
    {FlashBehavior style = FlashBehavior.floating,
    required Widget contents,
    required BuildContext context,
    Color barrierColor = Colors.black38,
    int duration = 3,
    EdgeInsets? margin}) {
  showFlash(
    context: context,
    duration: Duration(seconds: duration),
    persistent: true,
    builder: (_, controller) {
      return Flash(
        controller: controller,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        // boxShadows: [BoxShadow(blurRadius: 4)],
        barrierBlur: 0,
        barrierColor: barrierColor,
        barrierDismissible: false,
        behavior: style,
        position: FlashPosition.top,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: contents,
        margin: margin ?? EdgeInsets.zero,
      );
    },
  );
}
