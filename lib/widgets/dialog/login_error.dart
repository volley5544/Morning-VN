import 'package:flutter/material.dart';
import 'package:mobile_application_srisawad/widgets/buttons/secondary_button.dart';
import 'package:mobile_application_srisawad/widgets/dialog/base_dialog.dart';

import '../buttons/primary_button.dart';

loginWithErrorDialog(BuildContext context) {
  baseDialog1(
      context: context,
      title: 'ไม่พบบัญชีผู้ใช้ของคุณ',
      content: Padding(
        padding: const EdgeInsets.fromLTRB(2, 16, 2, 0),
        child: Text(
          'กรุณาตรวจสอบความถูกต้องหรือหากคุณยังไม่มีบัญชีผู้ใช้กรุณาสมัครสมาชิกก่อนเข้าสู่ระบบ',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.merge(TextStyle(
              color: Theme.of(context).colorScheme.tertiaryContainer)),
        ),
      ),
      Buttons: [
        Expanded(
          child: SecondaryButton(
            width: 134,
            textButton: 'ปิด',
            CallBack: () =>
                Navigator.of(context, rootNavigator: true).pop('dialog'),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: PrimaryButton(
              width: 134,
              textButton: 'สมัครสมาชิก',
              CallBack: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
                Navigator.of(context).pushNamed('/register-fill-page');
              },
              padding: EdgeInsets.zero),
        ),
      ]);
}
