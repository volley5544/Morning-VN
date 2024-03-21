import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_application_srisawad/main.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';
import 'base_dialog.dart';

// Navigator.of(context).restorablePush(serverError2Dialog(context));
registerFailDialog(BuildContext context, {String? additionalText = null}) {
  showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      // color: Colors.amber,
                      height: 170,
                      width: 170,
                      // margin: EdgeInsets.symmetric(horizontal: 40),
                      child: Lottie.asset('assets/srisawad-error.json')),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "ไม่สามารถทำรายการได้ขณะนี้",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.merge(
                          const TextStyle(
                              letterSpacing: -0.1,
                              fontFamily: 'NotoSansThaiSemiBold')),
                    ),
                  ),
                  Text(
                    'ขออภัย กรุณาลองใหม่อีกครั้ง',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.merge(
                        TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .tertiaryContainer)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  PrimaryButton(
                    width: getActualWidth(context),
                    textButton: 'ตกลง',
                    CallBack: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                      // Navigator.of(context).pop();
                    },
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  ),
                ]));
      });
}
