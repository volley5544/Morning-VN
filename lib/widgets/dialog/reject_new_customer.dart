import 'package:flutter/material.dart';
import 'package:mobile_application_srisawad/widgets/dialog/base_dialog.dart';

import '../buttons/primary_button.dart';

rejectNewCustomer(BuildContext context) {
  baseDialog1(
      context: context,
      title: 'ไม่พบสินเชื่อของคุณ',
      content: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
        child: Text(
          'กรุณาตรวจสอบความถูกต้องของหมายเลข\nบัตรประชาชนและเบอร์โทรศัพท์ของคุณอีกครั้ง', //'ขออภัยค่ะ แอปพลิเคชันเวอร์ชันนี้ รองรับสำหรับ\n ลูกค้าที่มีสินเชื่อกับทางศรีสวัสดิ์อยู่แล้ว',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.merge(TextStyle(
              color: Theme.of(context).colorScheme.tertiaryContainer)),
        ),
      ),
      Buttons: [
        Expanded(
          child: PrimaryButton(
            padding: EdgeInsets.zero,
            textButton: 'ปิด',
            CallBack: () =>
                Navigator.of(context, rootNavigator: true).pop('dialog'),
          ),
        )
      ]);
}
