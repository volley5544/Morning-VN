import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

openAppSettingDialog(
    {required BuildContext context,
    required String title,
    Widget? icon,
    required String detail,
    Function? onCancel,
    Function? onGoToSetting}) {
  showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 22),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.merge(
                    const TextStyle(
                        letterSpacing: -0.1,
                        fontFamily: 'NotoSansThaiSemiBold')),
              ),
              getIconSection(icon),
              Text(
                detail,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                        textButton: 'ยกเลิก',
                        CallBack: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          onCancel?.call();
                        }),
                  ),
                  Expanded(
                    child: PrimaryButton(
                        textButton: 'เปิดการตั้งค่า',
                        CallBack: () async {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          openAppSettings();
                          onGoToSetting?.call();
                        }),
                  )
                ],
              ),
            ],
          ),
        );
      });
}

getIconSection(Widget? icon) {
  if (icon == null) {
    return SizedBox(
      height: 16,
    );
  } else {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 22),
      child: icon,
    );
  }
}
