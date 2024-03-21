import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_srisawad/widgets/buttons/secondary_button.dart';
import 'package:mobile_application_srisawad/widgets/dialog/base_dialog.dart';

import '../../bloc/page_result/page_result_bloc.dart';
import '../buttons/primary_button.dart';

changeCancellingDialog(BuildContext context, Function onPress,
    [bool isShowNavigationWhenBack = true]) {
  baseDialog1(
      context: context,
      title: 'คุณยืนยันที่จะออกจากหน้านี้หรือไม่?',
      content: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Text(
          'หากคุณยืนยันที่จะออกจากหน้านี้ข้อมูลที่คุณ\nดำเนินการอยู่จะสูญหายทั้งหมด',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.merge(TextStyle(
              color: Theme.of(context).colorScheme.tertiaryContainer)),
        ),
      ),
      Buttons: [
        Expanded(
          child: SecondaryButton(
            textButton: 'กลับ',
            CallBack: () =>
                Navigator.of(context, rootNavigator: true).pop('dialog'),
          ),
        ),
        Expanded(
          child: PrimaryButton(
              textButton: 'ยืนยัน',
              CallBack: () async {
                Navigator.of(context, rootNavigator: true).pop('dialog');
                await onPress();
                if (isShowNavigationWhenBack) {
                  BlocProvider.of<PageResultBloc>(context)
                      .add(SetButtonNavigator(true));
                }
              }),
        )
      ]);
}
