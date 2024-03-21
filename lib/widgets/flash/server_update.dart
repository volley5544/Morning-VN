import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '_dialog_flash.dart';
import 'top_flash.dart';

void severUpdate(
    {required String title,
    required String body,
    required BuildContext context,
    required String buttonText}) {
  final Widget contents = FlashBar(
    content: Column(
      children: [
        LottieBuilder.asset('assets/update.json'),
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.merge(TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
        Align(
          alignment: Alignment.center,
          child: Text(
            body,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.merge(TextStyle(
                color: Theme.of(context).colorScheme.tertiaryContainer)),
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
