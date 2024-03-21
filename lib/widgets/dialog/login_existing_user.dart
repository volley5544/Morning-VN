import 'package:flutter/material.dart';
import 'package:mobile_application_srisawad/widgets/buttons/secondary_button.dart';
import 'package:mobile_application_srisawad/widgets/dialog/base_dialog.dart';

import '../buttons/primary_button.dart';

loginExistingUser(BuildContext context, Function onClickLoginButton) {
  showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 5),
                    child: Text(
                      "คุณมีบัญชีอยู่ในระบบแล้ว",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.merge(
                          const TextStyle(
                              letterSpacing: -0.1,
                              fontFamily: 'NotoSansThaiSemiBold')),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    'หมายเลขบัตรประชาชนของคุณเคยลงทะเบียนกับทางแอปพลิเคชันศรีสวัสดิ์แล้ว',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.merge(
                        TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .tertiaryContainer)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SecondaryButton(
                          width: 130,
                          textButton: 'ปิด',
                          padding: EdgeInsets.only(left: 4),
                          CallBack: () =>
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog'),
                        ),
                      ),
                      Expanded(
                        child: PrimaryButton(
                            width: 136,
                            textButton: 'เข้าสู่ระบบ',
                            CallBack: () async {
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              onClickLoginButton.call();
                            }),
                      ),
                    ],
                  )
                ]));
      });
}
