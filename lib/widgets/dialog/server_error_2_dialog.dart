import 'package:flutter/material.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';
import 'base_dialog.dart';

// Navigator.of(context).restorablePush(serverError2Dialog(context));
serverError2Dialog(BuildContext context) {
  baseDialog1(
      context: context,
      title: 'คุณยืนยันที่จะออกจากหน้านี้หรือไม่?',
      content: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Text(
          'หากคุณยืนยันที่จะออกจากหน้านี้ข้อมูลที่คุณดำเนินการอยู่จะสูญหายทั้งหมด',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.merge(TextStyle(
              color: Theme.of(context).colorScheme.tertiaryContainer)),
        ),
      ),
      Buttons: [
        Expanded(
          child: PrimaryButton(
            textButton: 'กลับ',
            CallBack: () =>
                Navigator.of(context, rootNavigator: true).pop('dialog'),
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          ),
        ),
        Expanded(
          child: SecondaryButton(
              textButton: 'ยืนยัน',
              CallBack: () =>
                  Navigator.of(context, rootNavigator: true).pop('dialog'),
              padding: const EdgeInsets.only()),
        )
      ]);
}
