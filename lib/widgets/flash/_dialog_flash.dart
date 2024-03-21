import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void showDialogFlash(
    {bool persistent = true,
    required BuildContext context,
    required String title,
    required Widget content,
    required String buttonText}) {
  context.showFlashDialog(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      constraints: BoxConstraints(maxWidth: 300),
      persistent: persistent,
      // title: Text(title),
      content: content,
      negativeActionBuilder: (context, controller, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: Container(
            decoration: BoxDecoration(
              color: HexColor('#DB771A'),
              borderRadius: const BorderRadius.all(Radius.circular(14)),
            ),
            width: 300,
            height: 60,
            child: TextButton(
              onPressed: () {
                controller.dismiss();
              },
              child: Text(
                buttonText,
                style: TextStyle(
                    fontFamily: 'NotoSansThai',
                    color: HexColor('#FFFFFF'),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        );
      });
}

void noResultDialogFlash({
  bool persistent = true,
  required BuildContext context,
  required String title,
  required Widget content,
  // required Function callBack,
}) {
  context.showFlashDialog(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      constraints: BoxConstraints(maxWidth: 300),
      persistent: persistent,
      // title: Text(title),
      content: content,
      onTap: ((context, controller, setState) {
        controller.dismiss();
      }));
}
