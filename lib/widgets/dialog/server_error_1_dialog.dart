import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../buttons/primary_button.dart';
import 'base_dialog.dart';

// Navigator.of(context).restorablePush(serverErrorDialog(context));
serverErrorDialog(BuildContext context) {
  baseDialog1(
      context: context,
      imageWidget: Lottie.asset('assets/error.json'),
      title: 'ไม่สามารถทำรายการได้ขณะนี้',
      content: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Text(
          'ขออภัย กรุณาลองใหม่อีกครั้ง',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.merge(TextStyle(
              color: Theme.of(context).colorScheme.tertiaryContainer)),
        ),
      ),
      Buttons: [
        Expanded(
          child: PrimaryButton(
              textButton: 'รับทราบ',
              CallBack: () =>
                  Navigator.of(context, rootNavigator: true).pop('dialog'),
              width: 275),
        )
      ]);
}
