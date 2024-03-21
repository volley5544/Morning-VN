import 'package:flutter/material.dart';
import 'package:mobile_application_srisawad/widgets/dialog/base_dialog.dart';

import '../../main.dart';
import '../buttons/primary_button.dart';

otpFailDialog(BuildContext context) {
  showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 22,
              ),
              Text(
                'รหัส OTP ไม่ถูกต้อง',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.merge(
                    const TextStyle(
                        letterSpacing: -0.1,
                        fontFamily: 'NotoSansThaiSemiBold')),
              ),
              SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'กรุณาใส่รหัสผ่านใหม่อีกครั้ง',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.merge(
                      TextStyle(
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer)),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.all(Radius.circular(14)),
                      ),
                      child: Center(
                        child: Text("ปิด",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.labelSmall?.merge(
                                TextStyle(
                                    letterSpacing: 0,
                                    fontFamily: 'NotoSansThaiSemiBold'))),
                      ),
                    ),
                  ))
            ],
          ),
        );
      });
}
