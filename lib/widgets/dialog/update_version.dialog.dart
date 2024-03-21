import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_application_srisawad/widgets/buttons/primary_button.dart';
import 'package:mobile_application_srisawad/widgets/dialog/base_dialog.dart';

updateVersionDialog(BuildContext context) {
  baseDialog1(
      context: context,
      imageWidget: LottieBuilder.asset('assets/update.json'),
      title: 'กรุณาอัปเดตแอปพลิเคชัน',
      content: Text(
        'แอปพลิเคชันศรีสวัสดิ์มีเวอร์ชันใหม่\nอัปเดตเพื่อประสบการณ์การใช้งานที่ดีขึ้น',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.merge(
            TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
      ),
      Buttons: [
        Expanded(
          child: PrimaryButton(
              textButton: 'อัปเดต',
              CallBack: () =>
                  Navigator.of(context, rootNavigator: true).pop('dialog'),
              padding: const EdgeInsets.only(),
              width: MediaQuery.of(context).size.width * 0.65),
        )
      ]);
}
