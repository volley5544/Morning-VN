import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/widgets/dialog/base_dialog.dart';

penaltyCountDown(BuildContext context, int nextPenaltyTime) {
  onForgotPress() async {
    Navigator.of(context, rootNavigator: true).pop();
    await Navigator.of(context).pushNamed('/forgotpasscode-page');
  }

  baseDialog1(
      context: context,
      title: 'รหัสผ่านไม่ถูกต้อง',
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
            child: Text(
              'เนื่องจากคุณใส่รหัสผ่านผิดหลายครั้ง คุณจะสามารถใส่รหัสผ่านได้อีกครั้งใน',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.merge(TextStyle(
                  color: Theme.of(context).colorScheme.tertiaryContainer)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TimerCounter(
            countTime: nextPenaltyTime,
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              onForgotPress();
            },
            child: Text('ลืมรหัสผ่าน?',
                style: Theme.of(context).textTheme.labelSmall?.merge(TextStyle(
                      fontFamily: 'NotoSansThaiSemiBold',
                      color: HexColor('#DB771A'),
                      decoration: TextDecoration.underline,
                    ))),
          )
        ],
      ),
      inputPadding:
          const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 10));
}

String _pad2(int i) => i.toString().padLeft(2, '0');

// ignore: must_be_immutable
class TimerCounter extends StatefulWidget {
  late int countTime;
  TimerCounter({super.key, required this.countTime});

  @override
  State<TimerCounter> createState() => _TimerCounterState();
}

class _TimerCounterState extends State<TimerCounter> {
  late int timetmp = -1;
  @override
  void initState() {
    timetmp = widget.countTime;
    Timer.periodic(new Duration(seconds: 1), (timer) {
      if (timetmp <= 1) {
        timer.cancel();
        Navigator.of(context).pop(context);
      }
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        timetmp = timetmp - 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tmpTime = Duration(seconds: timetmp);
    final hours = _pad2(tmpTime.inHours);
    final minutes = _pad2(tmpTime.inMinutes % 60);
    final seconds = _pad2(tmpTime.inSeconds % 60);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              height: 18,
            ),
            Text('$hours : $minutes : $seconds',
                style: Theme.of(context).textTheme.titleLarge!.merge(TextStyle(
                      fontSize: 36,
                      height: 1,
                      color: Color.fromRGBO(29, 113, 184, 1),
                    ))),
            Text(
              'ชั่วโมง           นาที            วินาที ',
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        )
      ],
    );
  }
}
