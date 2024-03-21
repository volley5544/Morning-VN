import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';
import 'base_dialog.dart';

// Navigator.of(context).restorablePush(serverError2Dialog(context));
noResultFound(BuildContext context) {
  baseDialog1(
      imageWidget: SvgPicture.asset('assets/notFoundIcon.svg'),
      context: context,
      title: 'ไม่พบการค้นหา',
      content: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Text(
          'กรุณาพิมพ์การค้นหาใหม่อีกครั้ง',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.merge(TextStyle(
              color: Theme.of(context).colorScheme.tertiaryContainer)),
        ),
      ),
      Buttons: [
        Expanded(
          child: PrimaryButton(
            textButton: 'ปิด',
            CallBack: () =>
                Navigator.of(context, rootNavigator: true).pop('dialog'),
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
          ),
        ),
      ]);
}
