import 'package:flutter/material.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';
import 'base_dialog.dart';

// Navigator.of(context).restorablePush(ocrNotFoundDialog(context));
ocrNotFoundDialog(BuildContext context) {
  baseDialog1(
      context: context,
      imageWidget: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Image.asset('assets/thai-id-not-found.png'),
      ),
      title: 'ไม่พบเลขบัตรประชาชนของคุณ',
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'ภาพหน้าบัตรไม่ชัด กรุณาลองใหม่อีกครั้งโดยการหลีกเลี่ยงแสงสะท้อน',
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
            padding: const EdgeInsets.only(),
          ),
        )
      ]);
}
