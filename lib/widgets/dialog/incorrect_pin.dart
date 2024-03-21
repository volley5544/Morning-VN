import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

inCorrectPin(BuildContext context, Function onPress, int counter) {
  showDialog<void>(
      barrierDismissible: false,
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
                "รหัสผ่านไม่ถูกต้อง",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.merge(
                    const TextStyle(
                        letterSpacing: -0.1,
                        fontFamily: 'NotoSansThaiSemiBold')),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  SvgPicture.asset('assets/passcode-error 1.svg'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
                    child: Text(
                      'กรุณาใส่รหัสผ่านใหม่อีกครั้ง',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.merge(TextStyle(
                          color: Theme.of(context).colorScheme.tertiaryContainer)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
                    child: Text(
                      'หมายเหตุ: คุณสามารถใส่ได้อีก' ' ' '$counter' ' ครั้ง',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.merge(TextStyle(color: HexColor('#A02802'))),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: HexColor('#DB771A'),
                        borderRadius: BorderRadius.circular(14)),
                    height: 60,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        onPress();
                      },
                      child: Text('ปิด', style: Theme.of(context).textTheme.labelSmall),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
